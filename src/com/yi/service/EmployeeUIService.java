package com.yi.service;

import java.sql.SQLException;
import java.util.List;

import com.yi.dao.EmployeeDao;
import com.yi.dao.impl.EmployeeDaoImpl;
import com.yi.dto.Department;
import com.yi.dto.Employee;

public class EmployeeUIService {
    private  EmployeeDao empDao;
    
    
    public EmployeeUIService() {
    	empDao = EmployeeDaoImpl.getInstance();
    }
    
    
    public List<Employee> showEmpList(){
    	return empDao.selectEmployeeByAll();
    }
    
    public Employee showPickedEmp2(String empCode) throws SQLException{
    	return empDao.selectEmpByEmpCode(empCode);
    }
    
    //아이디 중복 확인
    public Employee forCheckId(String empId) throws SQLException{
    	return empDao.selectEmpByEmpId(empId);
    }
    
    //사원 이름으로 검색
    public List<Employee> showPickedEmpList(String empName) throws SQLException{
    	return empDao.selectEmpByNameList(empName);
    }
    public Employee showPickedEmp(String empName) throws SQLException{
    	return empDao.selectEmpByName(empName);
    }
    public Employee showPikedEmpByCode(String empCode) throws SQLException{
    	return empDao.selectEmpByCode(empCode);
    }
    public List<Employee> showPickedEmpByDept(String empItem) throws SQLException{
    	return empDao.selectEmpByDept(empItem);
    }
    
    public List<Employee> showPickedEmpByDeptNo(int empItem) throws SQLException{
    	return empDao.selectEmpByDeptNo(empItem);
    }
    
    public List<Employee> showPickedEmpByEmpNo(String empItem) throws SQLException{
    	return empDao.selectEmpByNo(empItem);
    }
    public List<Employee> showPickedEmpByTitle(String empItem) throws SQLException{
    	return empDao.selectEmpByTitle(empItem);
    }
    
    
    //퍼포먼스 테이블 리스트 불러오기
    
    public List<Employee> showPickedEmpListForPerform(String empItem) throws SQLException{
    	return empDao.selectEmpByNameListForPerform(empItem);
    }
    public List<Employee> showPickedEmpByDeptForPerform(String empItem) throws SQLException{
    	return empDao.selectEmpByDeptForPerform(empItem);
    }
    public List<Employee> showPickedEmpByEmpNoForPerform(String empItem) throws SQLException{
    	return empDao.selectEmpByNoForPerform(empItem);
    }
    public List<Employee> showPickedEmpByTitleForPerform(String empItem) throws SQLException{
    	return empDao.selectEmpByTitleForPerform(empItem);
    }
    
    //사원 랭킹 리스트 부르기
    public List<Employee> showRank(){
    	return empDao.selectRank();
    }
    
    
    
    
    
    public List<Department> showDeptList(){
    	return empDao.selectDeptByAll();
    }
    
    
    public void removeEmp(Employee emp) {
    	empDao.deleteEmployee(emp);
    }
    
    //insert하는 부분 
    public void addEmp(Employee emp) {
    	empDao.insertEmployee(emp);
    }
    
    public void modifyEmp(Employee emp) {
    	empDao.updateEmployee(emp);
    }
    
    //비밀번호 제외하고 업데이트
    public void modifyEmpExceptForPwd(Employee emp) {
    	empDao.updateEmployeeNotPw(emp);
    }    
    
    public void modifyEmpAuth(Employee emp) {
    	empDao.updateEmployeeAuth(emp);
    }
    
    //사원 실적까지 포함
    public List<Employee> showEmpPerformance(){
    	return empDao.selectEmployeeByPerform();
    }
    
    public Employee showEmpPerformPicked(String empName) throws SQLException {
    	return empDao.selectOneEmployeeByPerform(empName);
    }
    
    
    //전체 사원 수 구하기
    public int countAllEmpNum() {
    	return empDao.selectCountAllEmployee();
    	
    }
    //부서별 사원 수 구하기
    // 인사부 - 1번  고객팀 2번
    public int countMemberByDepartment(int deptNo) {
    	return empDao.selectCountMemberByDept(deptNo);
    }
    
    //타이틀마다 사원 수 구하기{  
    public int countMemberByTitle(String empTitle) {
    	return empDao.selectCountMemberByTitle(empTitle);
    }
    
    //1인 평균 월급
    public int avgOfSalary() {
    	return empDao.selectAvgOfSalary();   	
    }
    //전체 월급 액수 
    public int totalSalary() {
    	return empDao.selectTotalSalary();
    }
    
    
 
    
}
