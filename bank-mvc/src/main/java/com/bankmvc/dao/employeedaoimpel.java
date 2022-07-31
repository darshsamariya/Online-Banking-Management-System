package com.bankmvc.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.dao.DuplicateKeyException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.bankmvc.entities.customer;
import com.bankmvc.entities.employee;


public class employeedaoimpel {
	 
	
		JdbcTemplate template;    
	    
		public void setTemplate(JdbcTemplate template) {    
		    this.template = template;    
		}    
		
		public int insertemployee(employee e) {

			String query="insert into "+e.getType()+"(firstname,email,gender,doj,position,exp,phone,interest,password,e_id,t_lock,t_limit) values(?,?,?,?,?,?,?,?,?,?,?,?)";
   int r=0;
   try {
			r=this.template.update(query,e.getFirstname(),e.getEmail(),e.getGender(),e.getDoj(),e.getPosition(),e.getExp(),e.getPhone(),e.getInterest(),e.getPassword(),e.getE_id(),1,4);
   }
	catch(DuplicateKeyException t)
	{
		return 2;
	}
	catch(Exception t)
	{
		return 0;
	}
   
			return r;
		}
		
		public employee check(String email,String password,String type)   //check employee
		{
			String query="select * from "+type+" where email=? and password=?";
			employee s=null;
			try {
		 s=this.template.queryForObject(query,new RowMapper() {

				public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
					employee s=new employee();
			s.setFirstname(rs.getString("firstname"));
			s.setEmail(rs.getString("email"));
			s.setPosition(rs.getString("position"));
			s.setPhone(rs.getString("phone"));
			s.setInterest(rs.getString("interest"));
			s.setPasswordd(rs.getString("password"));
			s.setE_idt(rs.getString("e_id"));
					return s;
				}
				
			},email,password);
			}
			catch(Exception e)
			{
				return s;
			}
		 return s;
		}
		
		public void deposit(String ce,String be,String name,String account,double credit,double debit,double o_balance,double c_balance,double int_val)
		{
			SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
			Date date = new Date();                                       //deposit money
		String y=formatter.format(date);
		try{
			//System.out.println(y);
		date=formatter.parse(y);
		//System.out.println(date);
		}
		catch(Exception e)
		{}
			String query="insert into deposit (cus_id,ben_id,name,account,credit,debit,o_balance,c_balance,date) values(?,?,?,?,?,?,?,?,?)";
		  int r=this.template.update(query,ce,be,name,account,credit,debit,o_balance,c_balance,date);
		  String sql="";
		  int k=0;
		  if(account.equals("LOAN MONEY"))
		  {
		sql="update customer set balance=? , debit=? where c_id=?";
		System.out.println("hello");
		
		k=this.template.update(sql,c_balance,int_val,be);
		  }
		  else
		  {
			  sql="update customer set balance=? where c_id=?";
			   k=this.template.update(sql,c_balance,be);
		  }
	
		//  System.out.println(k+"  "+sql);
		}
		
		public void grant(String loan_id,String status)              //accept loans
		{
			String query="update loanapplication set status='"+status+"' where loan_id=?";
			int r=this.template.update(query,loan_id);
		}
	
}
