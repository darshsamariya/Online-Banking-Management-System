package com.bankmvc.dao;

import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.Random;

import org.springframework.dao.DuplicateKeyException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.bankmvc.entities.customer;
import com.bankmvc.entities.limit;
import com.bankmvc.entities.loan;


public class customerdaoimpel {

	JdbcTemplate template;    
    
	public void setTemplate(JdbcTemplate template) {    
	    this.template = template;    
	}    
	
	public int insertcustomer(customer c) {

		String query="insert into "+c.getType()+"(firstname,email,gender,dob,phone,address,pin,password,account,balance,c_id,t_lock,t_limit,debit) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		System.out.println(c.toString());
//System.out.println(template);
		int r=0;
		try {
	 r=this.template.update(query,c.getFirstname(),c.getEmail(),c.getGender(),c.getDob(),c.getPhone(),c.getAddress(),c.getPin(),c.getPassword(),c.getAccount(),0,c.getC_id(),1,4,0);
		}
		catch(DuplicateKeyException e)
		{
			return 2;
		}
		catch(Exception e)
		{
			return 0;
		}
		return r;
	}
	public customer check(String email,String password,String type)
	{
		String query="";
		if(type.equals("customer"))            //check customer
		{
		query="select * from "+type+" where email=? and password=?";
		}
		else if(type.equals("check"))                //check account associated with id
		{
			 query="select * from customer where c_id=? and account=?";
		}
		else if(type.equals("get"))             //check if one id exist or not
		{
			query="select * from customer where c_id=? or c_id=?";
			System.out.println(query);
		}
		customer s=null;
		try {
	 s=this.template.queryForObject(query,new RowMapper() {

			public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
				customer s=new customer();
		s.setFirstname(rs.getString("firstname"));
		s.setAccountt(rs.getString("account"));
		s.setC_idt(rs.getString("c_id"));
		s.setGender(rs.getString("gender"));
		s.setDob(rs.getString("dob"));
		s.setEmail(rs.getString("email"));
		s.setPhone(rs.getString("phone"));
		s.setPin(rs.getInt("pin"));
		s.setPasswordd(rs.getString("password"));
		s.setAddress(rs.getString("address"));
		s.setBalance(rs.getDouble("balance"));
		s.setT_limit(rs.getInt("t_limit"));
		s.setT_lock(rs.getInt("t_lock"));
		s.setDebit(rs.getDouble("debit"));
				return s;
			}
			
		},email,password);
		}
		catch(Exception e)
		{
			System.out.println(e);
			return s;
		}
	 return s;
}

	public void transferdebit(String ce,String be,String account,String name,double credit,double debit,double o_balance,double c_balance)
	{
		debit=Math.round(debit*100.0)/100.0;          //debit transfer money
		c_balance=Math.round(c_balance*100.0)/100.0;
		SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		Date date = new Date();
	String y=formatter.format(date);
	try{
		System.out.println(y);
	date=formatter.parse(y);
	System.out.println(date);
	}
	catch(Exception e)
	{}
		String query="insert into transfer (cus_id,ben_id,account,name,credit,debit,o_balance,c_balance,date) values(?,?,?,?,?,?,?,?,?)";
	  int r=this.template.update(query,ce,be,account,name,credit,debit,o_balance,c_balance,date);
	  String sql="update customer set balance=? where c_id=?";  //transfer done update balance
	  int k=this.template.update(sql,c_balance,ce);
	  
	}
	
	public limit checklimit(String email,String type)  //check limit
	{
		String query="";
		query="select * from "+type+" where email=?";
		limit l=null;
		try {
	 l=this.template.queryForObject(query,new RowMapper() {

			public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
				limit l=new limit();
		l.setLimit(rs.getInt("t_limit"));
		l.setLock(rs.getInt("t_lock"));
				return l;
			}
			
		},email);
		}
		catch(Exception e)
		{
			System.out.println(e);
			return l;
		}
	 return l;
}
	
	public void update(String email,int l1,int l2,String type)  //unlock account
	{
		System.out.println(l1+"  "+l2);
		String query="";
		if(type.equals("unblock"))
		{
			 query="UPDATE customer SET t_limit=?,t_lock=? where c_id=?";
		}
		else
		{
	 query="UPDATE "+type+" SET t_limit=?,t_lock=? where email=?";
		}
		System.out.println(query);
		  int r=this.template.update(query,l1,l2,email);
		  return;
	}
	
	
	public int apply(String c_id,String name,String req,double balance,double amount_applied,int period,double roi,String status,double ppm,double interest)
	{ 
		Random rt=new Random();       //apply loans
		int k=6;
		String loan_id="loan";
		while(k>0)
		{
		loan_id+=Integer.toString(rt.nextInt(9));
		k--;
		}
		String query="insert into loanapplication (loan_id,cus_id,name,req,amount_applied,period,roi,status,date_app,pay_per_month,amt_left,net_val,int_val) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
		int r=0;
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
		   LocalDateTime now = LocalDateTime.now();
try {
			 r=this.template.update(query,loan_id,c_id,name,req,amount_applied,period,roi,status,dtf.format(now),ppm,amount_applied,0,interest);
}
catch(Exception e)
{
	return 0;
}
			
		return r;
	}
	
	public loan getloandetail(String loan_id,String c_id)        //get loans details
	{
		loan l=null;
		String query="select * from loanapplication where loan_id=? and cus_id=?";
try {
			 l=this.template.queryForObject(query,new RowMapper() {

					public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
					loan l=new loan();
					l.setLoan_id(rs.getString("loan_id"));
					l.setReq(rs.getString("req"));
					l.setAmount_applied(rs.getDouble("amount_applied"));
					l.setPeriod(rs.getInt("period"));
					l.setRoi(rs.getDouble("roi"));
					l.setStatus(rs.getString("status"));
					l.setDate_app(rs.getDate("date_app"));
					l.setAmt_left(rs.getDouble("amt_left"));
					l.setPay_per_month(rs.getDouble("pay_per_month"));
					l.setNet_val(rs.getDouble("net_val"));
					l.setInt_val(rs.getDouble("int_val"));
						return l;
					}
					
				},loan_id,c_id);
}
catch(Exception e)
{
	return l;
}

		return l;
	}
	
	public void cleardebit(String loan_id,double amount,double paid,double debit,String c_id,double afterint)      //payloan
	{
		amount=Math.round(amount*100.0)/100.0;
		debit=Math.round(debit*100.0)/100.0;
		String query="";
		query="update loanapplication set amt_left=?,net_val=?,int_val=? where loan_id=?"; //change in loan_application;
		this.template.update(query,amount,paid,afterint,loan_id);
		query="update customer set debit=? where c_id=?";  //change in customer debit section
		this.template.update(query,debit,c_id);
		if(amount==0)
		{
			query="update loanapplication set status='paid' where loan_id=?";
			this.template.update(query,loan_id);
		}
		return;
	}
	public void increaseint(String loan_id,double increase)    //if amount<int increase interest
	{
		String query="update loanapplication set int_val=? where loan_id=?";
		this.template.update(query,increase,loan_id);
		return;
	}
}
