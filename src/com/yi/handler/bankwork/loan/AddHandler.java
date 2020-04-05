package com.yi.handler.bankwork.loan;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yi.dto.Customer;
import com.yi.dto.Plan;
import com.yi.mvc.CommandHandler;
import com.yi.service.CustomerService;
import com.yi.service.LoanService;

public class AddHandler implements CommandHandler {
	private CustomerService custService = new CustomerService();
	private LoanService loanService = new LoanService();
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		if(req.getMethod().equalsIgnoreCase("get")) {
			String div = req.getParameter("div");
			if(div.equals("0")) {
				List<Customer> custList = custService.showCustomerByNormal();
				List<Plan> planList = loanService.showPlanByLoan();
				List<Plan> planListNormal = loanService.showPlanByLoanNormal();
				req.setAttribute("custList", custList);
				req.setAttribute("planList", planList);
				req.setAttribute("planListNormal", planListNormal);
				req.setAttribute("normal", "normal");
				return "/WEB-INF/view/bankwork/loan/loanInsertForm.jsp";
			}
			else {
				List<Customer> custList = custService.showCustomerByBusiness();
				List<Plan> planList = loanService.showPlanByLoanBusiness();
				req.setAttribute("custList", custList);
				req.setAttribute("planList", planList);
				return "/WEB-INF/view/bankwork/loan/loanInsertForm.jsp";
			}
			
		}
		else if(req.getMethod().equalsIgnoreCase("post")) {
			
		}
		return null;
	}

}
