package com.yi.handler.bankwork.bankbook;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yi.dao.BankBookDao;
import com.yi.dao.CustomerDao;
import com.yi.dao.PlanDao;
import com.yi.dao.impl.BankBookDaoImpl;
import com.yi.dao.impl.CustomerDaoImpl;
import com.yi.dao.impl.PlanDaoImpl;
import com.yi.dto.Customer;
import com.yi.dto.Plan;
import com.yi.mvc.CommandHandler;
import com.yi.service.BankBookService;
import com.yi.service.CustomerService;
import com.yi.service.PlanService;

public class AddHandler implements CommandHandler {
	private CustomerService custService = new CustomerService();
	private BankBookService bankbookService = new BankBookService();
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		if(req.getMethod().equalsIgnoreCase("get")) {
			List<Customer> custList = custService.showCustomers();
			List<Plan> planListAll = bankbookService.showPlanByBankBook();
			List<Plan> planListNormal = bankbookService.showPlanByBankBookNormal();
			req.setAttribute("custList", custList);
			req.setAttribute("planListAll", planListAll);
			req.setAttribute("planListNormal", planListNormal);
			return "/WEB-INF/view/bankwork/bankbook/bankbookInsertForm.jsp";
		}
		else if(req.getMethod().equalsIgnoreCase("post")) {
			
		}
		return null;
	}

}
