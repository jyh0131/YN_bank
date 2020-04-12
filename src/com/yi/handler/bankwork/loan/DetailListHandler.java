package com.yi.handler.bankwork.loan;

import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.yi.dto.Customer;
import com.yi.dto.Repayment;
import com.yi.mvc.CommandHandler;
import com.yi.service.LoanService;

public class DetailListHandler implements CommandHandler {
	private LoanService service = new LoanService();
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
			String loanAccountNum = req.getParameter("loanaccountnum");
			String custName = req.getParameter("custname");
			String custDiv = req.getParameter("custdiv");
			Customer cust = new Customer();
			cust.setCustName(custName);
			cust.setCustDiv(custDiv.equals("0")?false:true);
			Repayment repayment = new Repayment();
			repayment.setLoanAccountNum(loanAccountNum);
			repayment.setCust(cust);
			List<Repayment> list = service.searchRepaymentsByAccountNumAndCustDiv(repayment);
			if(list.size()==0) {
				HttpSession session = req.getSession();
				session.setAttribute("nonlist", "error");
				custName = URLEncoder.encode(custName, "UTF-8");
				res.sendRedirect(req.getContextPath() + "/bankwork/loan/detail.do?loanaccountnum="+loanAccountNum + "&custname="+custName);
			}
			else {
				req.setAttribute("list", list);
				if(custDiv.equals("0")) {
					return "/WEB-INF/view/bankwork/loan/loanDetailListNormal.jsp";
				}
				else {
					return "/WEB-INF/view/bankwork/loan/loanDetailListBusiness.jsp";
				}
				
			}
			return null;
	}
}
