package com.bankmvc.entities;

import java.sql.Date;

public class loan {
String loan_id;
String cus_id;
String name;
String req;
double amount_applied;
int period;
double roi;
String status;
Date date_app;
double net_val;
double pay_per_month;
double int_val;
double amt_left;

public double getInt_val() {
	return int_val;
}

public void setInt_val(double int_val) {
	this.int_val = int_val;
}

public String getLoan_id() {
	return loan_id;
}

public void setLoan_id(String loan_id) {
	this.loan_id = loan_id;
}

public String getCus_id() {
	return cus_id;
}

public void setCus_id(String cus_id) {
	this.cus_id = cus_id;
}

public String getName() {
	return name;
}

public void setName(String name) {
	this.name = name;
}

public String getReq() {
	return req;
}

public void setReq(String req) {
	this.req = req;
}

public double getAmount_applied() {
	return amount_applied;
}

public void setAmount_applied(double amount_applied) {
	this.amount_applied = amount_applied;
}

public int getPeriod() {
	return period;
}

public void setPeriod(int period) {
	this.period = period;
}

public double getRoi() {
	return roi;
}

public void setRoi(double roi) {
	this.roi = roi;
}

public String getStatus() {
	return status;
}

public void setStatus(String status) {
	this.status = status;
}

public Date getDate_app() {
	return date_app;
}

public void setDate_app(Date date_app) {
	this.date_app = date_app;
}

public double getNet_val() {
	return net_val;
}

public void setNet_val(double net_val) {
	this.net_val = net_val;
}

public double getPay_per_month() {
	return pay_per_month;
}

public void setPay_per_month(double pay_per_month) {
	this.pay_per_month = pay_per_month;
}

public double getAmt_left() {
	return amt_left;
}

public void setAmt_left(double amt_left) {
	this.amt_left = amt_left;
}



@Override
public String toString() {
	return "loan [loan_id=" + loan_id + ", cus_id=" + cus_id + ", name=" + name + ", req=" + req + ", amount_applied="
			+ amount_applied + ", period=" + period + ", roi=" + roi + ", status=" + status + ", date_app=" + date_app
			+ ", net_val=" + net_val + ", pay_per_month=" + pay_per_month + ", int_val=" + int_val + ", amt_left="
			+ amt_left + "]";
}

public loan(String loan_id, String cus_id, String name, String req, double amount_applied, int period, double roi,
		String status, Date date_app, double net_val, double pay_per_month, double amt_left) {
	super();
	this.loan_id = loan_id;
	this.cus_id = cus_id;
	this.name = name;
	this.req = req;
	this.amount_applied = amount_applied;
	this.period = period;
	this.roi = roi;
	this.status = status;
	this.date_app = date_app;
	this.net_val = net_val;
	this.pay_per_month = pay_per_month;
	this.amt_left = amt_left;
}

public loan() {
	super();
	// TODO Auto-generated constructor stub
}

}