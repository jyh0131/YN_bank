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
	
	public List<Customer> showCustomerWhoHas11Acc() throws SQLException{
		return dao.selectCustomerWhoHas11Acc();
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
	
	//예금계좌만
	public List<Customer> showCustomerWHas11AccByCode(String custCode) throws SQLException{
		return dao.selectCustomerWHas11AccByCode(custCode);
	}
	public List<Customer> showCustomerWHas11AccByName(String custName) throws SQLException{
		return dao.selectCustomerWHas11AccByName(custName);
	}
	
	public List<Customer> showCustomerWHas11AccByTel(String custTel) throws SQLException{
		return dao.selectCustomerWHas11AccByTel(custTel);
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
	
	public List<Cust_dw_audit> showCust_dw_auditByDate(String date) throws SQLException{
		return dao.selectCust_dw_auditByDate(date);
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
	
	public int show5CreditCustNum() throws SQLException{
		return dao.select5CreditCustNum();
	}
	
	public int show4CreditCustNum() throws SQLException{
		return dao.select4CreditCustNum();
	}
	
	public int show3CreditCustNum() throws SQLException{
		return dao.select3CreditCustNum();
	}
	public int show2CreditCustNum() throws SQLException{
		return dao.select2CreditCustNum();
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
	
	
	//페이징 위한 서비스구문들
	//전체 목록
	public List<Cust_dw_audit> showCust_dw_audit(int startRow, int endRow) throws SQLException{
		return dao.selectCust_dw_audit(startRow, endRow);
	}
	
	public List<Customer> showCustomerWhoHasAcc(int startRow, int endRow) throws SQLException{
		return dao.selectCustomerWhoHasAcc(startRow, endRow);
	}
	public List<Customer> showCustomerWhoHas11Acc(int startRow, int endRow) throws SQLException{
		return dao.selectCustomerWhoHas11Acc(startRow, endRow);
	}
	public List<Customer> showCustomers(int startRow, int endRow) throws SQLException{
		return dao.selectCustomerAll(startRow, endRow);
	}
	
}
