package com.yi.handler.emp;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yi.dto.Employee;
import com.yi.mvc.CommandHandler;
import com.yi.service.EmployeeUIService;

public class empFormHandler implements CommandHandler {
	private EmployeeUIService service = new EmployeeUIService();
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		//인사팀 리스트
		List<Employee> listForHR = new ArrayList<>();
		listForHR = service.showPickedEmpByDeptNo(1);
		//고객팀 리스트
		List<Employee> listForCS = new ArrayList<>();
		listForCS = service.showPickedEmpByDeptNo(2);
		
		//System.out.println("A"+String.format("%03d", listForHR.size()+1));
		req.setAttribute("numHR", "A"+String.format("%03d", listForHR.size()+1));
		req.setAttribute("numCS", "B"+String.format("%03d", listForCS.size()+1));
		
		
		return "/WEB-INF/view/emp/empForm.jsp";
	}

}
