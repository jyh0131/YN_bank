package com.yi.handler.bankwork.bankbook;

import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import com.yi.dto.BankBook;
import com.yi.dto.Customer;
import com.yi.dto.Plan;
import com.yi.handler.paging.Paging;
import com.yi.mvc.CommandHandler;
import com.yi.service.BankBookService;

public class MgnHandler implements CommandHandler {
	private BankBookService service = new BankBookService();
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		if(req.getMethod().equalsIgnoreCase("get")) {
			String div = req.getParameter("div");
			HttpSession session = req.getSession();
			if(div.equals("0")) {
				//List<BankBook> list = service.showBankBooksByNormal();
				int size = service.showBankBooksByNormal().size();
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
				    
				    List<BankBook> list = service.showBankBooksByNormal(startRow, paging.getPageSize());  
				if(list.size()==0) {
					session.setAttribute("errornonnormal", "error");
					return "/WEB-INF/view/bankwork/bankbook/bankbookListCustSelect.jsp";
				}
				req.setAttribute("list", list);
				req.setAttribute("custdiv", div);
				req.setAttribute("paging", paging);
				return "/WEB-INF/view/bankwork/bankbook/bankbookMgnNormal.jsp";
			}
			else {
				//List<BankBook> list = service.showBankBooksByBusiness();
				int size = service.showBankBooksByBusiness().size();
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
				
				    List<BankBook> list = service.showBankBooksByBusiness(startRow, paging.getPageSize());
				if(list.size()==0) {
					session.setAttribute("errornonbusiness", "error");
					return "/WEB-INF/view/bankwork/bankbook/bankbookListCustSelect.jsp";
				}
				req.setAttribute("list", list);
				req.setAttribute("custdiv", div);
				req.setAttribute("paging", paging);
				return "/WEB-INF/view/bankwork/bankbook/bankbookMgnBusiness.jsp";
			}
			
		}
		else if(req.getMethod().equalsIgnoreCase("post")) {
			String search = req.getParameter("search");
			String div = req.getParameter("div");
			String custdiv = req.getParameter("custdiv");
			switch(div) {
			case "계좌번호":
				BankBook bankbook = new BankBook();
				bankbook.setAccountNum(search);
				Customer customer = new Customer();
				customer.setCustDiv(custdiv.equals("0")?false:true);
				bankbook.setCustCode(customer);
				List<BankBook> list = service.showBankBookByAccoutNum(bankbook);
				if(list.size()==0) {
					HashMap<String,String> map = new HashMap<>();
					map.put("errorAccountNum", "error");
					ObjectMapper om = new ObjectMapper();
					String json = om.writeValueAsString(map);
					res.setContentType("application/json;charset=UTF-8");
					PrintWriter out = res.getWriter();
					out.write(json);
					out.flush();
				}
				else {
					ObjectMapper om = new ObjectMapper();
					String json = om.writeValueAsString(list);
					res.setContentType("application/json;charset=UTF-8");
					PrintWriter out = res.getWriter();
					out.write(json);
					out.flush();
				}
				break;
			case "고객이름":
				customer = new Customer();
				customer.setCustName(search);
				customer.setCustDiv(custdiv.equals("0")?false:true);
				bankbook = new BankBook();
				bankbook.setCustCode(customer);
				list = service.showBankBookByCustName(bankbook);
				if(list.size()==0) {
					HashMap<String,String> map = new HashMap<>();
					map.put("errorCustName", "error");
					ObjectMapper om = new ObjectMapper();
					String json = om.writeValueAsString(map);
					res.setContentType("application/json;charset=UTF-8");
					PrintWriter out = res.getWriter();
					out.write(json);
					out.flush();
				}
				else {
					ObjectMapper om = new ObjectMapper();
					String json = om.writeValueAsString(list);
					res.setContentType("application/json;charset=UTF-8");
					PrintWriter out = res.getWriter();
					out.write(json);
					out.flush();
				}
				break;
			case "상품명":
				Plan plan = new Plan();
				plan.setPlanName(search);
				customer = new Customer();
				customer.setCustDiv(custdiv.equals("0")?false:true);
				bankbook = new BankBook();
				bankbook.setAccountPlanCode(plan);
				bankbook.setCustCode(customer);
				list = service.showBankBookByPlanName(bankbook);
				if(list.size()==0) {
					HashMap<String,String> map = new HashMap<>();
					map.put("errorPlanName", "error");
					ObjectMapper om = new ObjectMapper();
					String json = om.writeValueAsString(map);
					res.setContentType("application/json;charset=UTF-8");
					PrintWriter out = res.getWriter();
					out.write(json);
					out.flush();
				}
				else {
					ObjectMapper om = new ObjectMapper();
					String json = om.writeValueAsString(list);
					res.setContentType("application/json;charset=UTF-8");
					PrintWriter out = res.getWriter();
					out.write(json);
					out.flush();
				}
				break;
			case "통장상품":
				switch(search) {
				case "예금":
					customer = new Customer();
					customer.setCustDiv(custdiv.equals("0")?false:true);
					list = service.showBankBookByDeposit(customer);
					if(list.size()==0) {
						HashMap<String,String> map = new HashMap<>();
						map.put("errorNoDiv", "error");
						ObjectMapper om = new ObjectMapper();
						String json = om.writeValueAsString(map);
						res.setContentType("application/json;charset=UTF-8");
						PrintWriter out = res.getWriter();
						out.write(json);
						out.flush();
					}
					else {
						ObjectMapper om = new ObjectMapper();
						String json = om.writeValueAsString(list);
						res.setContentType("application/json;charset=UTF-8");
						PrintWriter out = res.getWriter();
						out.write(json);
						out.flush();
					}
					break;
				case "적금":
					customer = new Customer();
					customer.setCustDiv(custdiv.equals("0")?false:true);
					list = service.showBankBookBySaving(customer);
					if(list.size()==0) {
						HashMap<String,String> map = new HashMap<>();
						map.put("errorNoDiv", "error");
						ObjectMapper om = new ObjectMapper();
						String json = om.writeValueAsString(map);
						res.setContentType("application/json;charset=UTF-8");
						PrintWriter out = res.getWriter();
						out.write(json);
						out.flush();
					}
					else {
						ObjectMapper om = new ObjectMapper();
						String json = om.writeValueAsString(list);
						res.setContentType("application/json;charset=UTF-8");
						PrintWriter out = res.getWriter();
						out.write(json);
						out.flush();
					}
					break;
				case "마이너스":
					customer = new Customer();
					customer.setCustDiv(custdiv.equals("0")?false:true);
					list = service.showBankBookByMinus(customer);
					if(list.size()==0) {
						HashMap<String,String> map = new HashMap<>();
						map.put("errorNoDiv", "error");
						ObjectMapper om = new ObjectMapper();
						String json = om.writeValueAsString(map);
						res.setContentType("application/json;charset=UTF-8");
						PrintWriter out = res.getWriter();
						out.write(json);
						out.flush();
					}
					else {
						ObjectMapper om = new ObjectMapper();
						String json = om.writeValueAsString(list);
						res.setContentType("application/json;charset=UTF-8");
						PrintWriter out = res.getWriter();
						out.write(json);
						out.flush();
					}
					break;
				default :
					HashMap<String,String> map = new HashMap<>();
					map.put("errorBankBookName", "error");
					ObjectMapper om = new ObjectMapper();
					String json = om.writeValueAsString(map);
					res.setContentType("application/json;charset=UTF-8");
					PrintWriter out = res.getWriter();
					out.write(json);
					out.flush();
					break;
				}
				break;
			}
		}
		return null;
	}

}
