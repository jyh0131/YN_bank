package com.yi.dao;

import java.sql.SQLException;
import java.util.List;

import com.yi.dto.Customer;

public interface CustomerDao {
	
	abstract List<Customer> selectCustomerAll() throws SQLException;
	abstract List<Customer> selectCustomerByNormal() throws SQLException;
	abstract List<Customer> selectCustomerByBusiness() throws SQLException;
	abstract List<Customer> selectCustomerBalance() throws SQLException;
	abstract List<Customer> selectCustomerByName(String custName) throws SQLException;
	abstract List<Customer> selectBusinessCust() throws SQLException;
	abstract List<Customer>  selectCustomerByCode(String custCode) throws SQLException;
	abstract Customer selectCustomerByTel(String custTel) throws SQLException;
	abstract List<Customer> selectCustomerBankInfoByName (String custName) throws SQLException;
	abstract List<Customer> selectCustomerBankInfoByAcc (String accountNum) throws SQLException;
	abstract int selectNormalCustNum() throws SQLException; 
	abstract int selectVIPCustNum() throws SQLException;
	abstract int selectBRankCustNum() throws SQLException;
	abstract int selectSRankCustNum() throws SQLException;
	abstract int selectGRankCustNum() throws SQLException;
	abstract int selectPRankCustNum() throws SQLException;
	abstract List<String> selectCustExistChk() throws SQLException;
	abstract void insertCustomer(Customer customer) throws SQLException;
	abstract int updateCustomer (Customer customer) throws SQLException;
	abstract int deleteCustomer (Customer customer) throws SQLException;
}
