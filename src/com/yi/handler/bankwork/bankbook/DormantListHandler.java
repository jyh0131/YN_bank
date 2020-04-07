package com.yi.handler.bankwork.bankbook;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.yi.dto.BankBook;
import com.yi.dto.Customer;
import com.yi.mvc.CommandHandler;
import com.yi.service.BankBookService;

public class DormantListHandler implements CommandHandler {
	private BankBookService service = new BankBookService();
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String custDiv = req.getParameter("custdiv");
		Customer custCode = new Customer();
		custCode.setCustDiv(custDiv.equals("0")?false:true);
		BankBook bankbook = new BankBook();
		bankbook.setCustCode(custCode);
		bankbook.setAccountDormant(true);
		List<BankBook> list = service.showBankBookByDormant(bankbook);
		if(list.size()==0) {
			HttpSession session = req.getSession();
			session.setAttribute("nonDormant", "error");
			res.sendRedirect(req.getContextPath() + "/bankwork/bankbook/mgn.do?div=" + custDiv);
		}
		else {
			req.setAttribute("custdiv", custDiv);
			req.setAttribute("list", list);
			return "/WEB-INF/view/bankwork/bankbook/dormantList.jsp";
		}
		return null;
	}

}
