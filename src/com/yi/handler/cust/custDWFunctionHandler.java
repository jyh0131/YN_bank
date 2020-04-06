package com.yi.handler.cust;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yi.mvc.CommandHandler;
import com.yi.service.BankBookService;

public class custDWFunctionHandler implements CommandHandler {
	BankBookService service = new BankBookService();
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String accountNum = req.getParameter("accountNum");
		String amount = req.getParameter("amount");
		String text = req.getParameter("text");
		try {
			service.update_balance_locking(Integer.parseInt(amount), accountNum, text);
			
		}catch(RuntimeException e) {          
			e.printStackTrace();
		}
		
		res.sendRedirect(req.getContextPath()+"/cust/custDWSearch.do");
		return null;
	}  
         
}    
                 