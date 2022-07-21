package com.bankmvc.main;

import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.bankmvc.dao.customerdaoimpel;
import com.bankmvc.entities.customer;

@Controller
public class c_controller {
	@Autowired    
    customerdaoimpel cdao;
	@RequestMapping("/insertcus")
	public String insertcus(@ModelAttribute customer c,Model m,HttpSession hs)
	{
		
		System.out.println("inside");
		int r=cdao.insertcustomer(c);
		if(r==1)
		{
	hs.setAttribute("message","Account created successfully");
		}
		else if(r==2)
		{
			hs.setAttribute("message","Account already exist");
		}
		else
		{
			hs.setAttribute("message","Error Occured");
		}


		return "redirect:home";
	}
	
	@RequestMapping(value="/transfer",method=RequestMethod.POST)
	public String transfer(@RequestParam("c_id") String c_id,@RequestParam("account")String account,@RequestParam("amount") double amount,@RequestParam("password") String password,HttpSession hs) throws InvalidKeyException, NoSuchAlgorithmException
	{
		 amount = Math.round(amount*100)/100;
		//System.out.println(hs);
		String secret=(String)hs.getAttribute("email");
		String message=password;
		Mac sha256=Mac.getInstance("HmacSHA256");
		
		SecretKeySpec s_key=new SecretKeySpec(secret.getBytes(),"HmacSHA256");
		sha256.init(s_key);
		String hash=Base64.encodeBase64String(sha256.doFinal(message.getBytes()));
		password=hash;

		customer c=(customer)hs.getAttribute("customer");
		if(c.getBalance()<amount)
		{
			hs.setAttribute("fund","Less Balance");
			return "redirect:dash-cus";
		}
		else if(password.equals(c.getPassword())==false)
		{
			hs.setAttribute("fund","password not match");
			return "redirect:dash-cus";
		}
		else {
		customer k=cdao.check(c_id, account, "check");
		if(k==null)
		{
			hs.setAttribute("fund","account not exist");
			return "redirect:dash-cus";
		}
		System.out.println("Tranfer to "+k.toString());
			cdao.transferdebit(c.getC_id(),c_id,account,k.getFirstname(),0,amount,c.getBalance(),c.getBalance()-amount);
			cdao.transferdebit(c_id,c.getC_id(),c.getAccount(),c.getFirstname(),amount,0,k.getBalance(),k.getBalance()+amount);
		}
	//	hs.removeAttribute("customer");
		hs.setAttribute("fund","Transfer Done successfully");
		c.setBalance(c.getBalance()-amount);
		hs.setAttribute("customer",c);
		return "redirect:dash-cus";
	}
	
	
	@RequestMapping("/dash-cus")
	public ModelAndView dash(HttpSession hs)
	{
		ModelAndView mv=new ModelAndView();
		customer c=(customer)hs.getAttribute("customer");
		String block=(String)hs.getAttribute("block");
		mv=new ModelAndView();
		if(block==null)
		{
			mv.setViewName("redirect:home");
			return mv;
		}
		mv.addObject("u",c);
		System.out.println("inside dash cus");
		System.out.println(mv);
		mv.setViewName("dash-cus");
		return mv;
	}
	
	@RequestMapping(value="/applyloan",method=RequestMethod.POST)
	public String applyloan(@RequestParam("req") String req,@RequestParam("amt") double amount,@RequestParam("data") String data,@RequestParam("pass") String password,HttpSession hs) throws NoSuchAlgorithmException, InvalidKeyException
	{
		 amount = Math.round(amount*100)/100;
			//System.out.println(hs);
			String secret=(String)hs.getAttribute("email");
			String message=password;
			Mac sha256=Mac.getInstance("HmacSHA256");
			SecretKeySpec s_key=new SecretKeySpec(secret.getBytes(),"HmacSHA256");
			sha256.init(s_key);
			String hash=Base64.encodeBase64String(sha256.doFinal(message.getBytes()));
			password=hash;

			customer c=(customer)hs.getAttribute("customer");
			if(password.equals(c.getPassword())==false)
			{
				hs.setAttribute("fund","password not match");
			}
			else
			{
				String arr[]=data.split(" ");
				int month=Integer.parseInt(arr[0]);
				double roi=Double.parseDouble(arr[1]);
				double interest=((double)(amount*month*roi)/(double)(100*12));
				int r=cdao.apply(c.getC_id(),c.getFirstname(),req,c.getBalance(), amount, month, roi, interest,amount+interest,"applied");
				if(r==1)
				{
			hs.setAttribute("fund","Loan applied successfully");
				}
				else
				{
					hs.setAttribute("fund","Error Occured");
				}
			}
		return "redirect:dash-cus";
	}
}
