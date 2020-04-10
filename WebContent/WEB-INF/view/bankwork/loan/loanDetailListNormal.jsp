<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>
<%@include file="../../include/sectionBar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/6f2f0f2d95.js"></script>
<style>
		* { font-family: 'Noto Sans KR', sans-serif; }
		h2#menuLocation { width: 250px; height: 60px;  
						  line-height: 60px; 
						  margin: 0 500px;      
						  border-bottom: 2px solid #e9ebec;} 
		div#search {
			width: 900px;
			margin: 50px 0;
			margin-left : 600px;
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
		

		span#guide { font-weight: bold; 
					 font-size: 15px;    
					  }
		
		div#table {
			width: 1300px;
			margin: 100px 0;
			margin-left : 400px;
		}
		
		div#table table {
			border-collapse: collapse; 
		}
		
		div#table th, td {
			width: 200px; 
			height: 30px;
			text-align: center;
			font-size: 13px; 
		}
		
		div#table tr:nth-child(odd) {
			width: 200px; 
			height: 30px;
			text-align: center;
			background: gainsboro;
			font-size: 15px;
		}
		
		div#table tr:hover td { background: goldenrod;}
		div#dummy { height: 75px; background: #292929;}
		
		#btnMenu1 {
		   margin-left: 20px;
		   width:150px;
		   border:2px solid goldenrod;
		   border-radius: 10px;
		   background: none;
		   margin-left : 400px;
		}
		#btnMenu1:hover {
		   background: goldenrod;
		   font-weight: bold;
		}
		
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	$(function(){
		$("#loanAdd").show();
		$("#loanList").show();
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
					url: "${pageContext.request.contextPath}/bankwork/loan/mgn.do?custdiv=${custdiv}",
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
								var tr = $("<tr>").attr("data-accountNum",obj.loanAccountNum).attr("data-custName",obj.custCode.custName).addClass("pickedOne");
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
					url: "${pageContext.request.contextPath}/bankwork/loan/mgn.do?custdiv=${custdiv}",
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
								var tr = $("<tr>").attr("data-accountNum",obj.loanAccountNum).attr("data-custName",obj.custCode.custName).addClass("pickedOne");
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
					url: "${pageContext.request.contextPath}/bankwork/loan/mgn.do?custdiv=${custdiv}",
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
								var tr = $("<tr>").attr("data-accountNum",obj.loanAccountNum).attr("data-custName",obj.custCode.custName).addClass("pickedOne");
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
		$("#btnMenu1").click(function() {
			var accountnum = $("#accountnum").attr("data-accountnum");
			var custname = $("#custname").attr("data-custname");
			location.href="${pageContext.request.contextPath}/bankwork/loan/detail.do?loanaccountnum="+accountnum+"&custname="+custname;
		})
	})
</script>
</head>
<body>
	<section>
	<jsp:include page="../../include/menu.jsp"/>
	<h2 id="menuLocation">대출 상환 세부 내역</h2>
		<div id="search">
				<select id="searchMenu">
					<option>검색구분</option>
					<option>계좌번호</option>
					<option>고객이름</option>
					<option>상품명</option>
				</select>
				<fieldset>
					<input type="search" name="search" placeholder="검색어를 입력하세요."/>
					<button type="submit">
						<i class="fa fa-search"></i>
					</button>	
				</fieldset>
		</div>
		<button id="btnMenu1">돌아가기</button>
		<div id="table">
			<table>
				<tr>
					<th>계좌번호</th>
					<th>고객이름</th>
					<th>상품명</th>
					<th>대출구분</th>
					<th>대출시작일</th>
					<th>거치일</th>
					<th>대출만기일</th>
					<th>대출납입회차</th>
					<th>대출방식</th>
					<th>대출이자</th>
					<th>상환액</th>
					<th>잔여대출금액</th>
				</tr>
				<c:forEach var="loan" items="${list}">
				<tr>
					<td data-accountnum="${loan.loanAccountNum}" id="accountnum">${loan.loanAccountNum}</td>
					<td data-custname="${loan.cust.custName}" id="custname">${loan.cust.custName}</td>
					<td>${loan.plan.planName}</td>
					<td>${fn:substring(loan.loanAccountNum,8,9) eq '1'?'일반대출':fn:substring(loan.loanAccountNum,8,9) eq '2'?'신용대출':'카드론'}</td>
					<td><fmt:formatDate value="${loan.loanStartDate}" pattern="yyyy-MM-dd"/></td>
					<td><fmt:formatDate value="${loan.loanDelayDate}" pattern="yyyy-MM-dd"/></td>
					<td><fmt:formatDate value="${loan.loanExpireDate}" pattern="yyyy-MM-dd"/></td>
					<td>${loan.loanRound}회차</td>
					<td>${loan.loanMethod eq 'A'?'만기일시상환':'원금균등상환'}</td>
					<td><fmt:formatNumber value="${loan.loanInterest}" type="percent"/></td>
					<td><fmt:formatNumber value="${loan.loanRepayment}" type="number" maxFractionDigits="3"/></td>
					<td><fmt:formatNumber value="${loan.loanBalance}" type="number" maxFractionDigits="3"/></td>
				</tr>
				</c:forEach>
			</table>
		</div>
	</section>
</body>
</html>