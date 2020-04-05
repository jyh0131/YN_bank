package com.yi.handler.cust;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yi.mvc.CommandHandler;

public class dwSelectHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String custName = req.getParameter("custName");
		req.setAttribute("custName", custName);
		String accountNum = req.getParameter("accNum");
		req.setAttribute("accountNum", accountNum);
		String accountBalance = req.getParameter("accBal");
		req.setAttribute("accountBalance", accountBalance);
		return "/WEB-INF/view/cust/dwSelectForm.jsp";
	}

}
