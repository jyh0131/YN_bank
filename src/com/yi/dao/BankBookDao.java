package com.yi.dao;

import java.sql.SQLException;
import java.util.List;

import com.yi.dto.AccountInfo;
import com.yi.dto.BankBook;
import com.yi.dto.Card;
import com.yi.dto.Customer;

public interface BankBookDao {
	public abstract List<BankBook> showBankBooks() throws SQLException;
	public abstract List<BankBook> showBankBooksByBusiness() throws SQLException;
	public abstract BankBook showBankBookByCustNameAndAccountNum(BankBook bankbook) throws SQLException;
	public abstract List<BankBook> showBankBooksByAccountNum(BankBook bankbook) throws SQLException;
	public abstract List<BankBook> showBankBooksByCustName(BankBook bankbook) throws SQLException;
	public abstract List<BankBook> showBankBooksByPlanName(BankBook bankbook) throws SQLException;
	public abstract List<BankBook> showBankBooksByDeposit(Customer customer) throws SQLException;
	public abstract List<BankBook> showBankBooksBySaving(Customer customer) throws SQLException;
	public abstract List<BankBook> showBankBooksByMinus(Customer customer) throws SQLException;
	public abstract String showDPTotalAmount() throws SQLException;//예금 총금액
	public abstract String showSvTotalAmount() throws SQLException;//적금 총금액
	public abstract String showLoTotalAmount() throws SQLException;//대출 총금액
	public abstract List<String> showOpenDPMonth() throws SQLException; //월별 예금 건수
	public abstract List<String> showOpenSvMonth() throws SQLException; //월별 적금 건수
	public abstract List<String> showOpenLoMonth() throws SQLException; //월별 대출 건수
	public abstract List<String> showDepositMonth() throws SQLException; //월별 입금 건수
	public abstract List<String> showWithDrawalMonth() throws SQLException; //월별 출금 건수
	public abstract int insertBankBook(BankBook bankbook) throws SQLException;
	public abstract int updateBankBook(BankBook bankbook) throws SQLException;
	public abstract int insertDormantAccountProcedure(BankBook bankbook) throws SQLException;
	public abstract int insertTerminationAccountProcedure(BankBook bankbook) throws SQLException;
	public abstract int deleteBankBook(BankBook bankbook) throws SQLException;
	public abstract int updateBankBalance(Customer customer) throws SQLException;
	public abstract List<AccountInfo> showBankBookInfoDaily() throws SQLException;
	public abstract List<AccountInfo> showBankBookInfoWeekly() throws SQLException;
	public abstract List<AccountInfo> showBankBookInfoMonthly() throws SQLException;
	public abstract List<AccountInfo> showBankBookInfoYearly() throws SQLException;
	public abstract List<AccountInfo> showBankBookDormantAccountInfo() throws SQLException;
	public abstract List<AccountInfo> showBankBookTerminationAccountInfo() throws SQLException;
	public abstract int updateCardBalance(Customer customer) throws SQLException;
	public abstract List<BankBook> showBankBookByIsConnect(Card card) throws SQLException;
	public abstract int updateConnectChk(Card card) throws SQLException;
	public abstract int updateCardBalanceByAccountBalance(Card card) throws SQLException;
	public abstract int changeBankBookDormant(BankBook bankbook) throws SQLException;
	public abstract int changeBankBookTermination(BankBook bankbook) throws SQLException;
}
