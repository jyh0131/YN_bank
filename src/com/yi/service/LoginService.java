package com.yi.service;

import java.sql.SQLException;

import com.yi.dao.EmployeeDao;
import com.yi.dao.impl.EmployeeDaoImpl;
import com.yi.dto.Employee;

public class LoginService {
	private EmployeeDao dao;
	
	public LoginService() {
		dao = EmployeeDaoImpl.getInstance();
	}

	public Employee GetLoginInfo(Employee emp) throws SQLException {
		return dao.getEmpIdPass(emp);
	}
	public Employee GetEmpAuth(Employee emp) throws SQLException {
		return dao.getEmpAuth(emp);
	}
}
