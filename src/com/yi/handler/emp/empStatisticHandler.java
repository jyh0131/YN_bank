package com.yi.handler.emp;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
             req.setAttribute("list", list);
			
			
			//각 부서별 사람 수 구하기
            //인사팀
             List<Employee> listForExistHR = service.showPickedEmpByDept("인사", 0);
             List<Employee> listForExistCS = service.showPickedEmpByDept("고객", 0);
             
             Map<String, Integer> map = new HashMap<>();
             map.put("HR",listForExistHR.size());
             map.put("CS",listForExistCS.size());
             
             req.setAttribute("size", map);
			
			
			return "/WEB-INF/view/emp/empStatisticList.jsp";
		
	}
  
}             
