package com.yi.handler.bankwork.loan;

import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yi.dto.Customer;
import com.yi.dto.Loan;
import com.yi.dto.Repayment;
import com.yi.mvc.CommandHandler;
import com.yi.service.LoanService;
import com.yi.service.LoginService;

public class DetailHandler implements CommandHandler {
	private LoanService loanService = new LoanService();
	private LoginService loginService = new LoginService();
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		if(req.getMethod().equalsIgnoreCase("get")) {
			String loanAccountNum = req.getParameter("loanaccountnum");
			String custName = req.getParameter("custname");
			Loan loan = new Loan();
			loan.setLoanAccountNum(loanAccountNum);
			Customer customer = new Customer();
			customer.setCustName(custName);
			loan.setCustCode(customer);
			loan = loanService.showLoanByLoanAccountNumAndCustName(loan);
			if(loan.getLoanMethod().equals("A")) {
				Calendar calNow = GregorianCalendar.getInstance();
				Calendar calExpire = GregorianCalendar.getInstance();
				calExpire.setTime(loan.getLoanExpireDate());
				int expireMonth = calExpire.get(Calendar.MONTH);
				int nowMonth = calNow.get(Calendar.MONTH);
				int expireYear = calExpire.get(Calendar.YEAR);
				int nowYear = calNow.get(Calendar.YEAR);
				if(expireMonth - nowMonth != 1 || expireYear != nowYear) {
					loan.setLoanBalance(Math.round(loan.getLoanBalance() * loan.getLoanInterest()));
				}	
			}
			else {
				
			}
			List<Repayment> list = loanService.searchRepaymentsByAccountNum(loan.getLoanAccountNum());
			req.setAttribute("count", list.size());
			req.setAttribute("loan", loan);
			if(loan.getCustCode().getCustDiv()) {
				req.setAttribute("custdiv", 1);
			}
			else {
				req.setAttribute("custdiv", 0);
			}
			return "/WEB-INF/view/bankwork/loan/loanDetail.jsp";
		}
		else if(req.getMethod().equalsIgnoreCase("post")) {
			return null;
		}
		return null;
	}

}
