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
			<h1>카드 상세정보</h1>
			<p>
				<label>카드번호</label>
				<span>${card.cardNum}</span>
			</p>
			<p>
				<label>고객이름</label>
				<span>${card.custCode.custName}</span>
			</p>
			<p>
				<label>상품명</label>
				<span>${card.planCode.planName}</span>
			</p>
			<p>
				<label>카드구분</label>
				<span>${fn:substring(card.cardNum,6,7) eq '1'?'체크카드':'신용카드'}</span>
			</p>
			<p>
				<label>카드발급일</label>
				<span><fmt:formatDate value="${card.cardIssueDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
			</p>
			<p>
				<label>카드한도</label>
				<span><fmt:formatNumber value="${card.cardLimit}" type="number" maxFractionDigits="3"/></span>
			</p>
			<p>
				<label>카드잔액</label>
				<span><fmt:formatNumber value="${card.cardBalance}" type="number" maxFractionDigits="3"/></span>
			</p>
		</div>
	</section>
</body>
</html>