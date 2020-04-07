package com.yi.handler.bankwork.plan;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yi.dto.Plan;
import com.yi.mvc.CommandHandler;
import com.yi.service.PlanService;

public class planDeleteHandler implements CommandHandler {
	PlanService service = new PlanService();
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String planCode = req.getParameter("planCode");
		Plan plan = new Plan();
		plan.setPlanCode(planCode);
		service.removePlan(plan);
		
		res.sendRedirect(req.getContextPath()+"/bankwork/plan/planSearch.do");
		return null;
	}

}
