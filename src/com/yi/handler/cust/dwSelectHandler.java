package com.yi.handler.cust;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yi.dto.Customer;
import com.yi.mvc.CommandHandler;
import com.yi.service.CustomerService;

public class dwSelectHandler implements CommandHandler {
	private CustomerService service = new CustomerService();
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String custCode = req.getParameter("custCode");
		req.setAttribute("custCode", custCode);
		String accountNum = req.getParameter("accountNum");
		req.setAttribute("accountNum", accountNum);
		String dw = req.getParameter("dw");
		req.setAttribute("dw", dw);

		
		return "/WEB-INF/view/cust/dwSelectForm.jsp";
	}

}
