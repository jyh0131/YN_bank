package com.yi.handler.bankwork.plan;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yi.dto.Plan;
import com.yi.mvc.CommandHandler;
import com.yi.service.PlanService;

public class NewLoanPlanFormHandler implements CommandHandler {
	PlanService service = new PlanService();
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		if(req.getMethod().equalsIgnoreCase("get")) {
			String text = req.getParameter("text");
			
			//대출 상품 전체 숫자
			int planAnum = service.showPlanC();
			String planC = "C"+String.format("%03d", planAnum+1);
			req.setAttribute("planC", planC);
			String planCwhat = "";   
			
			if(text.equals("일반 대출")) {    
				//일반 대출 상품 숫자
				int planCAnum = service.showPlanCA();
				planCwhat = "CA"+String.format("%03d", planCAnum+1);
			
			}else if(text.equals("신용 대출")) {  
				//신용 대출 상품 숫자
				int planCBnum = service.showPlanCB();
				planCwhat = "CB"+String.format("%03d", planCBnum+1);
			}else {
				//카드 대출 상품 숫자
				int planCCnum = service.showPlanCC();
				planCwhat = "CC"+String.format("%03d", planCCnum+1);
			}  
			
			req.setAttribute("planCwhat", planCwhat);
			return "/WEB-INF/view/bankwork/plan/newLoanPlanForm.jsp";
		}else {
			String planCode = req.getParameter("planCode");
			String planDetail = req.getParameter("planDetail");    
			String planName = req.getParameter("planName");
			String planDesc = req.getParameter("planDesc");
			String planDiv = req.getParameter("planDiv");
			
			Plan plan = new Plan(planCode, planDetail, planName, planDesc, planDiv);
			service.addPlan(plan);
			
			res.sendRedirect(req.getContextPath()+"/bankwork/plan/planSearch.do");
		}      
		
		return null;
		
	}
	
		

}
