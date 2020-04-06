package com.yi.handler.bankwork.loan;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.yi.dto.Customer;
import com.yi.dto.Employee;
import com.yi.dto.Loan;
import com.yi.dto.Plan;
import com.yi.mvc.CommandHandler;
import com.yi.service.CustomerService;
import com.yi.service.LoanService;
import com.yi.service.LoginService;

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
			String loanAccountNum = req.getParameter("accountnum");
			String custName = req.getParameter("custname");
			Customer custCode = new Customer();
			custCode.setCustName(custName);
			String planName = req.getParameter("planname");
			Plan planCode = new Plan();
			planCode.setPlanName(planName);
			String dateStr = req.getParameter("loanDate");
			Date loanDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(dateStr);
			String interestStr = req.getParameter("loanInterest");
			interestStr = interestStr.replaceAll("[\\%]", "");
			float loanInterest = Float.parseFloat(interestStr) / 100;
			String balanceStr = req.getParameter("loanBalance");
			balanceStr = balanceStr.replaceAll("[\\,]", "");
			long loanBalance = Long.parseLong(balanceStr);
			long contribution = Long.parseLong(req.getParameter("contribution"));
			if(contribution-loanBalance<0) {
				HttpSession session = req.getSession();
				session.setAttribute("Insufficient", "Insufficient");
				res.sendRedirect(req.getContextPath() + "/main/main.do");
			}
			else {
				Loan loan = new Loan(loanAccountNum, custCode, planCode, loanDate, loanInterest, loanBalance);
				String empName = req.getParameter("empname");
				Employee employee = new Employee();
				employee.setEmpName(empName);
				loan.setEmployee(employee);
				loanService.insertLoan(loan);
				HttpSession session = req.getSession();
				session.setAttribute("successadd", "success");
				res.sendRedirect(req.getContextPath() + "/main/main.do");
			}
		}
		return null;
	}

}
