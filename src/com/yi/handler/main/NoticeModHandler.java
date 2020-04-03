package com.yi.handler.main;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yi.dto.Notice;
import com.yi.mvc.CommandHandler;
import com.yi.service.NoticeService;

public class NoticeModHandler implements CommandHandler {
	private NoticeService service = new NoticeService();
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		if(req.getMethod().equalsIgnoreCase("get")) {
			int no = Integer.parseInt(req.getParameter("no"));
			Notice notice = service.showNoticeByNo(new Notice(no));
			req.setAttribute("notice", notice);
			return "/WEB-INF/view/main/noticeUpdateForm.jsp";
		}
		else if(req.getMethod().equalsIgnoreCase("post")) {
			int no = Integer.parseInt(req.getParameter("no"));
			String subject = req.getParameter("subject");
			String writer = req.getParameter("writer");
			String content = req.getParameter("content");
			Notice notice = new Notice(no, subject, writer, content);
			service.modifyNotice(notice);
			req.setAttribute("mod", "mod");
			res.sendRedirect(req.getContextPath()+"/main/main.do");
		}
		return null;
	}

}
