package com.yi.dao.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.yi.dao.LoanDao;
import com.yi.dto.Customer;
import com.yi.dto.Loan;
import com.yi.dto.LoanInfo;
import com.yi.dto.Plan;

public class LoanDaoImpl implements LoanDao {
	private static final LoanDaoImpl instance = new LoanDaoImpl();
	private LoanDaoImpl() {};
	String jdbcDriver = "jdbc:apache:commons:dbcp:bank";
	public static LoanDaoImpl getInstance() {
		return instance;
	}

	@Override
	public List<Loan> showLoans() throws SQLException {
		List<Loan> list = new ArrayList<>();
		String sql = "select l.loanAccountNum,c.custName,p.planName,l.loanDate,l.loanInterest,l.loanBalance from loan l left join customer c on l.custCode = c.custCode left join plan p on l.loanPlanCode = p.planCode";
		try(Connection con = DriverManager.getConnection(jdbcDriver);
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			while(rs.next()) {
				list.add(getLoan(rs));
			}
		}
		return list;
	}

	private Loan getLoan(ResultSet rs) throws SQLException {
		String loanAccountNum = rs.getString("l.loanaccountnum");
		Customer custCode = new Customer();
		custCode.setCustName(rs.getString("c.custname"));
		Plan planCode = new Plan();
		planCode.setPlanName(rs.getString("p.planname"));
		Date loanDate = rs.getTimestamp("l.loanDate");
		float loanInterest = rs.getFloat("l.loaninterest");
		Long loanBalance = rs.getLong("l.loanbalance");
		return new Loan(loanAccountNum, custCode, planCode, loanDate, loanInterest, loanBalance);
	}

	@Override
	public List<Loan> showLoanByCustName(Loan loan) throws SQLException {
		List<Loan> list = new ArrayList<>();
		String sql = "select l.loanAccountNum,c.custName,p.planName,l.loanDate,l.loanInterest,l.loanBalance from loan l left join customer c on l.custCode = c.custCode left join plan p on l.loanPlanCode = p.planCode where c.custname = ?";
		try(Connection con = DriverManager.getConnection(jdbcDriver);
				PreparedStatement pstmt = con.prepareStatement(sql)) {
				pstmt.setString(1, loan.getCustCode().getCustName());
				try(ResultSet rs = pstmt.executeQuery()) {
					while(rs.next()) {
						list.add(getLoan(rs));
					}
				}	
		}
		return list;
	}

	@Override
	public int insertLoan(Loan loan) throws SQLException {
		int res = -1;
		String sql = "insert into loan values(?,?,?,?,?,?,(select empcode from employee where empname = ?))";
		try(Connection con = DriverManager.getConnection(jdbcDriver);
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, loan.getLoanAccountNum());
			pstmt.setString(2, loan.getCustCode().getCustCode());
			pstmt.setString(3, loan.getPlanCode().getPlanCode());
			pstmt.setTimestamp(4, new Timestamp(loan.getLoanDate().getTime()));
			pstmt.setFloat(5, loan.getLoanInterest());
			pstmt.setLong(6, loan.getLoanBalance());
			pstmt.setString(7, loan.getEmployee().getEmpName());
			res = pstmt.executeUpdate();
		}
		return res;
	}

	@Override
	public int updateLoan(Loan loan) throws SQLException {
		int res = -1;
		String sql = "update loan set loandate = ?,loaninterest=?,loanbalance=? where custcode = (select custcode from customer where custname = ?) and loanaccountnum = ?";
		try(Connection con = DriverManager.getConnection(jdbcDriver);
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setTimestamp(1, new Timestamp(loan.getLoanDate().getTime()));
			pstmt.setFloat(2, loan.getLoanInterest());
			pstmt.setLong(3, loan.getLoanBalance());
			pstmt.setString(4, loan.getCustCode().getCustName());
			pstmt.setString(5, loan.getLoanAccountNum());
			res = pstmt.executeUpdate();
		}
		return res;
	}

	@Override
	public int deleteLoan(Loan loan) throws SQLException {
		int res = -1;
		String sql = "delete from loan where custcode = (select custcode from customer where custname = ?) and loanaccountnum = ?";
		try(Connection con = DriverManager.getConnection(jdbcDriver);
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, loan.getCustCode().getCustName());
			pstmt.setString(2, loan.getLoanAccountNum());
			res = pstmt.executeUpdate();
		}
		return res;
	}

	@Override
	public List<LoanInfo> showLoanInfo() throws SQLException {
		List<LoanInfo> list = new ArrayList<>();
		String sql = "select cs.custname,\r\n" + 
				"(select count(loanplancode) from loan where loanplancode = 'C001' and custcode = l.custcode) as 'normal',\r\n" + 
				"(select count(loanplancode) from loan where loanplancode = 'C002' and custcode = l.custcode) as 'credit',\r\n" + 
				"(select count(loanplancode) from loan where loanplancode = 'C003' and custcode = l.custcode) as 'card'\r\n" + 
				"from loan l join customer cs on l.custCode = cs.custcode group by l.custcode";
		try(Connection con = DriverManager.getConnection(jdbcDriver);
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			while(rs.next()) {
				list.add(getLoanInfo(rs));
			}
		}
		return list;
	}

	private LoanInfo getLoanInfo(ResultSet rs) throws SQLException {
		String custname = rs.getString("cs.custname");
		int normal = rs.getInt("normal");
		int credit = rs.getInt("credit");
		int card = rs.getInt("card");
		return new LoanInfo(custname, normal, credit, card);
	}

	@Override
	public List<Loan> searchLoanAccountNums(Loan loan) throws SQLException {
		List<Loan> list = new ArrayList<>();
		String sql = "select l.loanAccountNum,c.custName,p.planName,l.loanDate,l.loanInterest,l.loanBalance from loan l left join customer c on l.custCode = c.custCode left join plan p on l.loanPlanCode = p.planCode where l.loanaccountnum like ?";
		try(Connection con = DriverManager.getConnection(jdbcDriver);
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, "%" + loan.getLoanAccountNum() + "%");
			try(ResultSet rs = pstmt.executeQuery()) {
				while(rs.next()) {
					list.add(getLoan(rs));
				}
			}
		}
		return list;
	}

	@Override
	public List<Loan> searchLoanCustNames(Loan loan) throws SQLException {
		List<Loan> list = new ArrayList<>();
		String sql = "select l.loanAccountNum,c.custName,p.planName,l.loanDate,l.loanInterest,l.loanBalance from loan l left join customer c on l.custCode = c.custCode left join plan p on l.loanPlanCode = p.planCode where c.custname like ?";
		try(Connection con = DriverManager.getConnection(jdbcDriver);
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, "%" + loan.getCustCode().getCustName() + "%");
			try(ResultSet rs = pstmt.executeQuery()) {
				while(rs.next()) {
					list.add(getLoan(rs));
				}
			}
		}
		return list;
	}

	@Override
	public List<Loan> searchLoanPlanNames(Loan loan) throws SQLException {
		List<Loan> list = new ArrayList<>();
		String sql = "select l.loanAccountNum,c.custName,p.planName,l.loanDate,l.loanInterest,l.loanBalance from loan l left join customer c on l.custCode = c.custCode left join plan p on l.loanPlanCode = p.planCode where p.planname like ?";
		try(Connection con = DriverManager.getConnection(jdbcDriver);
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, "%" + loan.getPlanCode().getPlanName() + "%");
			try(ResultSet rs = pstmt.executeQuery()) {
				while(rs.next()) {
					list.add(getLoan(rs));
				}
			}
		}
		return list;
	}

	@Override
	public Loan showLoanByLoanAccountNumAndCustName(Loan loan) throws SQLException {
		String sql = "select l.loanAccountNum,c.custName,p.planName,l.loanDate,l.loanInterest,l.loanBalance from loan l left join customer c on l.custCode = c.custCode left join plan p on l.loanPlanCode = p.planCode where l.loanaccountnum = ? and c.custname = ?";
		try(Connection con = DriverManager.getConnection(jdbcDriver);
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, loan.getLoanAccountNum());
			pstmt.setString(2, loan.getCustCode().getCustName());
			try(ResultSet rs = pstmt.executeQuery()) {
				while(rs.next()) {
					return getLoan(rs);
				}
			}
		}
		return null;
	}

	@Override
	public List<Loan> showLoansNormal() throws SQLException {
		List<Loan> list = new ArrayList<>();
		String sql = "select l.loanAccountNum,c.custName,p.planName,l.loanDate,l.loanInterest,l.loanBalance from loan l left join customer c on l.custCode = c.custCode left join plan p on l.loanPlanCode = p.planCode where c.custdiv = 0";
		try(Connection con = DriverManager.getConnection(jdbcDriver);
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			while(rs.next()) {
				list.add(getLoan(rs));
			}
		}
		return list;
	}

	@Override
	public List<Loan> showLoansBuisness() throws SQLException {
		List<Loan> list = new ArrayList<>();
		String sql = "select l.loanAccountNum,c.custName,p.planName,l.loanDate,l.loanInterest,l.loanBalance from loan l left join customer c on l.custCode = c.custCode left join plan p on l.loanPlanCode = p.planCode where custdiv = 1";
		try(Connection con = DriverManager.getConnection(jdbcDriver);
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			while(rs.next()) {
				list.add(getLoan(rs));
			}
		}
		return list;
	}

}
