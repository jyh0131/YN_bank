package com.yi.handler.main;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yi.dto.Notice;
import com.yi.mvc.CommandHandler;
import com.yi.service.NoticeService;

public class NoticeDelHandler implements CommandHandler {
	private NoticeService service = new NoticeService();
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		int no = Integer.parseInt(req.getParameter("no"));
		service.removeNotice(new Notice(no));
		req.setAttribute("del", "del");
		res.sendRedirect(req.getContextPath()+"/main/main.do");
		return null;
	}
	
}
