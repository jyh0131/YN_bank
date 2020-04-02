package com.yi.handler.bankwork.loan;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yi.dto.BankBook;
import com.yi.dto.Customer;
import com.yi.dto.Loan;
import com.yi.mvc.CommandHandler;
import com.yi.service.BankBookService;
import com.yi.service.LoanService;

public class DetailHandler implements CommandHandler {
	private LoanService service = new LoanService();
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String loanAccountNum = req.getParameter("loanaccountnum");
		String custName = req.getParameter("custname");
		Loan loan = new Loan();
		loan.setLoanAccountNum(loanAccountNum);
		Customer customer = new Customer();
		customer.setCustName(custName);
		loan.setCustCode(customer);
		loan = service.showLoanByLoanAccountNumAndCustName(loan);
		req.setAttribute("loan", loan);
		return "/WEB-INF/view/bankwork/loan/loanDetail.jsp";
	}

}
