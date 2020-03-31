package com.yi.dto;

import java.util.Date;

public class Loan {
	private String loanAccountNum;
	private Customer custCode;
	private Plan planCode;
	private Date loanDate;
	private float loanInterest;
	private long loanBalance;
	private Employee employee;
	public Loan() {
		
	}
	public Loan(Customer custCode) {
		this.custCode = custCode;
	}
	public Loan(String loanAccountNum, Customer custCode, Plan planCode, Date loanDate, float loanInterest,
			long loanBalance) {
		this.loanAccountNum = loanAccountNum;
		this.custCode = custCode;
		this.planCode = planCode;
		this.loanDate = loanDate;
		this.loanInterest = loanInterest;
		this.loanBalance = loanBalance;
	}
	public String getLoanAccountNum() {
		return loanAccountNum;
	}
	public void setLoanAccountNum(String loanAccountNum) {
		this.loanAccountNum = loanAccountNum;
	}
	public Customer getCustCode() {
		return custCode;
	}
	public void setCustCode(Customer custCode) {
		this.custCode = custCode;
	}
	public Plan getPlanCode() {
		return planCode;
	}
	public void setPlanCode(Plan planCode) {
		this.planCode = planCode;
	}
	public Date getLoanDate() {
		return loanDate;
	}
	public void setLoanDate(Date loanDate) {
		this.loanDate = loanDate;
	}
	public float getLoanInterest() {
		return loanInterest;
	}
	public void setLoanInterest(float loanInterest) {
		this.loanInterest = loanInterest;
	}
	public long getLoanBalance() {
		return loanBalance;
	}
	public void setLoanBalance(long loanBalance) {
		this.loanBalance = loanBalance;
	}
	public Employee getEmployee() {
		return employee;
	}
	public void setEmployee(Employee employee) {
		this.employee = employee;
	}
}
