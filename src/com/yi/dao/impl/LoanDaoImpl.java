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
import com.yi.dto.Repayment;

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
		String sql = "select l.loanAccountNum,c.custName,p.planName,l.loanStartDate,l.loanDelayDate,l.loanExpireDate,l.loanInterest,l.loanBalance,l.loanMethod from loan l left join customer c on l.custCode = c.custCode left join plan p on l.loanPlanCode = p.planCode";
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
		Date loanStartDate = rs.getTimestamp("l.loanStartDate");
		Date loanDelayDate = rs.getTimestamp("l.loanDelayDate");
		Date loanExpireDate = rs.getTimestamp("l.loanExpireDate");
		float loanInterest = rs.getFloat("l.loaninterest");
		Long loanBalance = rs.getLong("l.loanbalance");
		String loanMethod = rs.getString("l.loanMethod");
		return new Loan(loanAccountNum, custCode, planCode, loanStartDate, loanDelayDate, loanExpireDate, loanInterest, loanBalance, loanMethod);
	}
	private Loan getLoanCustDiv(ResultSet rs) throws SQLException {
		String loanAccountNum = rs.getString("l.loanaccountnum");
		Customer custCode = new Customer();
		custCode.setCustName(rs.getString("c.custname"));
		custCode.setCustDiv(rs.getBoolean("c.custDiv"));
		Plan planCode = new Plan();
		planCode.setPlanName(rs.getString("p.planname"));
		Date loanStartDate = rs.getTimestamp("l.loanStartDate");
		Date loanDelayDate = rs.getTimestamp("l.loanDelayDate");
		Date loanExpireDate = rs.getTimestamp("l.loanExpireDate");
		float loanInterest = rs.getFloat("l.loaninterest");
		Long loanBalance = rs.getLong("l.loanbalance");
		String loanMethod = rs.getString("l.loanMethod");
		return new Loan(loanAccountNum, custCode, planCode, loanStartDate, loanDelayDate, loanExpireDate, loanInterest, loanBalance, loanMethod);
	}
	private Loan getLoanCustDivAndCredit(ResultSet rs) throws SQLException {
		String loanAccountNum = rs.getString("l.loanaccountnum");
		Customer custCode = new Customer();
		custCode.setCustName(rs.getString("c.custname"));
		custCode.setCustDiv(rs.getBoolean("c.custDiv"));
		custCode.setCustCredit(rs.getInt("c.custCredit"));
		Plan planCode = new Plan();
		planCode.setPlanName(rs.getString("p.planname"));
		Date loanStartDate = rs.getTimestamp("l.loanStartDate");
		Date loanDelayDate = rs.getTimestamp("l.loanDelayDate");
		Date loanExpireDate = rs.getTimestamp("l.loanExpireDate");
		float loanInterest = rs.getFloat("l.loaninterest");
		Long loanBalance = rs.getLong("l.loanbalance");
		String loanMethod = rs.getString("l.loanMethod");
		return new Loan(loanAccountNum, custCode, planCode, loanStartDate, loanDelayDate, loanExpireDate, loanInterest, loanBalance, loanMethod);
	}

	@Override
	public List<Loan> showLoanByCustName(Loan loan) throws SQLException {
		List<Loan> list = new ArrayList<>();
		String sql = "select l.loanAccountNum,c.custName,p.planName,l.loanStartDate,l.loanDelayDate,l.loanExpireDate,l.loanInterest,l.loanBalance,l.loanMethod from loan l left join customer c on l.custCode = c.custCode left join plan p on l.loanPlanCode = p.planCode where c.custname = ?";
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
		String sql = "insert into loan values(?,(select custcode from customer where custname = ?),(select plancode from plan where planname = ?),?,?,?,?,?,?,(select empcode from employee where empname = ?))";
		try(Connection con = DriverManager.getConnection(jdbcDriver);
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, loan.getLoanAccountNum());
			pstmt.setString(2, loan.getCustCode().getCustName());
			pstmt.setString(3, loan.getPlanCode().getPlanName());
			pstmt.setTimestamp(4, new Timestamp(loan.getLoanStartDate().getTime()));
			pstmt.setTimestamp(5, new Timestamp(loan.getLoanDelayDate().getTime()));
			pstmt.setTimestamp(6, new Timestamp(loan.getLoanExpireDate().getTime()));
			pstmt.setString(7, loan.getLoanMethod());
			pstmt.setFloat(8, loan.getLoanInterest());
			pstmt.setLong(9, loan.getLoanBalance());
			pstmt.setString(10, loan.getEmployee().getEmpName());
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
			pstmt.setTimestamp(1, new Timestamp(loan.getLoanStartDate().getTime()));
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
		String sql = "select l.loanAccountNum,c.custName,p.planName,l.loanStartDate,l.loanDelayDate,l.loanExpireDate,l.loanInterest,l.loanBalance,l.loanMethod from loan l left join customer c on l.custCode = c.custCode left join plan p on l.loanPlanCode = p.planCode where l.loanaccountnum like ? and custdiv = ?";
		try(Connection con = DriverManager.getConnection(jdbcDriver);
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, "%" + loan.getLoanAccountNum() + "%");
			pstmt.setBoolean(2, loan.getCustCode().getCustDiv());
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
		String sql = "select l.loanAccountNum,c.custName,p.planName,l.loanStartDate,l.loanDelayDate,l.loanExpireDate,l.loanInterest,l.loanBalance,l.loanMethod from loan l left join customer c on l.custCode = c.custCode left join plan p on l.loanPlanCode = p.planCode where c.custname like ? and custdiv = ?";
		try(Connection con = DriverManager.getConnection(jdbcDriver);
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, "%" + loan.getCustCode().getCustName() + "%");
			pstmt.setBoolean(2, loan.getCustCode().getCustDiv());
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
		String sql = "select l.loanAccountNum,c.custName,p.planName,l.loanStartDate,l.loanDelayDate,l.loanExpireDate,l.loanInterest,l.loanBalance,l.loanMethod from loan l left join customer c on l.custCode = c.custCode left join plan p on l.loanPlanCode = p.planCode where p.planname like ? and custdiv = ?";
		try(Connection con = DriverManager.getConnection(jdbcDriver);
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, "%" + loan.getPlanCode().getPlanName() + "%");
			pstmt.setBoolean(2, loan.getCustCode().getCustDiv());
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
		String sql = "select l.loanAccountNum,c.custName,c.custCredit,p.planName,l.loanStartDate,l.loanDelayDate,l.loanExpireDate,l.loanInterest,l.loanBalance,l.loanMethod,c.custDiv from loan l left join customer c on l.custCode = c.custCode left join plan p on l.loanPlanCode = p.planCode where l.loanaccountnum = ? and c.custname = ?";
		try(Connection con = DriverManager.getConnection(jdbcDriver);
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, loan.getLoanAccountNum());
			pstmt.setString(2, loan.getCustCode().getCustName());
			try(ResultSet rs = pstmt.executeQuery()) {
				while(rs.next()) {
					return getLoanCustDivAndCredit(rs);
				}
			}
		}
		return null;
	}

	@Override
	public List<Loan> showLoansNormal() throws SQLException {
		List<Loan> list = new ArrayList<>();
		String sql = "select l.loanAccountNum,c.custName,p.planName,l.loanStartDate,l.loanDelayDate,l.loanExpireDate,l.loanInterest,l.loanBalance,l.loanMethod from loan l left join customer c on l.custCode = c.custCode left join plan p on l.loanPlanCode = p.planCode where c.custdiv = 0";
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
		String sql = "select l.loanAccountNum,c.custName,p.planName,l.loanStartDate,l.loanDelayDate,l.loanExpireDate,l.loanInterest,l.loanBalance,l.loanMethod from loan l left join customer c on l.custCode = c.custCode left join plan p on l.loanPlanCode = p.planCode where custdiv = 1";
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
	public List<Repayment> searchRepaymentsByAccountNum(String accountnum) throws SQLException {
		List<Repayment> list = new ArrayList<>();
		String sql = "select loanaccountnum,custname,planname,loanstartdate,loandelaydate,loanexpiredate,loanmethod,loanround,loaninterest,loanbalance,loanrepayment from repayment r join customer c on r.custcode = c.custcode join plan p on r.loanplancode = p.plancode where loanaccountnum = ?";
		try(Connection con = DriverManager.getConnection(jdbcDriver);
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, accountnum);
			try(ResultSet rs = pstmt.executeQuery()) {
				while(rs.next()) {
					list.add(getRepayment(rs));
				}	
			}
		}
		return list;
	}

	private Repayment getRepayment(ResultSet rs) throws SQLException {
		String loanAccountNum = rs.getString("loanaccoutnum");
		Customer cust = new Customer();
		cust.setCustName(rs.getString("custname"));
		Plan plan = new Plan();
		plan.setPlanName(rs.getString("planname"));
		Date loanStartDate = rs.getTimestamp("loanstartdate");
		Date loanDelayDate = rs.getTimestamp("loandelaydate");
		Date loanExpireDate = rs.getTimestamp("loanexpiredate");
		String loanMethod = rs.getString("loanmethod");
		int loanRound = rs.getInt("loanround");
		float loanInterest = rs.getFloat("loaninterest");
		long loanBalance = rs.getLong("loanbalance");
		int loanRepayment = rs.getInt("loanrepayment");
		return new Repayment(loanAccountNum, cust, plan, loanStartDate, loanDelayDate, loanExpireDate, loanMethod, loanRound, loanInterest, loanBalance, loanRepayment);
	}

}
