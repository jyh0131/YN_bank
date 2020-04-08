package com.yi.handler.bankwork.bankbook;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.yi.dao.BankBookDao;
import com.yi.dao.CustomerDao;
import com.yi.dao.PlanDao;
import com.yi.dao.impl.BankBookDaoImpl;
import com.yi.dao.impl.CustomerDaoImpl;
import com.yi.dao.impl.PlanDaoImpl;
import com.yi.dto.BankBook;
import com.yi.dto.Customer;
import com.yi.dto.Employee;
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
			String div = req.getParameter("div");
			List<BankBook> list = bankbookService.showBankBooks();
			int number = list.size() + 1;
			if(div.equals("0")) {
				List<Customer> custList = custService.showCustomerByNormal();
				List<Plan> planList = bankbookService.showPlanByBankBook();
				List<Plan> planListNormal = bankbookService.showPlanByBankBookNormal();
				req.setAttribute("custList", custList);
				req.setAttribute("planList", planList);
				req.setAttribute("planListNormal", planListNormal);
				req.setAttribute("normal", "normal");
				req.setAttribute("number", number);
				return "/WEB-INF/view/bankwork/bankbook/bankbookInsertForm.jsp";
			}
			else {
				List<Customer> custList = custService.showCustomerByBusiness();
				List<Plan> planList = bankbookService.showPlanByBankBookBusiness();
				req.setAttribute("custList", custList);
				req.setAttribute("planList", planList);
				req.setAttribute("number", number);
				return "/WEB-INF/view/bankwork/bankbook/bankbookInsertForm.jsp";
			}
			
		}
		else if(req.getMethod().equalsIgnoreCase("post")) {
			String accountNum = req.getParameter("accountnum");
			String custName = req.getParameter("custname");
			Customer custCode = new Customer();
			custCode.setCustName(custName);
			String planName = req.getParameter("planname");
			Plan accountPlanCode = new Plan();
			accountPlanCode.setPlanName(planName);
			String dateStr = req.getParameter("accountOpenDate");
			Date accountOpenDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(dateStr);
			String interestStr = req.getParameter("accountInterest");
			interestStr = interestStr.replaceAll("[\\%]", "");
			float accountInterest = (Float.parseFloat(interestStr) / 100);
			BankBook bankbook = new BankBook(accountNum, custCode, accountPlanCode, accountOpenDate, accountInterest);
			long accountBalance = Long.parseLong(req.getParameter("accountBalance")==""?"0":req.getParameter("accountBalance"));
			long contribution = Long.parseLong(req.getParameter("contribution"));
			if(contribution - accountBalance < 0) {
				HttpSession session = req.getSession();
				session.setAttribute("Insufficient", "Insufficient");
				res.sendRedirect(req.getContextPath() + "/main/main.do");
			}
			else {
				String empName = req.getParameter("empname");
				Employee emp = new Employee(empName);
				bankbook.setEmployee(emp);
				bankbook.setAccountBalance(accountBalance);
				bankbookService.insertBankBook(bankbook);
				HttpSession session = req.getSession();
				session.setAttribute("successadd", "success");
				res.sendRedirect(req.getContextPath()+"/main/main.do");
			}
			
		}
		return null;
	}

}
