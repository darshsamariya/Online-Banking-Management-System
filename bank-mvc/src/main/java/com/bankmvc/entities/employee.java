package com.bankmvc.entities;

import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.Random;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.apache.tomcat.util.codec.binary.Base64;

public class employee {
	public employee() {
		super();
		// TODO Auto-generated constructor stub
	}
	public String firstname;
	public String email;
	public String gender;
	public String doj;
	public String position;
	public int exp;
	public String phone;
	public String interest;
	public String password;
	public String type;
	public String e_id;
	public String getFirstname() {
		return firstname;
	}
	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public int getExp() {
		return exp;
	}
	public void setExp(int exp) {
		this.exp = exp;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getInterest() {
		return interest;
	}
	public void setInterest(String interest) {
		this.interest = interest;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) throws NoSuchAlgorithmException, InvalidKeyException {
		String secret=email;
		String message=password;
		Mac sha256=Mac.getInstance("HmacSHA256");
		
		SecretKeySpec s_key=new SecretKeySpec(secret.getBytes(),"HmacSHA256");
		sha256.init(s_key);
		String hash=Base64.encodeBase64String(sha256.doFinal(message.getBytes()));
		this.password=hash;
	}
	public void setPasswordd(String password)
	{
		this.password=password;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getDoj() {
		return doj;
	}
	public void setDoj(String doj) {
		this.doj = doj;
	}
	public String getE_id() {
		return e_id;
	}
	public void setE_id(String e_id) {
		Random r=new Random();
		int k=6;
		String temp="";
		while(k>0)
		{
		temp+=Integer.toString(r.nextInt(9));
		k--;
		}
		this.e_id=e_id+temp;
	}
	public void setE_idt(String e_id) {
	this.e_id=e_id;
	}
	@Override
	public String toString() {
		return "employee [firstname=" + firstname + ", email=" + email + ", gender=" + gender + ", doj=" + doj
				+ ", position=" + position + ", exp=" + exp + ", phone=" + phone + ", interest=" + interest
				+ ", password=" + password + ", type=" + type + ", e_id=" + e_id + "]";
	}
	public employee(String firstname, String email, String gender, String doj, String position, int exp, String phone,
			String interest, String password, String type, String e_id) {
		super();
		this.firstname = firstname;
		this.email = email;
		this.gender = gender;
		this.doj = doj;
		this.position = position;
		this.exp = exp;
		this.phone = phone;
		this.interest = interest;
		this.password = password;
		this.type = type;
		this.e_id = e_id;
	}


	
}
