package com.yi.handler.bankwork.card;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import com.yi.dto.BankBook;
import com.yi.dto.Card;
import com.yi.dto.Customer;
import com.yi.dto.Plan;
import com.yi.mvc.CommandHandler;
import com.yi.service.BankBookService;
import com.yi.service.CardService;

public class MgnHandler implements CommandHandler {
	private CardService service = new CardService();
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		if(req.getMethod().equalsIgnoreCase("get")) {
			String div = req.getParameter("div");
			if(div.equals("0")) {
				List<Card> list = service.showCardsByNormal();
				if(list.size()==0) {
					HttpSession session = req.getSession();
					session.setAttribute("errornonnormal", "error");
					return "/WEB-INF/view/bankwork/card/cardListCustSelect.jsp";
				}
				req.setAttribute("custdiv", div);
				req.setAttribute("list", list);
				return "/WEB-INF/view/bankwork/card/cardMgnNormal.jsp";
			}
			else {
				List<Card> list = service.showCardsByBusiness();
				if(list.size()==0) {
					HttpSession session = req.getSession();
					session.setAttribute("errornonbusiness", "error");
					return "/WEB-INF/view/bankwork/card/cardListCustSelect.jsp";
				}
				req.setAttribute("custdiv", div);
				req.setAttribute("list", list);
				return "/WEB-INF/view/bankwork/card/cardMgnBusiness.jsp";
			}
		}
		else if(req.getMethod().equalsIgnoreCase("post")) {
			String search = req.getParameter("search");
			String custdiv = req.getParameter("custdiv");
			String div = req.getParameter("div");
			switch(div) {
			case "고객이름":
				Customer customer = new Customer();
				customer.setCustName(search);
				customer.setCustDiv(custdiv.equals("0")?false:true);
				Card card = new Card();
				card.setCustCode(customer);
				List<Card> list = service.showCardByCustName(card);
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
				card = new Card();
				card.setPlanCode(plan);
				customer = new Customer();
				customer.setCustDiv(custdiv.equals("0")?false:true);
				card.setCustCode(customer);
				list = service.showCardByPlanName(card);
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
			case "카드구분":
				switch(search) {
				case "체크카드":
					customer = new Customer();
					customer.setCustDiv(custdiv.equals("0")?false:true);
					list = service.showCardByCheckCard(customer);
					if(list.size()==0) {
						HashMap<String,String> map = new HashMap<>();
						map.put("errorNoDiv", "error");
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
				case "신용카드":
					customer = new Customer();
					customer.setCustDiv(custdiv.equals("0")?false:true);
					list = service.showCardByCreditCard(customer);
					if(list.size()==0) {
						HashMap<String,String> map = new HashMap<>();
						map.put("errorNoDiv", "error");
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
				default :
					HashMap<String,String> map = new HashMap<>();
					map.put("errorCardDiv", "error");
					ObjectMapper om = new ObjectMapper();
					String json = om.writeValueAsString(map);
					res.setContentType("application/json;charset=UTF-8");
					PrintWriter out = res.getWriter();
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
