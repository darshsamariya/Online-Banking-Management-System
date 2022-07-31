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
import com.bankmvc.entities.loan;
import com.bankmvc.hmac.hmac;

@Controller
public class c_controller {
	@Autowired    
    customerdaoimpel cdao;
	
	hmac hx=new hmac();
	@RequestMapping("/insertcus")  //insert customer
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
	
	@RequestMapping(value="/transfer",method=RequestMethod.POST)   //transfer from customer to customer
	public String transfer(@RequestParam("c_id") String c_id,@RequestParam("account")String account,@RequestParam("amount") double amount,@RequestParam("password") String password,HttpSession hs) throws InvalidKeyException, NoSuchAlgorithmException
	{
		 amount = Math.round(amount*100.0)/100.0;
		//System.out.println(hs);
		 password=hx.change((String)hs.getAttribute("email"),password);
double net=0;
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
		loan l=(loan)hs.getAttribute("loan_id");
		if(l!=null)
		{
			System.out.println(l.toString());

		/*	if(amount>l.getAmt_left())
			{
				hs.setAttribute("fund","You are paying  extra amount please recheck");
				return "redirect:dash-cus";
			}
			net=(double)(l.getAmt_left()*l.getRoi())/(double)100;  //calculate interest
			net=net+amount;
			net=Math.round(net*100.0)/100.0;
			if(c.getBalance()<net)
			{
				hs.setAttribute("fund","Less Balance");
				return "redirect:dash-cus";
			}
			*/
			if(c.getBalance()<amount)
			{
				hs.setAttribute("fund","Less Balance");
				return "redirect:dash-cus";
			}
			double afterint=0;
			if(amount<l.getInt_val())
			{
				net=0;
			afterint=l.getInt_val()+(l.getInt_val()-amount);
			afterint=(double)(afterint*100.0)/100.0;
			}
			else
			{
				net=amount-l.getInt_val();
				net=Math.round(net*100.0)/100.0;
				System.out.println(amount+"   "+l.getAmt_left()+"  "+net+"   "+l.getInt_val());
				afterint=l.getAmt_left()-net;
				afterint=(double)(afterint*l.getRoi())/100.0;
				afterint=Math.round(afterint*100.0)/100.0;
				
			}
			if(net>l.getAmt_left())
			{
				hs.setAttribute("fund","You are paying  extra amount please recheck");
				return "redirect:dash-cus";
			}
		System.out.println(c.getDebit()+"  my debit net=?"+net);
			cdao.cleardebit(l.getLoan_id(),(l.getAmt_left()-net),l.getNet_val()+amount,c.getDebit()-net,c.getC_id(),afterint);
			c.setDebit(c.getDebit()-net);
			System.out.println(c.getDebit()+"  "+net);
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
	
	
	@RequestMapping("/dash-cus")            //customer dashboard
	public ModelAndView dash(HttpSession hs)
	{
		ModelAndView mv=new ModelAndView();
		customer c=(customer)hs.getAttribute("customer");
		String block=(String)hs.getAttribute("block");
		  hs.removeAttribute("loan_id");
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
	
	@RequestMapping(value="/applyloan",method=RequestMethod.POST)       //loan application
	public String applyloan(@RequestParam("req") String req,@RequestParam("amt") double amount,@RequestParam("data") String data,@RequestParam("pass") String password,HttpSession hs) throws NoSuchAlgorithmException, InvalidKeyException
	{
		 amount = Math.round(amount*100.0)/100.0;
			//System.out.println(hs);
		 password=hx.change((String)hs.getAttribute("email"),password);
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
				double ppm=(double)(amount/(double)month);
				double interest=(double)(amount*roi)/100.0;
				ppm=Math.round(ppm*100.0)/100.0;
				interest=Math.round(interest*100.0)/100.0;
				int r=cdao.apply(c.getC_id(),c.getFirstname(),req,c.getBalance(), amount, month, roi,"applied",ppm,interest);
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
	
	@RequestMapping(value="/getloandetails",method=RequestMethod.POST)        //getloandetails
	public String getloandetails(@RequestParam("loan_id") String loan_id,HttpSession hs)
	{
		loan l=null;
		l=cdao.getloandetail(loan_id,(String) hs.getAttribute("c_id"));
	    if(l==null)
	    {
	    	hs.setAttribute("fund","loan ID not found");
	    	return "redirect:dash-cus";
	    }
	    else if(l.getStatus().equals("rejected") || l.getStatus().equals("applied") )
	    {
	    	hs.setAttribute("fund","loan ID is Rejected or is in progress");
	    	return "redirect:dash-cus";
	    }
	    else if(l.getStatus().equals("paid"))
	    {
	    	hs.setAttribute("fund","payment already done");
	    	return "redirect:dash-cus";
	    }
		System.out.println(l.toString());
		hs.setAttribute("loan_id",l);
		return "payloan";
	}
	

}
