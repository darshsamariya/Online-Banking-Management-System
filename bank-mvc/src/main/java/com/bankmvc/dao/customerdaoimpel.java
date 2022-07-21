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

import org.springframework.dao.DuplicateKeyException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.bankmvc.entities.customer;
import com.bankmvc.entities.limit;


public class customerdaoimpel {

	JdbcTemplate template;    
    
	public void setTemplate(JdbcTemplate template) {    
	    this.template = template;    
	}    
	
	public int insertcustomer(customer c) {

		String query="insert into "+c.getType()+"(firstname,email,gender,dob,phone,address,pin,password,account,balance,c_id,t_lock,t_limit) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
		System.out.println(c.toString());
//System.out.println(template);
		int r=0;
		try {
	 r=this.template.update(query,c.getFirstname(),c.getEmail(),c.getGender(),c.getDob(),c.getPhone(),c.getAddress(),c.getPin(),c.getPassword(),c.getAccount(),5000,c.getC_id(),1,4);
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
		if(type.equals("customer"))
		{
		query="select * from "+type+" where email=? and password=?";
		}
		else if(type.equals("check"))
		{
			 query="select * from customer where c_id=? and account=?";
		}
		else if(type.equals("get"))
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
		String query="insert into account (cus_id,ben_id,account,name,credit,debit,o_balance,c_balance,date) values(?,?,?,?,?,?,?,?,?)";
	  int r=this.template.update(query,ce,be,account,name,credit,debit,o_balance,c_balance,date);
	  String sql="update customer set balance=? where c_id=?";
	  int k=this.template.update(sql,c_balance,ce);
	  
	}
	
	public limit checklimit(String email,String type)
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
	
	public void update(String email,int l1,int l2,String type)
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
	
	
	public int apply(String c_id,String name,String req,double balance,double amount_applied,int period,double roi,double interest,double net,String status)
	{
		String query="insert into loanapplication (cus_id,name,req,balance,amount_applied,period,roi,interest_val,net_val,status,date_app) values(?,?,?,?,?,?,?,?,?,?,?)";
		int r=0;
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
		   LocalDateTime now = LocalDateTime.now();
		try {
			 r=this.template.update(query,c_id,name,req,balance,amount_applied,period,roi,interest,net,status,dtf.format(now));
				}
				catch(Exception e)
				{
					return 0;
				}
		return r;
	}
}
