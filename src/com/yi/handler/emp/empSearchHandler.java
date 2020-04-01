package com.yi.handler.emp;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yi.dto.Employee;
import com.yi.mvc.CommandHandler;
import com.yi.service.EmployeeUIService;

public class empSearchHandler implements CommandHandler {
    private EmployeeUIService service = new EmployeeUIService();
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		if(req.getMethod().equalsIgnoreCase("get")) {
			List<Employee> list = service.showEmpList();
			req.setAttribute("list", list);
			return "/WEB-INF/view/emp/empSearch.jsp";
		}
		
		return null;
	}

}
