package com.yi.dao;

import java.sql.SQLException;
import java.util.List;

import com.yi.dto.Plan;

public interface PlanDao {
	abstract List<Plan> selectPlanAll() throws SQLException;
	abstract int insertPlan(Plan plan) throws SQLException;
	abstract int updatePlan(Plan plan) throws SQLException;
	abstract int deletePlan(Plan plan) throws SQLException;
	abstract List<String> planExistChk() throws SQLException;
	abstract int selectPlanA() throws SQLException; //상품코드 A로 시작
	abstract int selectPlanB() throws SQLException; //상품코드 B로 시작
	abstract int selectPlanC() throws SQLException; //상품코드 C로 시작
	abstract int selectPlanAA() throws SQLException; //상품코드 AA로 시작
	abstract int selectPlanAB() throws SQLException; //상품코드 AB로 시작
	abstract int selectPlanAC() throws SQLException; //상품코드 AC로 시작
	abstract int selectPlanBA() throws SQLException; //상품코드 BA로 시작
	abstract int selectPlanBB() throws SQLException; //상품코드 BB로 시작
	abstract int selectPlanCA() throws SQLException; //상품코드 CA로 시작
	abstract int selectPlanCB() throws SQLException; //상품코드 CB로 시작
	abstract int selectPlanCC() throws SQLException; //상품코드 CC로 시작
	abstract List<Plan> selectPlanByName(String planName) throws SQLException;
	abstract List<Plan> selectPlanByCode(String planCode) throws SQLException;
	abstract List<Plan> selectPlanByDetail(String planDetail) throws SQLException;
	abstract List<Plan> selectPlanByBankBook() throws SQLException;
	abstract List<Plan> selectPlanByBankBookNormal() throws SQLException;
	abstract List<Plan> selectPlanByCard() throws SQLException;
	abstract List<Plan> selectPlanByCardNormal() throws SQLException;
	abstract List<Plan> selectPlanByLoan() throws SQLException;
	abstract List<Plan> selectPlanByLoanNormal() throws SQLException;
}
