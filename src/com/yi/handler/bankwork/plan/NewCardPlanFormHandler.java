package com.yi.handler.bankwork.plan;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yi.dto.Plan;
import com.yi.mvc.CommandHandler;
import com.yi.service.PlanService;

public class NewCardPlanFormHandler implements CommandHandler {
	PlanService service = new PlanService();
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		if(req.getMethod().equalsIgnoreCase("get")) {
			String text = req.getParameter("text");
			
			//카드상품 전체 숫자
			int planAnum = service.showPlanB();
			String planB = "B"+String.format("%03d", planAnum+1);
			req.setAttribute("planB", planB);
			String planBwhat = "";   
			
			if(text.equals("체크 카드")) {    
				//체크 카드 상품 숫자
				int planBAnum = service.showPlanBA();
				planBwhat = "BA"+String.format("%03d", planBAnum+1);
			
			}else if(text.equals("신용 카드")) {  
				//신용 카드 상품 숫자
				int planBBnum = service.showPlanBB();
				planBwhat = "BB"+String.format("%03d", planBBnum+1);
			}   
			
			req.setAttribute("planBwhat", planBwhat);
			return "/WEB-INF/view/bankwork/plan/newCardPlanForm.jsp";
		}else {
			String planCode = req.getParameter("planCode");
			String planDetail = req.getParameter("planDetail");    
			String planName = req.getParameter("planName");
			String planDesc = req.getParameter("planDesc");
			String planDiv = req.getParameter("planDiv");
			
			Plan plan = new Plan(planCode, planDetail, planName, planDesc, planDiv);
			service.addPlan(plan);
			
			res.sendRedirect(req.getContextPath()+"/main/main.do");
		}      
		
		return null;
		
	}
	
		

}
