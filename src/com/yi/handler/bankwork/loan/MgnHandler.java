package com.yi.handler.bankwork.loan;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import com.yi.dto.BankBook;
import com.yi.dto.Customer;
import com.yi.dto.Loan;
import com.yi.dto.Plan;
import com.yi.mvc.CommandHandler;
import com.yi.service.BankBookService;
import com.yi.service.LoanService;

public class MgnHandler implements CommandHandler {
	private LoanService service = new LoanService();
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		if(req.getMethod().equalsIgnoreCase("get")) {
			String div = req.getParameter("div");
			HttpSession session = req.getSession();
			if(div.equals("0")) {
				List<Loan> list = service.showLoansByNormal();
				if(list.size()==0) {
					session.setAttribute("errornonnormal", "error");
					return "/WEB-INF/view/bankwork/loan/loanListCustSelect.jsp";
				}
				req.setAttribute("list", list);
				return "/WEB-INF/view/bankwork/loan/loanMgnNormal.jsp";
			}
			else {
				List<Loan> list = service.showLoansByBusiness();
				if(list.size()==0) {
					session.setAttribute("errornonbusiness", "error");
					return "/WEB-INF/view/bankwork/loan/loanListCustSelect.jsp";
				}
				req.setAttribute("list", list);
				return "/WEB-INF/view/bankwork/loan/loanMgnBusiness.jsp";
			}
			
		}
		else if(req.getMethod().equalsIgnoreCase("post")) {
			String search = req.getParameter("search");
			String div = req.getParameter("div");
			switch(div) {
			case "계좌번호":
				Loan loan = new Loan();
				loan.setLoanAccountNum(search);
				List<Loan> list = service.searchLoanAccountNum(loan);
				if(list.size()==0) {
					HashMap<String,String> map = new HashMap<>();
					map.put("errorAccountNum", "error");
					ObjectMapper om = new ObjectMapper();
					String json = om.writeValueAsString(map);
					res.setContentType("application/json;charset=UTF-8");
					PrintWriter out = res.getWriter();
					out.write(json);
					out.flush();
				}
				else {
					ObjectMapper om = new ObjectMapper();
					String json = om.writeValueAsString(list);
					res.setContentType("application/json;charset=UTF-8");
					PrintWriter out = res.getWriter();
					out.write(json);
					out.flush();
				}
				break;
			case "고객이름":
				Customer customer = new Customer();
				customer.setCustName(search);
				loan = new Loan();
				loan.setCustCode(customer);
				list = service.searchLoanCustName(loan);
				if(list.size()==0) {
					HashMap<String,String> map = new HashMap<>();
					map.put("errorCustName", "error");
					ObjectMapper om = new ObjectMapper();
					String json = om.writeValueAsString(map);
					res.setContentType("application/json;charset=UTF-8");
					PrintWriter out = res.getWriter();
					out.write(json);
					out.flush();
				}
				else {
					ObjectMapper om = new ObjectMapper();
					String json = om.writeValueAsString(list);
					res.setContentType("application/json;charset=UTF-8");
					PrintWriter out = res.getWriter();
					out.write(json);
					out.flush();
				}
				break;
			case "상품명":
				Plan plan = new Plan();
				plan.setPlanName(search);
				loan = new Loan();
				loan.setPlanCode(plan);
				list = service.searchLoanPlanName(loan);
				if(list.size()==0) {
					HashMap<String,String> map = new HashMap<>();
					map.put("errorPlanName", "error");
					ObjectMapper om = new ObjectMapper();
					String json = om.writeValueAsString(map);
					res.setContentType("application/json;charset=UTF-8");
					PrintWriter out = res.getWriter();
					out.write(json);
					out.flush();
				}
				else {
					ObjectMapper om = new ObjectMapper();
					String json = om.writeValueAsString(list);
					res.setContentType("application/json;charset=UTF-8");
					PrintWriter out = res.getWriter();
					out.write(json);
					out.flush();
				}
				break;
			}
		}
		return null;
	}

}
