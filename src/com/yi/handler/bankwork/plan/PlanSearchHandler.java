package com.yi.handler.bankwork.plan;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;

import com.yi.dto.Plan;
import com.yi.mvc.CommandHandler;
import com.yi.service.PlanService;

public class PlanSearchHandler implements CommandHandler {
    private PlanService service = new PlanService();
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		if(req.getMethod().equalsIgnoreCase("get")) {
			List<Plan> list = service.showPlans();
			req.setAttribute("list", list);
		
			return "/WEB-INF/view/bankwork/plan/planSearch.jsp";
		}else if(req.getMethod().equalsIgnoreCase("post")) {
			String search = req.getParameter("search"); //검색어
			String div = req.getParameter("div"); //검색 조건
			
			switch(div) {
			case "상품 코드(A)":
				List<Plan> list = service.showPlansByCode(search);
				if(list==null) {
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
			case "상품 세부코드(AB)":
				List<Plan> list2 = new ArrayList<>();
				list2 = service.showPlansByDetail(search);
				 
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
			case "상품 명":
				
				List<Plan> list3 = service.showPlansByName(search);
				if(list3 == null) {
					HashMap<String,String> map = new HashMap<>();
					map.put("error", "notExist");
					ObjectMapper om3 = new ObjectMapper();
					String json3 = om3.writeValueAsString(map);
					res.setContentType("application/json;charset=UTF-8");
					PrintWriter out3 = res.getWriter();
					out3.write(json3);
					out3.flush();  
					break;
				}
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
