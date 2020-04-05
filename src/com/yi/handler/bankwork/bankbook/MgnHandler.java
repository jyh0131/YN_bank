package com.yi.handler.bankwork.bankbook;

import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import com.yi.dto.BankBook;
import com.yi.dto.Customer;
import com.yi.dto.Plan;
import com.yi.mvc.CommandHandler;
import com.yi.service.BankBookService;

public class MgnHandler implements CommandHandler {
	private BankBookService service = new BankBookService();
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		if(req.getMethod().equalsIgnoreCase("get")) {
			String div = req.getParameter("div");
			HttpSession session = req.getSession();
			if(div.equals("0")) {
				List<BankBook> list = service.showBankBooks();
				if(list.size()==0) {
					session.setAttribute("errornonnormal", "error");
					return "/WEB-INF/view/bankwork/bankbook/bankbookListCustSelect.jsp";
				}
				req.setAttribute("list", list);
				return "/WEB-INF/view/bankwork/bankbook/bankbookMgnNormal.jsp";
			}
			else {
				List<BankBook> list = service.showBankBooksByBusiness();
				if(list.size()==0) {
					session.setAttribute("errornonbusiness", "error");
					return "/WEB-INF/view/bankwork/bankbook/bankbookListCustSelect.jsp";
				}
				req.setAttribute("list", list);
				return "/WEB-INF/view/bankwork/bankbook/bankbookMgnBusiness.jsp";
			}
			
		}
		else if(req.getMethod().equalsIgnoreCase("post")) {
			String search = req.getParameter("search");
			String div = req.getParameter("div");
			switch(div) {
			case "계좌번호":
				BankBook bankbook = new BankBook();
				bankbook.setAccountNum(search);
				List<BankBook> list = service.showBankBookByAccoutNum(bankbook);
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
				bankbook = new BankBook();
				bankbook.setCustCode(customer);
				list = service.showBankBookByCustName(bankbook);
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
				bankbook = new BankBook();
				bankbook.setAccountPlanCode(plan);
				list = service.showBankBookByPlanName(bankbook);
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
			case "통장상품":
				switch(search) {
				case "예금":
					list = service.showBankBookByDeposit();
					ObjectMapper om = new ObjectMapper();
					String json = om.writeValueAsString(list);
					res.setContentType("application/json;charset=UTF-8");
					PrintWriter out = res.getWriter();
					out.write(json);
					out.flush();
					break;
				case "적금":
					list = service.showBankBookBySaving();
					om = new ObjectMapper();
					json = om.writeValueAsString(list);
					res.setContentType("application/json;charset=UTF-8");
					out = res.getWriter();
					out.write(json);
					out.flush();
					break;
				case "마이너스":
					list = service.showBankBookByMinus();
					om = new ObjectMapper();
					json = om.writeValueAsString(list);
					res.setContentType("application/json;charset=UTF-8");
					out = res.getWriter();
					out.write(json);
					out.flush();
					break;
				default :
					HashMap<String,String> map = new HashMap<>();
					map.put("errorBankBookName", "error");
					om = new ObjectMapper();
					json = om.writeValueAsString(map);
					res.setContentType("application/json;charset=UTF-8");
					out = res.getWriter();
					out.write(json);
					out.flush();
					break;
				}
				break;
			}
		}
		return null;
	}

}
