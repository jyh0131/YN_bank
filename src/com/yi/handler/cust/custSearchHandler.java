package com.yi.handler.cust;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;

import com.yi.dto.Customer;
import com.yi.mvc.CommandHandler;
import com.yi.service.CustomerService;

public class custSearchHandler implements CommandHandler {
    private CustomerService service = new CustomerService();
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		if(req.getMethod().equalsIgnoreCase("get")) {
			List<Customer> list = service.showCustomers();
			req.setAttribute("list", list);
			return "/WEB-INF/view/cust/custSearch.jsp";
		}else if(req.getMethod().equalsIgnoreCase("post")) {
			String search = req.getParameter("search"); //검색어
			String div = req.getParameter("div"); //검색 조건
			
			switch(div) {
			case "고객 코드":
				Customer customer = service.showCustomerByCode(search);
				List<Customer> list = new ArrayList<>();
				list.add(customer);
				ObjectMapper om = new ObjectMapper();
				String json = om.writeValueAsString(list);
				res.setContentType("application/json;charset=UTF-8");
				PrintWriter out = res.getWriter();     
				out.write(json);
				out.flush();  
				
				break;
			case "고객명":
				
				List<Customer> list2 = new ArrayList<>();
				list2 = service.showCustomerByName(search);  
				  
				ObjectMapper om2 = new ObjectMapper();
				String json2 = om2.writeValueAsString(list2);
				res.setContentType("application/json;charset=UTF-8");
				PrintWriter out2 = res.getWriter();
				out2.write(json2);
				out2.flush(); 
				break;
			case "연락처":
				List<Customer> list3 = new ArrayList<>();
				Customer customer2 = service.showCustomerByTel(search);
				list3.add(customer2);
				ObjectMapper om3 = new ObjectMapper();
				String json3 = om3.writeValueAsString(list3);
				res.setContentType("application/json;charset=UTF-8");
				PrintWriter out3 = res.getWriter();
				out3.write(json3);
				out3.flush(); 
				break;
			}
		}
		
		return null;
	}

}