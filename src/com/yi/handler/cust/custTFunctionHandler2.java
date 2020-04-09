package com.yi.handler.cust;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.yi.dto.BankBook;
import com.yi.dto.Contribution;
import com.yi.dto.Customer;
import com.yi.mvc.CommandHandler;
import com.yi.service.BankBookService;
import com.yi.service.LoginService;

public class custTFunctionHandler2 implements CommandHandler {
	BankBookService service = new BankBookService();
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String accountNum = req.getParameter("accountNum");
		String amount = req.getParameter("amount");
		String code= req.getParameter("code");
		
		//송금
		String toAccountNum = req.getParameter("findAccNum");
	    String transferAmount =req.getParameter("transferAmount");
	    String selectBank = req.getParameter("selectBank"); //숫자로 변경하기
	    
		try {
			BankBook bankBook = service.showOneBankBook(accountNum);
			BankBook bankBook2 = service.showOneBankBook(toAccountNum);
			
			service.changeBankBookBalance(bankBook, bankBook2, Integer.parseInt(transferAmount));
			
			
		
		}catch(RuntimeException e) {          
			e.printStackTrace();
		}
		
		res.sendRedirect(req.getContextPath()+"/cust/custTransfer.do");
		return null;
	}  
         
}    
                 