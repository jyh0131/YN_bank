package com.yi.handler.emp;

import java.io.File;
import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.yi.dto.Department;
import com.yi.dto.Employee;
import com.yi.mvc.CommandHandler;
import com.yi.service.EmployeeUIService;

public class empAddHandler implements CommandHandler {
     private EmployeeUIService service; 
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {

		if(req.getMethod().equalsIgnoreCase("get")) {
			return "/WEB-INF/view/emp/empForm.jsp";
			
		}else if(req.getMethod().equalsIgnoreCase("post")) {
			/*try {
				String empName = req.getParameter("empName");
				Employee emp = new Employee(empName);
				if(emp == null) {
					HashMap<String,String> map = new HashMap<>();
					map.put("error", "notExist");
					ObjectMapper om = new ObjectMapper();
					String json = om.writeValueAsString(map);
					res.setContentType("application/json;charset=UTF-8");
					PrintWriter out = res.getWriter();
					out.write(json);
					out.flush();
		
				}
				
			}catch (Exception e) {
				e.printStackTrace();
			}*/
			
			//서버안에 파일 저장 공간이 있어야 한다 -바탕화면 c드라이버 공간을 지정해줘야한다 
			String uploadPath = req.getRealPath("upload"); //서버 루트 안에 업로드 폴더 절대경로를 반환해준다
			//폴더의 존재여부를 알아봐야한다
			File dir = new File(uploadPath);
			if(dir.exists() == false) { //저장공간이 없으면 폴더를 만들어야함
				dir.mkdir(); //폴더 만들어줌
			}
			
			//있으면
			//System.out.println(uploadPath); //경로만들어지는가 확인 후 넘어간다 
			//파일을 저장해보자
			int size = 1024*1024*10; //업로드시 파일 크기 제한이 있기 때문에  10M까지만 1024 =1k *1024 =1m * 10 
			MultipartRequest multi = new MultipartRequest(
					                               req,  //매개변수는 내가 원하는 만큼
					                               uploadPath, //업로드 절대경로
			                                       size,
			                                       "UTF-8");//, //한글깨지지 말라는 것 
			                                       //new DefaultFileRenamePolicy()); //파일이 중복되었을때 바뀔 수 있도록
			//기존에 같은 이름인 파일은 바껴서 들어가야한다 //하지만 여기선 그냥 덮어쓰도록 함 
			
			//--파일 업로드 완료된 것 그 다음 일은 db에 상품을 등록해야함 
			
//			String empCode = req.getParameter("empCode");
//		    String empName = req.getParameter("empName");
//		    String empTitle = req.getParameter("empTitle");
//		    String empAuth = req.getParameter("empAuth");
//		    int empSalary = Integer.parseInt(req.getParameter("empSalary"));
//		    String empTel = req.getParameter("empTel");
//		    String empId = req.getParameter("empId");
//		    String empPwd = req.getParameter("empPwd");
//			int deptNo = Integer.parseInt(req.getParameter("deptNo"));
			
			try{Employee emp = new Employee(
					multi.getParameter("empCode"),
					multi.getParameter("empName"), 
					multi.getParameter("empTitle"), 
					multi.getParameter(null), 
					Integer.parseInt(multi.getParameter("empSalary")), 
					multi.getParameter("empTel"), 
					multi.getParameter("empId"), 
					multi.getParameter("empPwd"), 
					new Department(Integer.parseInt(multi.getParameter("deptNo"))), 
					multi.getFilesystemName("pic"));
			        
			       // 
			//System.out.println(emp);
			service = new EmployeeUIService();
			service.addEmp(emp);
			}catch (Exception e) {
			   e.printStackTrace();
			}
			
			
			res.sendRedirect(req.getContextPath()+"/emp/empSearch.do");
			return null;
		}
		
		
		
		return null;
	}

}
