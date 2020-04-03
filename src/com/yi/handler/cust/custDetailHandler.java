package com.yi.handler.cust;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yi.dto.BankBook;
import com.yi.dto.Customer;
import com.yi.mvc.CommandHandler;
import com.yi.service.BankBookService;
import com.yi.service.CustomerService;

public class custDetailHandler implements CommandHandler {
	private CustomerService custService = new CustomerService();
		
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String custName = req.getParameter("custName");
		List<Customer> custList = custService.showCustomerByName(custName);
		
		Customer customer = null; 
		
		for(int i=0; i<custList.size();i++) {  
			customer = custList.get(i);
		}
		req.setAttribute("customer", customer);
		
		return "/WEB-INF/view/cust/custDetail.jsp";
	}

}
