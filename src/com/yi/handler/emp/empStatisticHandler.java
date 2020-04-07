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

public class empStatisticHandler implements CommandHandler {
    private EmployeeUIService service = new EmployeeUIService();
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
	
			List<Employee> list = service.showExistEmpList();
	//		System.out.println(list);

			req.setAttribute("list", list);
			
			
			//각 부서별 사람 수 구하기
			
			
			return "/WEB-INF/view/emp/empStatisticList.jsp";
		
	}
  
}             
