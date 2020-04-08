package com.yi.handler.emp;

import java.io.File;
import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import com.oreilly.servlet.MultipartRequest;
import com.yi.dto.Department;
import com.yi.dto.Employee;
import com.yi.mvc.CommandHandler;
import com.yi.service.EmployeeUIService;

public class empProfileHandler implements CommandHandler {
     private EmployeeUIService service = new EmployeeUIService();
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {

		
			HttpSession session = req.getSession();
			Employee emp = (Employee) session.getAttribute("Auth");
			//System.out.println(emp);
			String empCode = emp.getEmpCode();
			Employee empFor = service.showPickedEmp2(empCode);
			
			//System.out.println("empF"+empFor);
			req.setAttribute("emp", empFor);
			
			
			return "/WEB-INF/view/emp/empPersonalForm.jsp";
			
		
	}

}
