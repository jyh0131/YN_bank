package com.yi.handler.bankwork.card;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yi.dto.BankBook;
import com.yi.dto.Customer;
import com.yi.mvc.CommandHandler;
import com.yi.service.BankBookService;

public class DetailHandler implements CommandHandler {
	private BankBookService service = new BankBookService();
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String accountNum = req.getParameter("accountnum");
		String custName = req.getParameter("custname");
		BankBook bankbook = new BankBook();
		bankbook.setAccountNum(accountNum);
		Customer customer = new Customer();
		customer.setCustName(custName);
		bankbook.setCustCode(customer);
		bankbook = service.showBankBookByCustNameAndAccountNum(bankbook);
		req.setAttribute("bankbook", bankbook);
		return "/WEB-INF/view/bankwork/bankbook/bankbookDetail.jsp";
	}

}
