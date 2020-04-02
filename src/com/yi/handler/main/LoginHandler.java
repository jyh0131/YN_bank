package com.yi.handler.main;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.yi.dto.Employee;
import com.yi.mvc.CommandHandler;
import com.yi.service.LoginService;

public class LoginHandler implements CommandHandler {
	private LoginService service = new LoginService();
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		if(req.getMethod().equalsIgnoreCase("get")) {
			return "/WEB-INF/view/main/login.jsp";
		}
		else if(req.getMethod().equalsIgnoreCase("post")) {
			String id = req.getParameter("id");
			String password = req.getParameter("password");
			Employee employee = new Employee();
			employee.setEmpId(id);
			employee.setEmpPwd(password);
			Employee loginEmp = service.GetLoginInfo(employee);
			if(loginEmp==null) {
				req.setAttribute("id", id);
				req.setAttribute("password", password);
				HttpSession session = req.getSession();
				session.setAttribute("errorLogin", "error");
				return "/WEB-INF/view/main/login.jsp";
			}
			else {
				HttpSession session = req.getSession();
				Employee Auth = service.GetEmpAuth(loginEmp);
				session.setAttribute("Auth", Auth);
				res.sendRedirect(req.getContextPath()+"/main/main.do");
			}
		}
		return null;
	}

}
