package com.bankmvc.entities;

public class limit {
	public int limit;
	public int lock;
	public limit(int limit, int lock) {
		super();
		this.limit = limit;
		this.lock = lock;
	}
	public int getLimit() {
		return limit;
	}
	public void setLimit(int limit) {
		this.limit = limit;
	}
	public int getLock() {
		return lock;
	}
	public void setLock(int lock) {
		this.lock = lock;
	}
	public limit() {
		super();
		// TODO Auto-generated constructor stub
	}
}
