package com.yi.handler.emp;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;

import com.yi.dto.Employee;
import com.yi.mvc.CommandHandler;
import com.yi.service.EmployeeUIService;

public class empSearchHandler implements CommandHandler {
    private EmployeeUIService service = new EmployeeUIService();
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		if(req.getMethod().equalsIgnoreCase("get")) {
			List<Employee> list = service.showEmpList();
	//		System.out.println(list);

			req.setAttribute("list", list);
			return "/WEB-INF/view/emp/empSearch.jsp";
		}else if(req.getMethod().equalsIgnoreCase("post")) {
			String search = req.getParameter("search");
			String div = req.getParameter("div");
			
		
			    
				switch(div) {
				
				case "사원번호":
					Employee emp = service.showPikedEmpByCode(search);
					if(emp == null) {
						
					}
					List<Employee> list = new ArrayList<Employee>();
					list.add(emp);
					ObjectMapper om = new ObjectMapper();
					String json = om.writeValueAsString(list);
					res.setContentType("application/json;charset=UTF-8");
					PrintWriter out = res.getWriter();     
					out.write(json);
					out.flush(); 
					
					break;
				case "사원이름":
					List<Employee> list2 = new ArrayList<Employee>();
					list2 = service.showPickedEmpList(search);
					ObjectMapper om2 = new ObjectMapper();
					String json2 = om2.writeValueAsString(list2);
					res.setContentType("application/json;charset=UTF-8");
					PrintWriter out2 = res.getWriter();     
					out2.write(json2);
					out2.flush(); 
					
					break;
				
				case "부서(인사 or 고객)":
					
					break;
				case "직급":
					
					break;
					
				
				
				
				}
				
				
			}

		  
		return null;
	}
  
}             
