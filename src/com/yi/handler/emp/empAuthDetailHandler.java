package com.yi.handler.emp;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yi.dto.Department;
import com.yi.dto.Employee;
import com.yi.mvc.CommandHandler;
import com.yi.service.EmployeeUIService;

public class empAuthDetailHandler implements CommandHandler {
	
	private EmployeeUIService service = new EmployeeUIService();
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		
		
		String empCode = req.getParameter("empCode");  //코드를 뽑아옴 
//	    String empName = req.getParameter("empName");
//	    String empTitle = req.getParameter("empTitle");
//	    String empAuth = req.getParameter("empAuth");
//	    int empSalary = Integer.parseInt(req.getParameter("empSalary"));
//	    String empTel = req.getParameter("empTel");
//	    String empId = req.getParameter("empId");
//	    String empPwd = req.getParameter("empPwd");
//		int deptNo = Integer.parseInt(req.getParameter("deptNo"));
//		byte[] pic = req.getParameter("pic").getBytes();
//		
//		Employee emp = new Employee();
//				emp.setEmpCode(empCode);
//				emp.setEmpName(empName);
//				emp.setEmpTitle(empTitle);
//				emp.setEmpAuth(empAuth);
//				emp.setEmpSalary(empSalary);
//				emp.setEmpTel(empTel);
//				emp.setEmpId(empId);
//				emp.setEmpPwd(empPwd);
//				new Department(deptNo);
//				emp.setPic(pic);
				
		Employee emp = service.showPikedEmpByCode(empCode,0);
//		System.out.println(emp);
		req.setAttribute("emp", emp);
		
		
		
		return "/WEB-INF/view/emp/empFormForAuthUpdate.jsp";
		
		
	
	}

}
