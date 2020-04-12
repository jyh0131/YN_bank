package com.yi.handler.emp;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;

import com.yi.dto.Employee;
import com.yi.dto.Plan;
import com.yi.handler.paging.Paging;
import com.yi.mvc.CommandHandler;
import com.yi.service.EmployeeUIService;
import com.yi.service.PlanService;

public class empRealBonusHandler implements CommandHandler {
    private EmployeeUIService service = new EmployeeUIService();
    private PlanService planService = new PlanService();
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		if(req.getMethod().equalsIgnoreCase("get")) {
			int size = service.showEmpPerformance().size();
	//		System.out.println(list);
			req.setAttribute("size", size);
			
			
			 int page = req.getParameter("page") == null ? 1 : Integer.parseInt(req.getParameter("page"));
			 Paging paging = new Paging();   
			    paging.makePaging();      
			    paging.setPageNo(page); //get방식의 parameter값으로 반은 page변수, 현재 페이지 번호
			    paging.setPageSize(10); // 한페이지에 불러낼 게시물의 개수 지정
			    paging.setTotalCount(size);
			
			  //첫번째 row 계산  
			    int startRow = 0;
			    if(paging.getPageNo()==1) {   
			    	//현재 페이지가 1이면 0부터 10개 리스트 불러옴
			    	startRow = 0;
			    }else {   
			    	//현재 페이지가 1이 아니면 첫 페이지를 계산해서 불러옴 (10, 20, 30...) 부터 10개 리스트 불러옴
			    	startRow = (paging.getPageNo()-1)*10;
			    } 
		    List<Employee> list = service.showEmployeeByPerformLimit(startRow, paging.getPageSize());
			
			
			req.setAttribute("list", list);
			req.setAttribute("paging", paging);    
			String mem1 = list.get(0).getEmpCode();
			String mem2 = list.get(1).getEmpCode();
			String mem3 = list.get(2).getEmpCode();
			
			req.setAttribute("mem1", mem1);
			req.setAttribute("mem2", mem2);
			req.setAttribute("mem3", mem3);
			
			List<Plan> planList = planService.showPlans();
			req.setAttribute("planList", planList);

			
			return "/WEB-INF/view/emp/empRealBonusList.jsp";
		}else if(req.getMethod().equalsIgnoreCase("post")) {
			String search = req.getParameter("search"); //여기로 코드가 들어옴 
			String div = req.getParameter("div"); 
	
				
					
			List<Employee> list = service.showEmpPerformanceByTarget(search);
			//	System.out.println(list.size());
			if(list.size() == 0) {
					HashMap<String,String> map = new HashMap<>();
					map.put("error", "notExist");
					ObjectMapper om = new ObjectMapper();
					String json = om.writeValueAsString(map);
					res.setContentType("application/json;charset=UTF-8");
					PrintWriter out = res.getWriter();
					out.write(json);
					out.flush();
					
				}else {
					
					ObjectMapper om = new ObjectMapper();
					String json = om.writeValueAsString(list);
					res.setContentType("application/json;charset=UTF-8");
					PrintWriter out = res.getWriter();     
					out.write(json);
					out.flush(); 
			     	}
				}			

		return null;
	}
  
}             
