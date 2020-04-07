package com.yi.handler.bankwork.plan;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yi.dto.Plan;
import com.yi.mvc.CommandHandler;
import com.yi.service.PlanService;

public class planUpdateHandler implements CommandHandler {
	PlanService service = new PlanService();
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String planCode = req.getParameter("planCode");
		String planDetail = req.getParameter("planDetail");
		String planName = req.getParameter("planName");
		String planDesc = req.getParameter("planDesc");
		String planDiv = req.getParameter("planDiv");
		
		Plan plan = new Plan(planCode, planDetail, planName, planDesc, planDiv);
		service.editPlan(plan);  
		
		res.sendRedirect(req.getContextPath()+"/bankwork/plan/planSearch.do");
		return null;
	}

}
