package com.yi.handler.main;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.yi.dto.Contribution;
import com.yi.dto.Employee;
import com.yi.dto.Notice;
import com.yi.mvc.CommandHandler;
import com.yi.service.EmployeeUIService;
import com.yi.service.LoginService;
import com.yi.service.NoticeService;

public class MainHandler implements CommandHandler {
	private NoticeService noticeService = new NoticeService();
	private LoginService loginService = new LoginService();
	private EmployeeUIService empService = new EmployeeUIService();
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		List<Notice> list = noticeService.showNoticeByAll();
		Contribution contribution = loginService.bankTotalAmount();
		System.out.println(contribution);
		req.setAttribute("list", list);
		HttpSession session = req.getSession();
		session.removeAttribute("contribution");
		session.setAttribute("contribution", contribution);
		
		
		//우수사원 정보 불러오기
		List<Employee> empList = empService.showRank();
		Employee emp = empList.get(0);
        //System.out.println("넘버원"+emp);
		req.setAttribute("empNo1", emp);
		
		return "/WEB-INF/view/main/mainSection.jsp";
	}

}
