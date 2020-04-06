package com.yi.dto;

public class Contribution {
	private long totalDWAmount;
	private long totalLoanAmount;
	private long totalContribution;
	public Contribution() {
		
	}
	public Contribution(long totalDWAmount, long totalLoanAmount, long totalContribution) {
		this.totalDWAmount = totalDWAmount;
		this.totalLoanAmount = totalLoanAmount;
		this.totalContribution = totalContribution;
	}
	public long getTotalDWAmount() {
		return totalDWAmount;
	}
	public void setTotalDWAmount(long totalDWAmount) {
		this.totalDWAmount = totalDWAmount;
	}
	public long getTotalLoanAmount() {
		return totalLoanAmount;
	}
	public void setTotalLoanAmount(long totalLoanAmount) {
		this.totalLoanAmount = totalLoanAmount;
	}
	public long getTotalContribution() {
		return totalContribution;
	}
	public void setTotalContribution(long totalContribution) {
		this.totalContribution = totalContribution;
	}
	@Override
	public String toString() {
		return String.format("Contribution [totalDWAmount=%s, totalLoanAmount=%s, totalContribution=%s]", totalDWAmount,
				totalLoanAmount, totalContribution);
	}
	
}
