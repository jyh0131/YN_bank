package com.yi.handler.cust;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yi.dto.Customer;
import com.yi.mvc.CommandHandler;
import com.yi.service.CustomerService;

public class custUpdateHandler implements CommandHandler {
	private CustomerService service = new CustomerService();
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		//고객 = 0 , false
		if(req.getMethod().equalsIgnoreCase("post")) {
			String custCode = req.getParameter("custCode");
			String custName = req.getParameter("custName");
			String custRank = req.getParameter("custRank");
			int custCredit = Integer.parseInt(req.getParameter("custCredit"));
			String addr = req.getParameter("addr");
			String custTel = req.getParameter("custTel");
			String div = req.getParameter("custDiv");
			
		
 			if(custRank.equals("Diamond")) {
 				custRank = "D";
 			}else if(custRank.equals("Platinum")) {
 				custRank = "P";
 			}else if(custRank.equals("Gold")) {
 				custRank = "G";
 			}else if(custRank.equals("Silver")) {
 				custRank = "S";
 			}else if(custRank.equals("Bronze")) {
 				custRank = "B";
 			}
 			  
 			Boolean custDiv = true;
 			if(div.equals("일반")) {
 				custDiv = false;
 			}
 			
			try {
				Customer customer = new Customer(custCode, custName, custRank, custCredit, addr, custTel, custDiv);
				service.editCustomer(customer);
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			res.sendRedirect(req.getContextPath()+"/cust/custSearch.do");
			
		}
		return null;
		
	}

}
