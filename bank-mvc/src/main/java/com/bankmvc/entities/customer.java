package com.bankmvc.entities;
 
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.Random;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.apache.tomcat.util.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonFormat;

public class customer {
	public customer() {
		super();
		// TODO Auto-generated constructor stub
	}
public String c_id;
	public String firstname;
	public String email;
	public String gender;
	public String dob;
	public String getDob() {
		return dob;
	}
	public void setDob(String dob) {
		this.dob = dob;
	}
	public String phone;
	public String address;
	public int pin;
	public String password;
	public String type;
	public String account;
	public int t_limit;
	public int t_lock;
	public double balance;
	public double debit;
	
	public double getDebit() {
		return debit;
	}
	public void setDebit(double debit) {
		debit=Math.round(debit*100.0)/100.0;
		this.debit = debit;
	}
	public double getBalance() {
		return balance;
	}
	public void setBalance(double balance) {
		balance=Math.round(balance*100.0)/100.0;
		this.balance = balance;
	}
	public int getT_limit() {
		return t_limit;
	}
	public void setT_limit(int t_limit) {
		this.t_limit = t_limit;
	}
	public int getT_lock() {
		return t_lock;
	}
	public void setT_lock(int t_lock) {
		this.t_lock = t_lock;
	}
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

	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public int getPin() {
		return pin;
	}
	public void setPin(int pin) {
		this.pin = pin;
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
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		Random r=new Random();
		int k=6;
		String temp="";
		while(k>0)
		{
		temp+=Integer.toString(r.nextInt(9));
		k--;
		}
		this.account=account+temp;
	}
	public void setAccountt(String account) {
		this.account=account;
	}
	public String getC_id() {
		return c_id;
	}
	public void setC_id(String c_id) {
		Random r=new Random();
		int k=6;
		String temp="";
		while(k>0)
		{
		temp+=Integer.toString(r.nextInt(9));
		k--;
		}
		this.c_id=c_id+temp;
	}
	public void setC_idt(String c_id) {
	this.c_id=c_id;
	}
	@Override
	public String toString() {
		return "customer [c_id=" + c_id + ", firstname=" + firstname + ", email=" + email + ", gender=" + gender
				+ ", dob=" + dob + ", phone=" + phone + ", address=" + address + ", pin=" + pin + ", password="
				+ password + ", type=" + type + ", account=" + account + ", t_limit=" + t_limit + ", t_lock=" + t_lock
				+ ", balance=" + balance + "]";
	}
	public customer(String c_id, String firstname, String email, String gender, String dob, String phone,
			String address, int pin, String password, String type, String account, double balance) {
		super();
		this.c_id = c_id;
		this.firstname = firstname;
		this.email = email;
		this.gender = gender;
		this.dob = dob;
		this.phone = phone;
		this.address = address;
		this.pin = pin;
		this.password = password;
		this.type = type;
		this.account = account;
		this.balance = balance;
	}
	
}
