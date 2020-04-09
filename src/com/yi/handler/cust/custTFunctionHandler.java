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

public class custTFunctionHandler implements CommandHandler {
	BankBookService service = new BankBookService();
	private LoginService loginService = new LoginService();
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String accountNum = req.getParameter("accountNum");
		String amount = req.getParameter("amount");
		String text = req.getParameter("text");
		String code= req.getParameter("code");
		try {
			service.update_balance_locking(Integer.parseInt(amount), accountNum, text);
			Customer customer = new Customer(code);
			BankBook bankbook = new BankBook();
			bankbook.setAccountNum(accountNum);
			customer.setBankbook(bankbook);
			Long balance = service.showAccBalanceByCodeAccNum(customer);
			bankbook.setAccountBalance(balance);
			customer.setBankbook(bankbook);
			service.updateCardBalance(customer);
			
			
			Contribution contribution = loginService.bankTotalAmount();
			HttpSession session = req.getSession();
			session.removeAttribute("contribution");
			session.setAttribute("contribution", contribution);
		}catch(RuntimeException e) {          
			e.printStackTrace();
		}
		
		res.sendRedirect(req.getContextPath()+"/cust/custTransfer.do");
		return null;
	}  
         
}    
                 