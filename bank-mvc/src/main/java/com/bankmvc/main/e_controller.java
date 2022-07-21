package com.bankmvc.main;

import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.sql.Date;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

import com.bankmvc.dao.customerdaoimpel;
import com.bankmvc.dao.employeedaoimpel;
import com.bankmvc.entities.customer;
import com.bankmvc.entities.employee;

@Controller
public class e_controller {
	@Autowired
employeedaoimpel edao;
	
	@Autowired
	customerdaoimpel cdao;
	
	@RequestMapping("/insertemp")
	public String insertemp(@ModelAttribute employee e,HttpSession hs)
	{
		System.out.println(e.toString());
		int r=edao.insertemployee(e);
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
	
	@RequestMapping("/dash-emp")
	public ModelAndView emp(HttpSession hs)
	{
		ModelAndView mv=new ModelAndView();
		employee e=(employee)hs.getAttribute("employee");
		String block=(String)hs.getAttribute("block");
		mv=new ModelAndView();
		if(block==null)
		{
			mv.setViewName("redirect:home");
			return mv;
		}
		mv.addObject("u",e);
		System.out.println("inside dash  emp");
		//System.out.println(mv);
		mv.setViewName("dash-emp");
		return mv;
	}
	
	

	@RequestMapping(value="/deposit",method=RequestMethod.POST)
	public String transfer(@RequestParam("c_id") String c_id,@RequestParam("account")String account,@RequestParam("amount") double amount,@RequestParam("password") String password,HttpSession hs) throws NoSuchAlgorithmException, InvalidKeyException
	{
		  amount = Math.round(amount*100)/100;
		//System.out.println(hs);
		employee e=(employee)hs.getAttribute("employee");
//		System.out.println(c.toString());
		String secret=(String)hs.getAttribute("email");
		String message=password;
		Mac sha256=Mac.getInstance("HmacSHA256");
		SecretKeySpec s_key=new SecretKeySpec(secret.getBytes(),"HmacSHA256");
		sha256.init(s_key);
		String hash=Base64.encodeBase64String(sha256.doFinal(message.getBytes()));
		password=hash;

		 if(password.equals(e.getPassword())==false)
		{
			hs.setAttribute("fund","password not match");
			return "redirect:dash-emp";
		}
		else {
		customer k=cdao.check(c_id, account, "check");
		if(k==null)
		{
			hs.setAttribute("fund","account not exist");
			return "redirect:dash-emp";
		}
		System.out.println("Tranfer to "+k.toString());
			edao.deposit(e.getE_id(),c_id,k.getFirstname(),"Cash Deposit",amount,0,k.getBalance(),k.getBalance()+amount);
			hs.setAttribute("fund","Transfer Done successfully");
			k.setBalance(k.getBalance()+amount);
			return "redirect:dash-emp";
		}
	//	hs.removeAttribute("customer");
		
	}
	
	@RequestMapping(value = "/getcustomer" , method = RequestMethod.POST)
   public String getcustomer(@RequestParam("cid") String cid,ModelAndView mv,HttpSession hs)
   {
		
		customer c=cdao.check(cid,cid,"get");
		if(c==null)
		{
			hs.setAttribute("fund","account not exist");
			return "redirect:dash-emp";
		}
hs.setAttribute("custid",c);
System.out.println(c.toString());
		return "custdetails";
   }
	
	@RequestMapping(value="/unblock",method=RequestMethod.POST)
	public String unblock(@RequestParam("cid") String cid,HttpSession hs)
	{
		cdao.update(cid, 4,1,"unblock");
		hs.removeAttribute("custid");
		hs.setAttribute("fund","Account Activated successfully");
		return  "redirect:dash-emp";
	}
	
	
	@RequestMapping(value = "/customdate" , method = RequestMethod.POST)
	public String getcustomdate(@RequestParam("d1") String d1,@RequestParam String d2,HttpSession hs)
	{
		System.out.println(d1);
		System.out.println(d2);
		hs.setAttribute("date1",d1);
		hs.setAttribute("date2",d2);
		return "custdetails";
	}
	
}
