package com.yi.dto;

import java.util.Date;

public class AccountInfo {
	private String custName;
	private String div;
	private int count;
	private String accountNum;
	private Date transDate;
	
	
	public AccountInfo() {
		
	}
	
	public AccountInfo(String custName, int count) {
		this.custName = custName;
		this.count = count;
	}

	public AccountInfo(String custName, String div, int count) {
		this.custName = custName;
		this.div = div;
		this.count = count;
	}
	
	public AccountInfo(String custName, String accountNum, Date transDate) {
		this.custName = custName;
		this.accountNum = accountNum;
		this.transDate = transDate;
	}
	public String getCustName() {
		return custName;
	}
	public void setCustName(String custName) {
		this.custName = custName;
	}
	public String getDiv() {
		return div;
	}
	public void setDiv(String div) {
		this.div = div;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getAccountNum() {
		return accountNum;
	}
	public void setAccountNum(String accountNum) {
		this.accountNum = accountNum;
	}
	public Date getTransDate() {
		return transDate;
	}
	public void setTransDate(Date transDate) {
		this.transDate = transDate;
	}

	@Override
	public String toString() {
		return String.format("AccountInfo [custName=%s, div=%s, count=%s, accountNum=%s, transDate=%s]", custName, div,
				count, accountNum, transDate);
	}
	
}
