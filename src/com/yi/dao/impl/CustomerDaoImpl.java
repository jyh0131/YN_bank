package com.yi.dao.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.yi.dao.CustomerDao;
import com.yi.dto.BankBook;
import com.yi.dto.Customer;

public class CustomerDaoImpl implements CustomerDao {
	private static final CustomerDaoImpl instance = new CustomerDaoImpl();
	String jdbcDriver = "jdbc:apache:commons:dbcp:bank";
	public static CustomerDaoImpl getInstance() {
		return instance;
	}
	
	@Override
	public List<Customer> selectCustomerAll() throws SQLException {
		List<Customer> list = null;
		String sql = "select custCode, custName, custRank, custCredit, custAddr, custTel, custDiv from customer";
		try(Connection con = DriverManager.getConnection(jdbcDriver);
			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();){
			if(rs.next()) {
				list = new ArrayList<>();
				do {
					list.add(getCustomer(rs));
				}while(rs.next());
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	private Customer getCustomer(ResultSet rs) throws SQLException{
		String custCode = rs.getString("custCode");
		String custName = rs.getString("custName");
		String custRank = rs.getString("custRank");
		int custCredit = rs.getInt("custCredit");
		String custAddr = rs.getString("custAddr");
		String custTel = rs.getString("custTel");
		int custDiv = rs.getInt("custDiv");
		Boolean custDivTF;
		if(custDiv==0) {
			custDivTF=false;
		}else{
			custDivTF=true;
		}
		
		return new Customer(custCode, custName, custRank, custCredit, custAddr, custTel, custDivTF);
	}

	  
	@Override
	public List<Customer> selectCustomerByName(String custName) throws SQLException {
		String sql = "select custCode, custName, custRank, custCredit, custAddr, custTel, custDiv from customer where custName like ?";
		List<Customer> list = null;
		try(Connection con = DriverManager.getConnection(jdbcDriver);
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setString(1, "%"+custName+"%");
			try(ResultSet rs = pstmt.executeQuery();){
				if(rs.next()) {
					list = new ArrayList<>();
					do {
						list.add(getCustomer(rs));
					}while(rs.next());
				}
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public void insertCustomer(Customer customer) throws SQLException {
		String sql = "insert into customer values(?,?,?,?,?,?,?)";
		try(Connection con = DriverManager.getConnection(jdbcDriver); 
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setString(1, customer.getCustCode());
			pstmt.setString(2, customer.getCustName());
			pstmt.setString(3, customer.getCustRank());
			pstmt.setInt(4, customer.getCustCredit());
			pstmt.setString(5, customer.getCustAddr());
			pstmt.setString(6, customer.getCustTel());
			pstmt.setBoolean(7, customer.isCustDiv());
			
			pstmt.executeUpdate();
		}
		
	}

	@Override
	public int updateCustomer(Customer customer) throws SQLException {
		String sql = "update customer set custCode = ?, custName =?, custRank=?, custCredit=?, custAddr=?, custTel=? where custCode=? ";
		int res = -1;
		try(Connection con = DriverManager.getConnection(jdbcDriver);
			PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setString(1, customer.getCustCode());
			pstmt.setString(2, customer.getCustName());
			pstmt.setString(3, customer.getCustRank());
			pstmt.setInt(4, customer.getCustCredit());
			pstmt.setString(5, customer.getCustAddr());
			pstmt.setString(6, customer.getCustTel());
			pstmt.setString(7, customer.getCustCode());
			
			res = pstmt.executeUpdate();
		}
		return res;
	}

	@Override
	public int deleteCustomer(Customer customer) throws SQLException {
		String sql = "delete from customer where custCode =?";
		int res =  -1;
		try(Connection con = DriverManager.getConnection(jdbcDriver);
			PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setString(1, customer.getCustCode());
			
			res=pstmt.executeUpdate();
		}
		return res;
	}

	@Override
	public List<Customer> selectCustomerBalance() throws SQLException {
		String sql = "select c.custCode, c.custName, b.accountNum, b.accountBalance from customer c "
				+ "join bankbook b on c.custcode = b.custcode";
		List<Customer> list = new ArrayList<>();
		try(Connection con = DriverManager.getConnection(jdbcDriver);
			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();){
			if(rs.next()) {
				do {
					list.add(getCustomerForBalance(rs));
				}while(rs.next());
			}
		}
		
		return list;
	}

	private Customer getCustomerForBalance(ResultSet rs) throws SQLException {
		String custCode = rs.getString("c.custCode");
		String custName  = rs.getString("c.custName");
		String custAccnt = rs.getString("b.accountNum");
		String custBalance = rs.getString("b.accountBalance");
		if(custBalance==null) {
			custBalance="0";
		}
		Long balance = Long.parseLong(custBalance);
		
		Customer customer = new Customer(custCode, custName);
		BankBook bankbook = new BankBook(customer);
		bankbook.setAccountNum(custAccnt);
		bankbook.setAccountBalance(balance);
		
		customer.setBankbook(bankbook);
		/*
		 * customer.getBankbook().setCustCode(customer.getCustCode());
		 * customer.getBankbook().setAccountNum(custAccnt);
		 * customer.getBankbook().setAccountBalance(balance);
		 */
		
		return customer;
	}

	@Override
	public List<Customer> selectCustomerBankInfoByName(String custName) throws SQLException {
		String sql = "select custName, accountNum, accountBalance from customer c join bankbook b on c.custcode = b.custCode where custName like ?";
		List<Customer> list= null;
		try(Connection con = DriverManager.getConnection(jdbcDriver);
			PreparedStatement pstmt = con.prepareStatement(sql)){
			pstmt.setString(1, "%"+custName+"%");
			ResultSet rs = pstmt.executeQuery();
				
				if(rs.next()) {
					list = new ArrayList<>();
					do {
						list.add(getCustBankInfo(rs));
					}while(rs.next());
				}
				return list;
		}
	}

	private Customer getCustBankInfo(ResultSet rs) throws SQLException {
		Customer customer= new Customer();
		BankBook bankbook= new BankBook();
		customer.setCustName(rs.getString(1));
		bankbook.setAccountNum(rs.getString(2));
		bankbook.setAccountBalance(Long.parseLong(rs.getString(3)));
		customer.setBankbook(bankbook);
		
		return customer;
	}

	@Override
	public int selectNormalCustNum() throws SQLException {
		String sql ="select (count(*) - (select count(*) from customer where custRank = \"D\")) from customer";
		int result;
		try(Connection con = DriverManager.getConnection(jdbcDriver);
			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();){
			if(rs.next()) {
				result = rs.getInt(1);
				return result;
			}
		}
		return -1;
	}

	@Override
	public int selectVIPCustNum() throws SQLException {
		String sql ="select count(*) from customer where custRank = \'D\'";
		int result;
		try(Connection con = DriverManager.getConnection(jdbcDriver);
			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();){
			if(rs.next()) {
				result = rs.getInt(1);
				return result;
			}
		}
		return -1;
	}

	@Override
	public int selectBRankCustNum() throws SQLException {
		String sql ="select count(*) from customer where custRank = \'B\'";
		int result;
		try(Connection con = DriverManager.getConnection(jdbcDriver);
			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();){
			if(rs.next()) {
				result = rs.getInt(1);
				return result;
			}
		}
		return -1;
	}

	@Override
	public int selectSRankCustNum() throws SQLException {
		String sql ="select count(*) from customer where custRank = \'S\'";
		int result;
		try(Connection con = DriverManager.getConnection(jdbcDriver);
			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();){
			if(rs.next()) {
				result = rs.getInt(1);
				return result;
			}
		}
		return -1;
	}

	@Override
	public int selectGRankCustNum() throws SQLException {
		String sql ="select count(*) from customer where custRank = \'G\'";
		int result;
		try(Connection con = DriverManager.getConnection(jdbcDriver);
			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();){
			if(rs.next()) {
				result = rs.getInt(1);
				return result;
			}
		}
		return -1;
	}

	@Override
	public int selectPRankCustNum() throws SQLException {
		String sql ="select count(*) from customer where custRank = \'P\'";
		int result;
		try(Connection con = DriverManager.getConnection(jdbcDriver);
			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();){
			if(rs.next()) {
				result = rs.getInt(1);
				return result;
			}
		}
		return -1;
	}

	@Override
	public List<String> selectCustExistChk() throws SQLException {
		List<String> list = null;
		String sql = "select custName from customer";
		try(Connection con = DriverManager.getConnection(jdbcDriver);
			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();){
			if(rs.next()) {
				list = new ArrayList<>();
				do {
					list.add(rs.getString(1));
				}while(rs.next());
			}
		}
		return list;
	}

	@Override
	public List<Customer> selectCustomerByCode(String custCode) throws SQLException {
		String sql = "select custCode, custName, custRank, custCredit, custAddr, custTel, custDiv from customer where custCode like ?";
		List<Customer> list = null;
		try(Connection con = DriverManager.getConnection(jdbcDriver);
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setString(1, custCode+"%");
			try(ResultSet rs = pstmt.executeQuery();){
				if(rs.next()) {
					list = new ArrayList<>();
					do {
						Customer customer = getCustomer(rs);
						list.add(customer);
					}while(rs.next());
				}
			}
			
		}catch(SQLException e) {
			e.printStackTrace();  
		}
		
		return list;
	}  
     
	@Override
	public Customer selectCustomerByTel(String custTel) throws SQLException {
		String sql = "select custCode, custName, custRank, custCredit, custAddr, custTel from customer where custTel = ?";
		try(Connection con = DriverManager.getConnection(jdbcDriver);
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setString(1, custTel);
			try(ResultSet rs = pstmt.executeQuery();){
				if(rs.next()) {
					return getCustomer(rs);
				}
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		return null;
	}

	@Override
	public List<Customer> selectCustomerBankInfoByAcc(String accountNum) throws SQLException {
		String sql = "select * from customer c join bankbook b on c.custCode = b.custCode where accountNum = ?";
		List<Customer> list = null;
		try(Connection con = DriverManager.getConnection(jdbcDriver);
			PreparedStatement pstmt = con.prepareStatement(sql)){
			pstmt.setString(1, accountNum);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList<>();
				do {
					Customer customer = getCustomerByAcc(rs);
					list.add(customer);
				}while(rs.next());
			}
		}
		return list;
	}

	private Customer getCustomerByAcc(ResultSet rs) throws SQLException {
		Customer customer = new Customer();
		BankBook bankbook = new BankBook();
		customer.setCustCode(rs.getString(1));
		customer.setCustName(rs.getString(2));
		bankbook.setAccountNum(rs.getString(7));
		bankbook.setAccountBalance(Long.parseLong(rs.getString(12)));
		customer.setBankbook(bankbook);
		return customer;
	}

	@Override
	public List<Customer> selectBusinessCust() throws SQLException {
		List<Customer> list = null;
		String sql = "select * from customer where custCode like ?";
		ResultSet rs = null;
		try(Connection con = DriverManager.getConnection(jdbcDriver);
			PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setString(1, "B%");
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList<>();
				do {
					list.add(getCustomer(rs));
				}while(rs.next());
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Customer> selectNormalCust() throws SQLException {
		List<Customer> list = null;
		String sql = "select * from customer where custCode like ?";
		ResultSet rs = null;
		try(Connection con = DriverManager.getConnection(jdbcDriver);
			PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setString(1, "C%");
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList<>();
				do {
					list.add(getCustomer(rs));
				}while(rs.next());
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	
	
	

}
