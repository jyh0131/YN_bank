package com.yi.handler.cust;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yi.dto.BankBook;
import com.yi.dto.Customer;
import com.yi.mvc.CommandHandler;
import com.yi.service.CustomerService;

public class custDepositHandler implements CommandHandler {
	private CustomerService service = new CustomerService();
	
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		if(req.getMethod().equalsIgnoreCase("get")) {
			String custName = req.getParameter("custName");
			String accountNum = req.getParameter("accountNum");
			String accountBalance = req.getParameter("accountBalance");
			Long balance = Long.parseLong(accountBalance);
			String dw = req.getParameter("dw");
			BankBook bankbook = new BankBook();
			bankbook.setAccountNum(accountNum);    
			bankbook.setAccountBalance(balance);
			
			List<Customer> list = service.showCustomerWHasAccByName(custName);
			Customer cust = list.get(0);
			cust.setBankbook(bankbook);
			  
			req.setAttribute("cust", cust);
			req.setAttribute("dw", dw);
			
			return "/WEB-INF/view/cust/custDepositForm.jsp?dw=dw";  
		}         
		return null;     
	}   
  
}
