package com.yi.handler.bankwork.loan;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.yi.dto.Contribution;
import com.yi.dto.Customer;
import com.yi.dto.Loan;
import com.yi.dto.Plan;
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
			String cmd = req.getParameter("cmd");
			String custdiv = req.getParameter("custdiv");
			System.out.println(custdiv);
			String loanAccountNum = req.getParameter("loanaccountnum");
			Customer custCode = new Customer();
			String custName = req.getParameter("custname");
			custCode.setCustName(custName);
			Plan planCode = new Plan();
			String planName = req.getParameter("planname");
			planCode.setPlanName(planName);
			String dateStr = req.getParameter("loandate");
			Date loanDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(dateStr);
			String interestStr = req.getParameter("loaninterest");
			interestStr = interestStr.replaceAll("[\\%]", "");
			float loanInterest = Float.parseFloat(interestStr) / 100;
			String balanceStr = req.getParameter("loanbalance");
			balanceStr = balanceStr.replaceAll("[\\,]", "");
			long loanBalance = Long.parseLong(balanceStr);
			Loan loan = new Loan(loanAccountNum, custCode, planCode, loanDate, loanInterest, loanBalance);
			Loan chkLoan = loanService.showLoanByLoanAccountNumAndCustName(loan);
			if(chkLoan.getLoanBalance() < loan.getLoanBalance()) {
				req.setAttribute("loan", loan);
				HttpSession session = req.getSession();
				session.setAttribute("errorbalance", "error");
				return "/WEB-INF/view/bankwork/loan/loanDetail.jsp";
			}
			if(cmd.equals("mod")) {
				loanService.updateLoan(loan);
				HttpSession session = req.getSession();
				session.setAttribute("successmod", "success");
				Contribution contribution = loginService.bankTotalAmount();
				session.removeAttribute("contribution");
				session.setAttribute("contribution", contribution);
				res.sendRedirect(req.getContextPath() + "/bankwork/loan/mgn.do?div="+custdiv);
			}
			else {
				loanService.deleteLoan(loan);
				HttpSession session = req.getSession();
				session.setAttribute("successdel", "success");
				Contribution contribution = loginService.bankTotalAmount();
				session.removeAttribute("contribution");
				session.setAttribute("contribution", contribution);
				res.sendRedirect(req.getContextPath() + "/bankwork/loan/mgn.do?div="+custdiv);
			}
			return null;
		}
		return null;
	}

}
