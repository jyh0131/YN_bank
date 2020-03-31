package com.yi.dto;

import java.util.Date;

public class CardInfo {
	private String custName;
	private String div;
	private Date transDate;
	private long cardbalance;
	public CardInfo() {
		
	}
	
	public Date getTransDate() {
		return transDate;
	}


	public void setTransDate(Date transDate) {
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
	public long getCardbalance() {
		return cardbalance;
	}
	public void setCardbalance(long cardbalance) {
		this.cardbalance = cardbalance;
	}
	
}
