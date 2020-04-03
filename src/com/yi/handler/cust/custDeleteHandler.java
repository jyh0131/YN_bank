package com.yi.handler.cust;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;

import com.yi.dto.Customer;
import com.yi.mvc.CommandHandler;
import com.yi.service.CustomerService;

public class custDeleteHandler implements CommandHandler {
	private CustomerService service = new CustomerService();
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
			try {
				String custCode = req.getParameter("custCode");
				Customer customer = new Customer();
				customer.setCustCode(custCode);
				service.removeCustomer(customer);
				res.sendRedirect(req.getContextPath()+"/cust/custSearch.do");
			}catch(Exception e) {  
				e.printStackTrace();       
			}   
		  
		return null;  
	}

}
   