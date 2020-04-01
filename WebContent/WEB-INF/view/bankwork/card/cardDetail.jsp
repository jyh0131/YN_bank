<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	section #detailMenu {
		width : 1000px;
		margin : 50px auto;
	}
</style>
</head>
<body>
	<section>
		<jsp:include page="../../include/menu.jsp"/>
		<div id="detailMenu">
			<h1>통장 상세정보</h1>
			<p>
				<label>계좌번호</label>
				<span>${bankbook.accountNum}</span>
			</p>
			<p>
				<label>고객이름</label>
				<span>${bankbook.custCode.custName}</span>
			</p>
			<p>
				<label>상품명</label>
				<span>${bankbook.accountPlanCode.planName}</span>
			</p>
			<p>
				<label>통장구분</label>
				<span>${fn:substring(bankbook.accountNum,8,9) eq '1'?'예금':fn:substring(bankbook.accountNum,8,9) eq '2'?'적금':'마이너스'}</span>
			</p>
			<p>
				<label>계좌개설일</label>
				<span><fmt:formatDate value="${bankbook.accountOpenDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
			</p>
			<p>
				<label>이자율</label>
				<span><fmt:formatNumber value="${bankbook.accountInterest}" type="percent"/></span>
			</p>
		</div>
	</section>
</body>
</html>