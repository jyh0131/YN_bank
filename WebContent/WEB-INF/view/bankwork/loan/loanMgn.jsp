<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
		* { font-family: 'Noto Sans KR', sans-serif; }
		div#search {
			width: 900px;
			margin: 50px auto;
			text-align: center;
		}
		
		div#search select {
			width: 200px; height : 30px;
			border: none;
			font-size: 16px;
			border: 1px solid goldenrod;;
		}
		
		fieldset { position: relative;  
				   top:10px; 
		 		   display: inline-block;  
		 		   padding: 0 0 0 40px;  
		 		   background: #fff;  
		 		   border: none;  
		 		   border-radius: 5px; } 
		 		   
		input, button { position: relative;  
						width: 200px;  height: 35px;  
						padding: 0;  
						display: inline-block;  
						float: left; }
		input {  color: #666;  
		 		 z-index: 2; 
		 		 border:none;  
		 		 border-bottom: 1px solid goldenrod; }
		input:focus {  outline: 0 none; } 

	
		button { z-index: 1;  
				 width: 40px;  
				 border: 0 none;  
				 background: goldenrod;  
				 cursor: pointer;  
				 border-radius: 0 5px 5px 0;
				 background-image: url("${pageContext.request.contextPath}/images/search.png");
				 background-size: 25px; 
				 background-repeat: no-repeat; 
				 background-position: center;}
		.fa-search { font-size: 1.4rem;  
					 color: #29abe2;  
					 z-index: 3;  
					 top: 25%;  }
		
		
		div#table {
			width: 900px;
			margin: 100px auto;
		}
		
		div#table table {
			border-collapse: collapse; 
		}
		
		div#table th, td {
			width: 200px; 
			height: 30px;
			text-align: center;
			font-size: 15px;
		}
		
		div#table tr:nth-child(odd) {
			width: 200px; 
			height: 30px;
			text-align: center;
			background: gainsboro;
			font-size: 15px;
		}
		
		div#table tr:hover td { background: goldenrod;}
		
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	$(function(){
		$("button").eq(0).click(function() {
			switch($("#searchMenu option:selected").val()) {
			case "검색구분":
				alert("검색 구분을 선택해주세요");
				$("input[name='search']").val("");
				break;
			case "계좌번호":
				var div = $("#searchMenu option:selected").val();
				var search = $("input[name='search']").val();
				if(search=="") {
					alert("계좌번호를 입력하세요");
					return;
				}
				$.ajax({
					url: "${pageContext.request.contextPath}/bankwork/loan/mgn.do",
				    data: {search:search,div:div},
				    type: "POST", 
				    dataType: "json",
				    success : function(res) {
				    	if(res.errorAccountNum!=null) {
				    		alert("그런 계좌번호는 없습니다. 다시 입력하세요");
				    		$("input[name='search']").val("");
				    	}
				    	else {
				    		console.log(res);
				    		$("#table table").remove();
				    		var table = $("<table>");
				    		var tr = $("<tr>");
				    		var th1 = $("<th>").html("계좌번호");
				    		var th2 = $("<th>").html("고객이름");
				    		var th3 = $("<th>").html("상품명");
				    		var th4 = $("<th>").html("대출구분");
				    		var th5 = $("<th>").html("대출날짜");
				    		var th6 = $("<th>").html("대출이자");
				    		var th7 = $("<th>").html("대출금액");
				    		tr.append(th1).append(th2).append(th3).append(th4).append(th5).append(th6).append(th7);
				    		table.append(tr);
							$(res).each(function(i, obj) {
								var tr = $("<tr>");
								var a = []
								a[0] = $("<a>").html(obj.loanAccountNum).attr("href","${pageContext.request.contextPath}/bankwork/bankbook/detail.do?accountnum="+obj.loanAccountNum+"&custname="+obj.custCode.custName);
								a[1] = $("<a>").html(obj.custCode.custName).attr("href","${pageContext.request.contextPath}/bankwork/bankbook/detail.do?accountnum="+obj.loanAccountNum+"&custname="+obj.custCode.custName);
								a[2] = $("<a>").html(obj.planCode.planName).attr("href","${pageContext.request.contextPath}/bankwork/bankbook/detail.do?accountnum="+obj.loanAccountNum+"&custname="+obj.custCode.custName);
								var str = obj.loanAccountNum;
								var div = str.substring(8, 9)=='1'?"일반대출": str.substring(8, 9)=='2'?"신용대출":"카드론";
								a[3] = $("<a>").html(div).attr("href","${pageContext.request.contextPath}/bankwork/bankbook/detail.do?accountnum="+obj.loanAccountNum+"&custname="+obj.custCode.custName);
								var date = new Date(obj.loanDate);
								var dateFormat = date.getFullYear() + '-' +('0' + (date.getMonth()+1)).slice(-2)+ '-' +  ('0' + date.getDate()).slice(-2) + ' '+('0' + (date.getHours())).slice(-2)+ ':'+('0' + (date.getMinutes())).slice(-2)+ ':'+date.getSeconds();
								a[4] = $("<a>").html(dateFormat).attr("href","${pageContext.request.contextPath}/bankwork/bankbook/detail.do?accountnum="+obj.loanAccountNum+"&custname="+obj.custCode.custName);
								var interestToPercent = Math.floor(obj.loanInterest * 100);
								a[5] = $("<a>").html(interestToPercent + "%").attr("href","${pageContext.request.contextPath}/bankwork/bankbook/detail.do?accountnum="+obj.loanAccountNum+"&custname="+obj.custCode.custName);
								a[6] = $("<a>").html(obj.loanBalance.toLocaleString()).attr("href","${pageContext.request.contextPath}/bankwork/bankbook/detail.do?accountnum="+obj.loanAccountNum+"&custname="+obj.custCode.custName);
								$(a).each(function(i, obj) {
									var td = $("<td>").append(a[i]);
									tr.append(td);
								})
								table.append(tr);
							})
							$("#table").append(table);
				    	}
				    }
				})
				break;
			case "고객이름":
				var div = $("#searchMenu option:selected").val();
				var search = $("input[name='search']").val();
				if(search=="") {
					alert("고객 이름을 입력하세요");
					return;
				}
				$.ajax({
					url: "${pageContext.request.contextPath}/bankwork/loan/mgn.do",
				    data: {search:search,div:div},
				    type: "POST", 
				    dataType: "json",
				    success : function(res) {
				    	if(res.errorCustName!=null) {
				    		alert("그런 고객은 없습니다. 다시 입력하세요");
				    		$("input[name='search']").val("");
				    	}
				    	else {
				    		console.log(res);
				    		$("#table table").remove();
				    		var table = $("<table>");
				    		var tr = $("<tr>");
				    		var th1 = $("<th>").html("계좌번호");
				    		var th2 = $("<th>").html("고객이름");
				    		var th3 = $("<th>").html("상품명");
				    		var th4 = $("<th>").html("대출구분");
				    		var th5 = $("<th>").html("대출날짜");
				    		var th6 = $("<th>").html("대출이자");
				    		var th7 = $("<th>").html("대출금액");
				    		tr.append(th1).append(th2).append(th3).append(th4).append(th5).append(th6).append(th7);
				    		table.append(tr);
							$(res).each(function(i, obj) {
								var tr = $("<tr>");
								var a = []
								a[0] = $("<a>").html(obj.loanAccountNum).attr("href","${pageContext.request.contextPath}/bankwork/bankbook/detail.do?accountnum="+obj.loanAccountNum+"&custname="+obj.custCode.custName);
								a[1] = $("<a>").html(obj.custCode.custName).attr("href","${pageContext.request.contextPath}/bankwork/bankbook/detail.do?accountnum="+obj.loanAccountNum+"&custname="+obj.custCode.custName);
								a[2] = $("<a>").html(obj.planCode.planName).attr("href","${pageContext.request.contextPath}/bankwork/bankbook/detail.do?accountnum="+obj.loanAccountNum+"&custname="+obj.custCode.custName);
								var str = obj.loanAccountNum;
								var div = str.substring(8, 9)=='1'?"일반대출": str.substring(8, 9)=='2'?"신용대출":"카드론";
								a[3] = $("<a>").html(div).attr("href","${pageContext.request.contextPath}/bankwork/bankbook/detail.do?accountnum="+obj.loanAccountNum+"&custname="+obj.custCode.custName);
								var date = new Date(obj.loanDate);
								var dateFormat = date.getFullYear() + '-' +('0' + (date.getMonth()+1)).slice(-2)+ '-' +  ('0' + date.getDate()).slice(-2) + ' '+('0' + (date.getHours())).slice(-2)+ ':'+('0' + (date.getMinutes())).slice(-2)+ ':'+date.getSeconds();
								a[4] = $("<a>").html(dateFormat).attr("href","${pageContext.request.contextPath}/bankwork/bankbook/detail.do?accountnum="+obj.loanAccountNum+"&custname="+obj.custCode.custName);
								var interestToPercent = Math.floor(obj.loanInterest * 100);
								a[5] = $("<a>").html(interestToPercent + "%").attr("href","${pageContext.request.contextPath}/bankwork/bankbook/detail.do?accountnum="+obj.loanAccountNum+"&custname="+obj.custCode.custName);
								a[6] = $("<a>").html(obj.loanBalance.toLocaleString()).attr("href","${pageContext.request.contextPath}/bankwork/bankbook/detail.do?accountnum="+obj.loanAccountNum+"&custname="+obj.custCode.custName);
								$(a).each(function(i, obj) {
									var td = $("<td>").append(a[i]);
									tr.append(td);
								})
								table.append(tr);
							})
							$("#table").append(table);
				    	}
				    }
				})
				break;
			case "상품명":
				var div = $("#searchMenu option:selected").val();
				var search = $("input[name='search']").val();
				if(search=="") {
					alert("상품명을 입력하세요");
					return;
				}
				$.ajax({
					url: "${pageContext.request.contextPath}/bankwork/loan/mgn.do",
				    data: {search:search,div:div},
				    type: "POST", 
				    dataType: "json",
				    success : function(res) {
				    	if(res.errorPlanName!=null) {
				    		alert("그런 상품은 없습니다. 다시 입력하세요");
				    		$("input[name='search']").val("");
				    	}
				    	else {
				    		console.log(res);
				    		$("#table table").remove();
				    		var table = $("<table>");
				    		var tr = $("<tr>");
				    		var th1 = $("<th>").html("계좌번호");
				    		var th2 = $("<th>").html("고객이름");
				    		var th3 = $("<th>").html("상품명");
				    		var th4 = $("<th>").html("대출구분");
				    		var th5 = $("<th>").html("대출날짜");
				    		var th6 = $("<th>").html("대출이자");
				    		var th7 = $("<th>").html("대출금액");
				    		tr.append(th1).append(th2).append(th3).append(th4).append(th5).append(th6).append(th7);
				    		table.append(tr);
							$(res).each(function(i, obj) {
								var tr = $("<tr>");
								var a = []
								a[0] = $("<a>").html(obj.loanAccountNum).attr("href","${pageContext.request.contextPath}/bankwork/bankbook/detail.do?accountnum="+obj.loanAccountNum+"&custname="+obj.custCode.custName);
								a[1] = $("<a>").html(obj.custCode.custName).attr("href","${pageContext.request.contextPath}/bankwork/bankbook/detail.do?accountnum="+obj.loanAccountNum+"&custname="+obj.custCode.custName);
								a[2] = $("<a>").html(obj.planCode.planName).attr("href","${pageContext.request.contextPath}/bankwork/bankbook/detail.do?accountnum="+obj.loanAccountNum+"&custname="+obj.custCode.custName);
								var str = obj.loanAccountNum;
								var div = str.substring(8, 9)=='1'?"일반대출": str.substring(8, 9)=='2'?"신용대출":"카드론";
								a[3] = $("<a>").html(div).attr("href","${pageContext.request.contextPath}/bankwork/bankbook/detail.do?accountnum="+obj.loanAccountNum+"&custname="+obj.custCode.custName);
								var date = new Date(obj.loanDate);
								var dateFormat = date.getFullYear() + '-' +('0' + (date.getMonth()+1)).slice(-2)+ '-' +  ('0' + date.getDate()).slice(-2) + ' '+('0' + (date.getHours())).slice(-2)+ ':'+('0' + (date.getMinutes())).slice(-2)+ ':'+date.getSeconds();
								a[4] = $("<a>").html(dateFormat).attr("href","${pageContext.request.contextPath}/bankwork/bankbook/detail.do?accountnum="+obj.loanAccountNum+"&custname="+obj.custCode.custName);
								var interestToPercent = Math.floor(obj.loanInterest * 100);
								a[5] = $("<a>").html(interestToPercent + "%").attr("href","${pageContext.request.contextPath}/bankwork/bankbook/detail.do?accountnum="+obj.loanAccountNum+"&custname="+obj.custCode.custName);
								a[6] = $("<a>").html(obj.loanBalance.toLocaleString()).attr("href","${pageContext.request.contextPath}/bankwork/bankbook/detail.do?accountnum="+obj.loanAccountNum+"&custname="+obj.custCode.custName);
								$(a).each(function(i, obj) {
									var td = $("<td>").append(a[i]);
									tr.append(td);
								})
								table.append(tr);
							})
							$("#table").append(table);
				    	}
				    }
				})
				break;
			}
		})
		$("select").on("change", function() {
			$("table").load(location.href + " table");
			$("input[name='search']").val("");
		})
	})
</script>
</head>
<body>
	<section>
	<jsp:include page="../../include/menu.jsp"/>
		<div id="search">
				<select id="searchMenu">
					<option>검색구분</option>
					<option>계좌번호</option>
					<option>고객이름</option>
					<option>상품명</option>
				</select>
				<fieldset>
					<input type="search" name="search"/>
					<button type="submit">
						<i class="fa fa-search"></i>
					</button>	
				</fieldset>
		</div>
		<div id="table">
			<table>
				<tr>
					<th>계좌번호</th>
					<th>고객이름</th>
					<th>상품명</th>
					<th>대출구분</th>
					<th>대출날짜</th>
					<th>대출이자</th>
					<th>대출금액</th>
				</tr>
				<c:forEach var="loan" items="${list}">
				<tr>
					<td><a href="${pageContext.request.contextPath}/bankwork/loan/detail.do?loanaccountnum=${loan.loanAccountNum}&custname=${loan.custCode.custName}">${loan.loanAccountNum}</a></td>
					<td><a href="${pageContext.request.contextPath}/bankwork/loan/detail.do?loanaccountnum=${loan.loanAccountNum}&custname=${loan.custCode.custName}">${loan.custCode.custName}</a></td>
					<td><a href="${pageContext.request.contextPath}/bankwork/loan/detail.do?loanaccountnum=${loan.loanAccountNum}&custname=${loan.custCode.custName}">${loan.planCode.planName}</a></td>
					<td><a href="${pageContext.request.contextPath}/bankwork/loan/detail.do?loanaccountnum=${loan.loanAccountNum}&custname=${loan.custCode.custName}">${fn:substring(loan.loanAccountNum,8,9) eq '1'?'일반대출':fn:substring(loan.loanAccountNum,8,9) eq '2'?'신용대출':'카드론'}</a></td>
					<td><a href="${pageContext.request.contextPath}/bankwork/loan/detail.do?loanaccountnum=${loan.loanAccountNum}&custname=${loan.custCode.custName}"><fmt:formatDate value="${loan.loanDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a></td>
					<td><a href="${pageContext.request.contextPath}/bankwork/loan/detail.do?loanaccountnum=${loan.loanAccountNum}&custname=${loan.custCode.custName}"><fmt:formatNumber value="${loan.loanInterest}" type="percent"/></a></td>
					<td><a href="${pageContext.request.contextPath}/bankwork/loan/detail.do?loanaccountnum=${loan.loanAccountNum}&custname=${loan.custCode.custName}"><fmt:formatNumber value="${loan.loanBalance}" type="number" maxFractionDigits="3"/></a></td>
				</tr>
				</c:forEach>
			</table>
		</div>
	</section>
</body>
</html>