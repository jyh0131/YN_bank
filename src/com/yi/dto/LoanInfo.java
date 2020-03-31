package com.yi.dto;

public class LoanInfo {
	private String custname;
	private int normal;
	private int credit;
	private int card;
	public LoanInfo() {
		
	}
	public LoanInfo(String custname, int normal, int credit, int card) {
		this.custname = custname;
		this.normal = normal;
		this.credit = credit;
		this.card = card;
	}
	public String getCustname() {
		return custname;
	}
	public void setCustname(String custname) {
		this.custname = custname;
	}
	public int getNormal() {
		return normal;
	}
	public void setNormal(int normal) {
		this.normal = normal;
	}
	public int getCredit() {
		return credit;
	}
	public void setCredit(int credit) {
		this.credit = credit;
	}
	public int getCard() {
		return card;
	}
	public void setCard(int card) {
		this.card = card;
	}
	
}
