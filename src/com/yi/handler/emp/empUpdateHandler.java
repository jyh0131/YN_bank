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

public class empUpdateHandler implements CommandHandler {
     private EmployeeUIService service = new EmployeeUIService();
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {

		if(req.getMethod().equalsIgnoreCase("get")) {
			return "/WEB-INF/view/emp/empFormForUpdate.jsp";
			
		}else if(req.getMethod().equalsIgnoreCase("post")) {
			
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
			
			//--파일 업로드 완료된 것 
			
          try { 
        	    String empCode = multi.getParameter("empCode");   
		        String empName = multi.getParameter("empName");
			    String empTitle = multi.getParameter("empTitle");
			    String empAuth = multi.getParameter("empAuth");
			    int empSalary = Integer.parseInt(multi.getParameter("empSalary"));
			    String empTel = multi.getParameter("empTel");
			    String empId = multi.getParameter("empId");
			    //String empPwd = multi.getParameter("empPwd");
				Department dept = new Department(Integer.parseInt(multi.getParameter("deptNo")));
				dept.setDeptName(dept.getDeptNo()==1?"인사":"고객");
				String pic = multi.getFilesystemName("pic");
				
				//System.out.println("pic은"+pic);
				
				Employee dbEmp = service.showPickedEmp2(empCode);
				System.out.println("db상의 데이터"+dbEmp);
				String dbPic = dbEmp.getPic();
				String empPwd = dbEmp.getEmpPwd();
				System.out.println("dbPic은"+dbPic);
		/*
           emp.setEmpName(multi.getParameter("empName"));
           emp.setEmpTitle(multi.getParameter("empTitle"));
           emp.setEmpAuth(multi.getParameter("empAuth"));
           emp.setEmpSalary(Integer.parseInt(multi.getParameter("empSalary")));
           emp.setEmpTel(multi.getParameter("empTel"));
           emp.setEmpId(multi.getParameter("empId"));
           emp.setEmpPwd(multi.getParameter("empPwd"));
           emp.setDept(new Department(Integer.parseInt(multi.getParameter("deptNo"))));
           emp.setPic(multi.getFilesystemName("pic"));*/
           
//		   Employee emp = new Employee(
//					multi.getParameter("empCode"),
//					multi.getParameter("empName"), 
//					multi.getParameter("empTitle"), 
//					multi.getParameter("empAuth"), 
//					Integer.parseInt(multi.getParameter("empSalary")), 
//					multi.getParameter("empTel"), 
//					multi.getParameter("empId"), 
//					multi.getParameter("empPwd"), 
//					new Department(Integer.parseInt(multi.getParameter("deptNo"))), 
//					multi.getFilesystemName("pic"));
//			        
//			       // 
				
				
			Employee emp = new Employee(empCode, empName, empTitle, empAuth, empSalary, empTel, empId, empPwd, dept, pic==null?dbPic:pic);
				
			System.out.println("만들어진 emp"+emp);
			
			if(empPwd.contentEquals("**********")) {
				service.modifyEmpExceptForPwd(emp);
				System.out.println("비번뺀 emp"+emp);
			}else {
			service.modifyEmp(emp);
			   System.out.println("비번도 바꾼 emp"+emp);
			}
			}catch (Exception e) {
			   e.printStackTrace();
			}
			
			
			res.sendRedirect(req.getContextPath()+"/emp/empSearch.do");
			return null;
		}
		
		
		
		return null;
	}

}