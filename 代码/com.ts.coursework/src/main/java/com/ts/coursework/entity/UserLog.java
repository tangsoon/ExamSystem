package com.ts.coursework.entity;

import java.util.Date;

/**
 * @author DreamingTheStars
 *
 */
public class UserLog {
	private String userName;
	private Date time;
	private String operation;
	
	public UserLog() {
		
	}
	
	public UserLog(String userName, Date time, String operation) {
		super();
		this.userName = userName;
		this.time = time;
		this.operation = operation;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date date) {
		this.time = date;
	}
	public String getOperation() {
		return operation;
	}
	public void setOperation(String operation) {
		this.operation = operation;
	}
}
