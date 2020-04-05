package com.yi.dao;

import java.sql.SQLException;
import java.util.List;

import com.yi.dto.Loan;
import com.yi.dto.LoanInfo;

public interface LoanDao {
	public List<Loan> showLoans() throws SQLException;
	public List<Loan> showLoansNormal() throws SQLException;
	public List<Loan> showLoansBuisness() throws SQLException;
	public Loan showLoanByLoanAccountNumAndCustName(Loan loan) throws SQLException;
	public List<Loan> showLoanByCustName(Loan loan) throws SQLException;
	public int insertLoan(Loan loan) throws SQLException;
	public int updateLoan(Loan loan) throws SQLException;
	public int deleteLoan(Loan loan) throws SQLException;
	public List<LoanInfo> showLoanInfo() throws SQLException;
	public List<Loan> searchLoanAccountNums(Loan loan) throws SQLException;
	public List<Loan> searchLoanCustNames(Loan loan) throws SQLException;
	public List<Loan> searchLoanPlanNames(Loan loan) throws SQLException;
}
