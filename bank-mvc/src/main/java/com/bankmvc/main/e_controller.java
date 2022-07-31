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
import com.bankmvc.hmac.hmac;

@Controller
public class e_controller {
	@Autowired
employeedaoimpel edao;
	
	@Autowired
	customerdaoimpel cdao;
	
	hmac hx=new hmac();
	
	@RequestMapping("/insertemp")   //insert employee
	public String insertemp(@ModelAttribute employee e,HttpSession hs)
	{
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
	
	@RequestMapping("/dash-emp")         //customer dashboard
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
		//System.out.println(mv);
		mv.setViewName("dash-emp");
		return mv;
	}
	
	

	@RequestMapping(value="/deposit",method=RequestMethod.POST)  //deposit money
	public String transfer(@RequestParam("c_id") String c_id,@RequestParam("account")String account,@RequestParam("amount") double amount,@RequestParam("password") String password,HttpSession hs) throws NoSuchAlgorithmException, InvalidKeyException
	{
		  amount = Math.round(amount*100.0)/100.0;
		//System.out.println(hs);
		employee e=(employee)hs.getAttribute("employee");
//		System.out.println(c.toString());
		password=hx.change((String)hs.getAttribute("email"),password);
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
			edao.deposit(e.getE_id(),c_id,k.getFirstname(),"Cash Deposit",amount,0,k.getBalance(),k.getBalance()+amount,0);
			hs.setAttribute("fund","Transfer Done successfully");
			k.setBalance(k.getBalance()+amount);
			return "redirect:dash-emp";
		}
	//	hs.removeAttribute("customer");
		
	}
	
	@RequestMapping(value = "/getcustomer" , method = RequestMethod.POST)  //get customer details
   public String getcustomer(@RequestParam("cid") String cid,ModelAndView mv,HttpSession hs)
   {
		
		customer c=cdao.check(cid,cid,"get");
		if(c==null)
		{
			hs.setAttribute("fund","account not exist");
			return "redirect:dash-emp";
		}
hs.setAttribute("custid",c);
		return "custdetails";
   }
	
	@RequestMapping(value="/unblock",method=RequestMethod.POST)   //unblock the account
	public String unblock(@RequestParam("cid") String cid,HttpSession hs)
	{
		cdao.update(cid, 4,1,"unblock");
		hs.removeAttribute("custid");
		hs.setAttribute("fund","Account Activated successfully");
		return  "redirect:dash-emp";
	}
	
	
	@RequestMapping(value = "/customdate" , method = RequestMethod.POST)  //custom date for statement
	public String getcustomdate(@RequestParam("d1") String d1,@RequestParam String d2,HttpSession hs)
	{
		hs.setAttribute("date1",d1);
		hs.setAttribute("date2",d2);
		return "custdetails";
	}
	
	@RequestMapping(value = "/loanstatus" , method = RequestMethod.POST)   //loan status
	public String loanstatus(@RequestParam("status") String status,@RequestParam("cus_id") String cus_id,@RequestParam("loan_id") String loan_id,@RequestParam("amt") Double amt, HttpSession hs)
	{
		String emp_id=(String) hs.getAttribute("e_id");
		amt=Math.round(amt*100.0)/100.0;
		if(status.equals("accept"))
		{
			customer c=cdao.check(cus_id,cus_id,"get");
			System.out.println(c.toString());
		edao.grant(loan_id,"accepted");
		edao.deposit(emp_id,c.getC_id(),c.getFirstname(),"LOAN MONEY",amt,0,c.getBalance(),c.getBalance()+amt,c.getDebit()+amt);
			hs.setAttribute("fund","Loan Granted Successfully");
		}
		else
		{
			edao.grant(loan_id,"rejected");
			hs.setAttribute("fund","Loan Rejected ");
		}
		return  "redirect:dash-emp";
	}
	
}
