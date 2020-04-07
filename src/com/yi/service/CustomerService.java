package com.yi.service;

import java.sql.SQLException;
import java.util.List;

import com.yi.dao.CustomerDao;
import com.yi.dao.impl.CustomerDaoImpl;
import com.yi.dto.Cust_dw_audit;
import com.yi.dto.Customer;

public class CustomerService {
	private CustomerDao dao;

	public CustomerService() {
		dao = CustomerDaoImpl.getInstance();
	}
	
	public List<Customer> showCustomers() throws SQLException{
		return dao.selectCustomerAll();
	}
	public List<Customer> showCustomerByNormal() throws SQLException{
		return dao.selectCustomerByNormal();
	}
	public List<Customer> showCustomerByBusiness() throws SQLException{
		return dao.selectCustomerByBusiness();
	}
	
	public List<Customer> showCustomerByName(String custName) throws SQLException{
		return dao.selectCustomerByName(custName);
	}
	
	public List<Customer> showBusinessCustomer() throws SQLException{
		return dao.selectBusinessCust();
	}
	
	public List<Customer> showNormalCustomer() throws SQLException{
		return dao.selectNormalCust();
	}
	
	public List<Customer> showCustomerByCode(String custCode) throws SQLException{
		return dao.selectCustomerByCode(custCode);
	}
	   
	public List<Customer> showCustomerWhoHasAcc() throws SQLException{
		return dao.selectCustomerWhoHasAcc();
	}
	
	public List<Customer> showCustomerWHasAccByCode(String custCode) throws SQLException{
		return dao.selectCustomerWHasAccByCode(custCode);
	}
	public List<Customer> showCustomerWHasAccByName(String custName) throws SQLException{
		return dao.selectCustomerWHasAccByName(custName);
	}
	
	public List<Customer> showCustomerWHasAccByTel(String custTel) throws SQLException{
		return dao.selectCustomerWHasAccByTel(custTel);
	}
	
	
	public Customer showCustomerByTel(String custTel) throws SQLException{
		return dao.selectCustomerByTel(custTel);
	}
	
	public List<Cust_dw_audit> showCust_dw_audit() throws SQLException{
		return dao.selectCust_dw_audit();
	}
	
	public List<Cust_dw_audit> showCust_dw_auditByAcc(String accountNum) throws SQLException{
		return dao.selectCust_dw_auditByAcc(accountNum);
		
	}
	
	public List<Cust_dw_audit> showCust_dw_auditByName(String custName) throws SQLException{
		return dao.selectCust_dw_auditByName(custName);
	}
	
	
	
	public List<Customer> showCustomersByBalance() throws SQLException{
		return dao.selectCustomerBalance();
	}
	
	public List<Customer> showCustomerBankInfoByName(String custName) throws SQLException{
		return dao.selectCustomerBankInfoByName(custName);
	}
	
	public List<Customer> showCustomerBankInfoByAcc(String accountNum) throws SQLException{
		return dao.selectCustomerBankInfoByAcc(accountNum);
	}
	
	public int showNormalCustNum () throws SQLException{
		return dao.selectNormalCustNum();
	}
	
	public int showVIPCustNum() throws SQLException{
		return dao.selectVIPCustNum();
	}
	
	public int showBRankCustNum() throws SQLException{
		return dao.selectBRankCustNum();
	}
	
	public int showSRankCustNum() throws SQLException{
		return dao.selectSRankCustNum();
	}
	
	public int showGRankCustNum() throws SQLException{
		return dao.selectGRankCustNum();
	}
	public int showPRankCustNum() throws SQLException{
		return dao.selectPRankCustNum();
	}
	
	public List<String> custExistChk() throws SQLException{
		return dao.selectCustExistChk();
	}
	
	public void AddCustomer(Customer customer) throws SQLException{
		 dao.insertCustomer(customer);
	}
	
	public int editCustomer(Customer customer) throws SQLException{
		return dao.updateCustomer(customer);
	}
	
	public int removeCustomer(Customer customer) throws SQLException{
		return dao.deleteCustomer(customer);
	}
	
}
