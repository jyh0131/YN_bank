package com.yi.handler.cust;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;

import com.yi.dto.Cust_dw_audit;
import com.yi.dto.Customer;
import com.yi.mvc.CommandHandler;
import com.yi.service.CustomerService;

public class custDWRecordHandler implements CommandHandler {
    private CustomerService service = new CustomerService();
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		if(req.getMethod().equalsIgnoreCase("get")) {
			List<Cust_dw_audit> list = service.showCust_dw_audit();
			req.setAttribute("list", list);
			return "/WEB-INF/view/cust/custDWRecordSearch.jsp";
		}else if(req.getMethod().equalsIgnoreCase("post")) {
			String search = req.getParameter("search"); //검색어
			String div = req.getParameter("div"); //검색 조건
			
			switch(div) {
			case "계좌 번호":
				List<Cust_dw_audit> list = service.showCust_dw_auditByAcc(search);
				if(list.size()==0) {
					HashMap<String,String> map = new HashMap<>();
					map.put("error", "notExist");
					ObjectMapper om = new ObjectMapper();
					String json = om.writeValueAsString(map);
					res.setContentType("application/json;charset=UTF-8");
					PrintWriter out = res.getWriter();
					out.write(json);
					out.flush();
					break;   
				}
				ObjectMapper om = new ObjectMapper();
				String json = om.writeValueAsString(list);
				res.setContentType("application/json;charset=UTF-8");
				PrintWriter out = res.getWriter();     
				out.write(json);
				out.flush();  
				
				break;
			case "고객명":
				List<Cust_dw_audit> list2 = new ArrayList<>();
				list2 = service.showCust_dw_auditByName(search);
				 
				if(list2==null) {
					HashMap<String,String> map = new HashMap<>();
					map.put("error", "notExist");
					ObjectMapper om2 = new ObjectMapper();
					String json2 = om2.writeValueAsString(map);
					res.setContentType("application/json;charset=UTF-8");
					PrintWriter out2 = res.getWriter();
					out2.write(json2);
					out2.flush();
					break;
				}
				ObjectMapper om2 = new ObjectMapper();
				String json2 = om2.writeValueAsString(list2);
				res.setContentType("application/json;charset=UTF-8");
				PrintWriter out2 = res.getWriter();
				out2.write(json2);
				out2.flush(); 
				break;
			
			}
		}
		
		return null;
	}

}
