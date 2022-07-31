package com.bankmvc.main;



import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.bankmvc.dao.customerdaoimpel;
import com.bankmvc.dao.employeedaoimpel;
import com.bankmvc.entities.customer;
import com.bankmvc.entities.employee;
import com.bankmvc.entities.limit;
import com.bankmvc.hmac.hmac;
import com.bankmvc.*;



@Controller
public class app {
	@Autowired    
    customerdaoimpel cdao;
	@Autowired
employeedaoimpel edao;
	
	hmac hx=new hmac();
	@RequestMapping("/check")                       //checks for login as customer /employee
	   public String checklogin(@RequestParam("email") String email,@RequestParam("password") String password,Model m,HttpSession hs) throws InvalidKeyException, NoSuchAlgorithmException
    {
		password=hx.change(email,password);
		/*String secret=email;
		String message=password;
		Mac sha256=Mac.getInstance("HmacSHA256");            
		
		SecretKeySpec s_key=new SecretKeySpec(secret.getBytes(),"HmacSHA256");
		sha256.init(s_key);
		String hash=Base64.encodeBase64String(sha256.doFinal(message.getBytes()));
		password=hash;*/
		//System.out.println(password);
		String type="";
if(email.endsWith("@tvscredit.com"))       //for employee
{
	type="employee";
	limit l=cdao.checklimit(email,type);
	employee e=edao.check(email, password, type);
	if(l==null)
	{
		hs.setAttribute("message","Account not found Please try Again");
		return "redirect:home";
	}
	if(l.getLock()==0)  //account blocked
	{ 
		hs.setAttribute("message","Account Blocked Please mail us to Unblock");
		return "redirect:home";
	}
	if(e==null)  //email found and no password
	{
		if(l.getLimit()==1)
		{
			cdao.update(email,l.getLimit()-1,0,type);
			hs.setAttribute("message","Account Blocked Maximum Attempt reached Mail us to unblock");
		}
		else
		{
			cdao.update(email,l.getLimit()-1,1,type);
			hs.setAttribute("message","Wrong Password Please try Again You have "+(int)(l.getLimit()-1)+" Attempts left");
		}
	
	
		return "redirect:home";
	}
	cdao.update(email,4,1,type);
	System.out.println(e.toString());
	hs.setAttribute("employee",e);
	hs.setAttribute("block","LoggedIN");
hs.setAttribute("email",e.getEmail());
hs.setAttribute("e_id",e.getE_id());
return "redirect:dash-emp";
}
else                 //for customer
{
	type="customer";
	limit l=cdao.checklimit(email,type);
	customer c=cdao.check(email, password, type);
	if(l==null)
	{
		hs.setAttribute("message","Account not found Please try Again");
		return "redirect:home";
	}
	if(l.getLock()==0)
	{
		hs.setAttribute("message","Account Blocked Please mail us to Unblock");
		return "redirect:home";
	}
	if(c==null)
	{
		if(l.getLimit()==1)
		{
			cdao.update(email,l.getLimit()-1,0,type);
			hs.setAttribute("message","Account Blocked Maximum Attempt reached Mail us to unblock");
		}
		else
		{
			cdao.update(email,l.getLimit()-1,1,type);
			hs.setAttribute("message","Wrong Password Please try Again You have "+(int)(l.getLimit()-1)+" Attempts left");
		}
	
	
		return "redirect:home";
	}
	cdao.update(email,4,1, type);
	//System.out.println(c.toString());
	hs.setAttribute("customer",c);
	hs.setAttribute("block","LoggedIN");
hs.setAttribute("email",c.getEmail());
hs.setAttribute("account",c.getAccount());
hs.setAttribute("c_id",c.getC_id());
	return "redirect:dash-cus";

}
    }
	

@RequestMapping("/logout")            //logout 
public String logout(HttpSession s)
{
	s.invalidate();
	return "redirect:home";
}
@RequestMapping({"/home","/"})
String home()                  //home page
{
	
	return "home";
}

}
