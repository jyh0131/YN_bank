package com.yi.handler.emp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yi.mvc.CommandHandler;

public class empAddHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {

		if(req.getMethod().equalsIgnoreCase("get")) {
			return "/WEB-INF/view/emp/empForm.jsp";
			
		}else if(req.getMethod().equalsIgnoreCase("post")) {
			String empCode = req.getParameter("empCode");
		
			
			
			
			
		}
		
		
		
		return null;
	}

}
