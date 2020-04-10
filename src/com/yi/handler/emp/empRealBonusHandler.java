package com.yi.handler.emp;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;

import com.yi.dto.Employee;
import com.yi.dto.Plan;
import com.yi.mvc.CommandHandler;
import com.yi.service.EmployeeUIService;
import com.yi.service.PlanService;

public class empRealBonusHandler implements CommandHandler {
    private EmployeeUIService service = new EmployeeUIService();
    private PlanService planService = new PlanService();
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		if(req.getMethod().equalsIgnoreCase("get")) {
			List<Employee> list = service.showEmpPerformance();
	//		System.out.println(list);

			req.setAttribute("list", list);
			
			String mem1 = list.get(0).getEmpCode();
			String mem2 = list.get(1).getEmpCode();
			String mem3 = list.get(2).getEmpCode();
			
			req.setAttribute("mem1", mem1);
			req.setAttribute("mem2", mem2);
			req.setAttribute("mem3", mem3);
			
			List<Plan> planList = planService.showPlans();
			req.setAttribute("planList", planList);
			
			return "/WEB-INF/view/emp/empRealBonusList.jsp";
		}else if(req.getMethod().equalsIgnoreCase("post")) {
			String search = req.getParameter("search"); //여기로 코드가 들어옴 
			String div = req.getParameter("div"); 
	
				
					
			List<Employee> list = service.showEmpPerformanceByTarget(search);
			//	System.out.println(list.size());
			if(list.size() == 0) {
					HashMap<String,String> map = new HashMap<>();
					map.put("error", "notExist");
					ObjectMapper om = new ObjectMapper();
					String json = om.writeValueAsString(map);
					res.setContentType("application/json;charset=UTF-8");
					PrintWriter out = res.getWriter();
					out.write(json);
					out.flush();
					
				}else {
					
					ObjectMapper om = new ObjectMapper();
					String json = om.writeValueAsString(list);
					res.setContentType("application/json;charset=UTF-8");
					PrintWriter out = res.getWriter();     
					out.write(json);
					out.flush(); 
			     	}
				}			

		return null;
	}
  
}             
