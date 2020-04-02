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
			<h1>대출 상세정보</h1>
			<p>
				<label>계좌번호</label>
				<span>${loan.loanAccountNum}</span>
			</p>
			<p>
				<label>고객이름</label>
				<span>${loan.custCode.custName}</span>
			</p>
			<p>
				<label>상품명</label>
				<span>${loan.planCode.planName}</span>
			</p>
			<p>
				<label>대출구분</label>
				<span>${fn:substring(loan.loanAccountNum,8,9) eq '1'?'일반대출':fn:substring(loan.loanAccountNum,8,9) eq '2'?'신용대출':'카드론'}</span>
			</p>
			<p>
				<label>대출날짜</label>
				<span><fmt:formatDate value="${loan.loanDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
			</p>
			<p>
				<label>대출이자</label>
				<span><fmt:formatNumber value="${loan.loanInterest}" type="percent"/></span>
			</p>
			<p>
				<label>대출금액</label>
				<span><fmt:formatNumber value="${loan.loanBalance}" type="number" maxFractionDigits="3"/></span>
			</p>
		</div>
	</section>
</body>
</html>