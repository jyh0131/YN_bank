package com.yi.handler.bankwork.bankbook;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;

import com.yi.dto.BankBook;
import com.yi.mvc.CommandHandler;
import com.yi.service.BankBookService;

public class MgnHandler implements CommandHandler {
	private BankBookService service = new BankBookService();
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		if(req.getMethod().equalsIgnoreCase("get")) {
			List<BankBook> list = service.showBankBooks();
			req.setAttribute("list", list);
			return "/WEB-INF/view/bankwork/bankbook/bankbookMgn.jsp";
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
				break;
			case "상품명":
				break;
			case "통장상품":
				break;
			}
		}
		return null;
	}

}
