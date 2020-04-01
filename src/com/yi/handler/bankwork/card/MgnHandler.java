package com.yi.handler.bankwork.card;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
			List<Card> list = service.showCards();
			req.setAttribute("list", list);
			return "/WEB-INF/view/bankwork/card/bankbookMgn.jsp";
		}
		else if(req.getMethod().equalsIgnoreCase("post")) {
			String search = req.getParameter("search");
			String div = req.getParameter("div");
			switch(div) {
			case "고객이름":
				Customer customer = new Customer();
				customer.setCustName(search);
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
					list = service.showCardByCheckCard();
					ObjectMapper om = new ObjectMapper();
					String json = om.writeValueAsString(list);
					res.setContentType("application/json;charset=UTF-8");
					PrintWriter out = res.getWriter();
					out.write(json);
					out.flush();
					break;
				case "신용카드":
					list = service.showCardByCreditCard();
					om = new ObjectMapper();
					json = om.writeValueAsString(list);
					res.setContentType("application/json;charset=UTF-8");
					out = res.getWriter();
					out.write(json);
					out.flush();
					break;
				default :
					HashMap<String,String> map = new HashMap<>();
					map.put("errorCardDiv", "error");
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
