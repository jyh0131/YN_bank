package com.yi.handler.bankwork.plan;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yi.dto.Customer;
import com.yi.dto.Plan;
import com.yi.mvc.CommandHandler;
import com.yi.service.PlanService;

public class PlanDetailHandler implements CommandHandler {
	private PlanService service = new PlanService();
		
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String planCode = req.getParameter("planCode");
		List<Plan> list = service.showPlansByCode(planCode); 
		
		Plan plan = null; 
		for(int i=0; i<list.size();i++) {  
			plan = list.get(i);
		}
		req.setAttribute("plan", plan);
		
		return "/WEB-INF/view/bankwork/plan/planDetail.jsp";
	}

}
