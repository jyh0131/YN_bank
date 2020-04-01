package com.yi.handler.emp;

import java.io.PrintWriter;
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
			
			if(div.equals("사원번호")) {
				Employee emp = new Employee();
				emp.setEmpCode(search);
				List<Employee> list = service.showPickedEmpByEmpNo(search);
				  
				if(list.size()== 0) {
					HashMap<String,String> map = new HashMap<>();
					map.put("error", "error");
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
				req.setAttribute("list", list);
				return "/WEB-INF/view/emp/empSearch.jsp";
			}
			
			
		}
		
		return null;
	}

}
