package com.yi.handler.main;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yi.dto.Notice;
import com.yi.mvc.CommandHandler;
import com.yi.service.NoticeService;

public class NoticeDetailHandler implements CommandHandler {
	private NoticeService service = new NoticeService();
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		int no = Integer.parseInt(req.getParameter("no"));
		Notice notice = service.showNoticeByNo(new Notice(no));
		req.setAttribute("notice", notice);
		return "/WEB-INF/view/main/notice.jsp";
	}

}
