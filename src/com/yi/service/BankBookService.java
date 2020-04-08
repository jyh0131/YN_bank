package com.yi.service;

import java.sql.SQLException;
import java.util.List;

import com.yi.dao.BankBookDao;
import com.yi.dao.CustomerDao;
import com.yi.dao.PlanDao;
import com.yi.dao.impl.BankBookDaoImpl;
import com.yi.dao.impl.CustomerDaoImpl;
import com.yi.dao.impl.PlanDaoImpl;
import com.yi.dto.AccountInfo;
import com.yi.dto.BankBook;
import com.yi.dto.Customer;
import com.yi.dto.Plan;

public class BankBookService {
	private BankBookDao bankBookDao;
	private CustomerDao custDao;
	private PlanDao planDao;

	public BankBookService() {
		bankBookDao = BankBookDaoImpl.getInstance();
		custDao = CustomerDaoImpl.getInstance();
		planDao = PlanDaoImpl.getInstance();
	}
	public List<BankBook> showBankBooks() throws SQLException {
		return bankBookDao.showBankBooks();
	}
	public List<BankBook> showBankBooksByBusiness() throws SQLException {
		return bankBookDao.showBankBooksByBusiness();
	}
	public List<BankBook> showBankBookByCustName(BankBook bankbook) throws SQLException {
		return bankBookDao.showBankBooksByCustName(bankbook);
	}
	
	public Long showAccBalanceByCodeAccNum(Customer customer) throws SQLException{
		return bankBookDao.showAccBalanceByCodeAccNum(customer);
	}
	
	public void update_balance_locking(int amount, String accountNum, String text) throws SQLException{
		bankBookDao.update_balance_locking(amount, accountNum, text);
	}
	
	public int insertBankBook(BankBook bankbook) throws SQLException {
		return bankBookDao.insertBankBook(bankbook);
	}
	public int updateBankBook(BankBook bankbook) throws SQLException {
		return bankBookDao.updateBankBook(bankbook);
	}
	public int deleteBankBook(BankBook bankbook) throws SQLException {
		return bankBookDao.deleteBankBook(bankbook);
	}
	public List<Customer> showCustomers() throws SQLException {
		return custDao.selectCustomerAll();
	}
	public List<Plan> showPlanByBankBook() throws SQLException {
		return planDao.selectPlanByBankBook();
	}
	public List<Plan> showPlanByBankBookNormal() throws SQLException {
		return planDao.selectPlanByBankBookNormal();
	}
	public List<Plan> showPlanByBankBookBusiness() throws SQLException {
		return planDao.selectPlanByBankBookBusiness();
	}
	
	public int updateBankBalance(Customer customer) throws SQLException {
		return bankBookDao.updateBankBalance(customer);
	}
	
	public String showDpBalance () throws SQLException{
		return bankBookDao.showDPTotalAmount();
	}
	
	public String showSvBalance () throws SQLException{
		return bankBookDao.showSvTotalAmount();
	}
	
	public String showLoBalance () throws SQLException{
		return bankBookDao.showLoTotalAmount();
	}
	
	public List<String> showOpenDPMonth() throws SQLException{
		return bankBookDao.showOpenDPMonth();
	}
	public List<String> showOpenSvMonth() throws SQLException{
		return bankBookDao.showOpenSvMonth();
	}
	public List<String> showOpenLoMonth() throws SQLException{
		return bankBookDao.showOpenLoMonth();
	}
	
	public List<String> showDepositMonth() throws SQLException{
		return bankBookDao.showDepositMonth();
	}
	public List<BankBook> showBankBookByAccoutNum(BankBook bankbook) throws SQLException {
		return bankBookDao.showBankBooksByAccountNum(bankbook);
	}
	public List<BankBook> showBankBookByPlanName(BankBook bankbook) throws SQLException {
		return bankBookDao.showBankBooksByPlanName(bankbook);
	}
	public List<BankBook> showBankBookByDeposit(Customer customer) throws SQLException {
		return bankBookDao.showBankBooksByDeposit(customer);
	}
	public List<BankBook> showBankBookBySaving(Customer customer) throws SQLException {
		return bankBookDao.showBankBooksBySaving(customer);
	}
	public List<BankBook> showBankBookByMinus(Customer customer) throws SQLException {
		return bankBookDao.showBankBooksByMinus(customer);
	}
	public int updateCardBalance(Customer customer) throws SQLException {
		return bankBookDao.updateCardBalance(customer);
	}
	public BankBook showBankBookByCustNameAndAccountNum(BankBook bankbook) throws SQLException {
		return bankBookDao.showBankBookByCustNameAndAccountNum(bankbook);
	}
	public int changeBankBookDormant(BankBook bankbook) throws SQLException {
		return bankBookDao.changeBankBookDormant(bankbook);
	}
	public int changeBankBookTermination(BankBook bankbook) throws SQLException {
		return bankBookDao.changeBankBookTermination(bankbook);
	}
	public List<BankBook> showBankBookByDormant(BankBook bankbook) throws SQLException {
		return bankBookDao.showBankBookByDormant(bankbook);
	}	
	public List<BankBook> showBankBookByTermination(BankBook bankbook) throws SQLException {
		return bankBookDao.showBankBookByTermination(bankbook);
	}
	public long[] TotalPlanTransAmountYearly() throws SQLException {
		return bankBookDao.TotalPlanTransAmountYearly();
	}
}
