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
				 background-image: url("images/search.png");
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
				$.ajax({
					url: "${pageContext.request.contextPath}/bankwork/bankbook/mgn.do",
				    data: {search:search,div:div},
				    type: "POST", 
				    dataType: "json",
				    success : function(res) {
				    	if(res.errorAccountNum!=null) {
				    		alert("그런 계좌번호는 없습니다. 다시 입력하세요");
				    	}
				    	else {
				    		console.log(res);
				    		$("#table table").remove();
				    		var table = $("<table>");
				    		var tr = $("<tr>");
				    		var th1 = $("<th>").html("계좌번호");
				    		var th2 = $("<th>").html("고객이름");
				    		var th3 = $("<th>").html("상품명");
				    		var th4 = $("<th>").html("통장구분");
				    		var th5 = $("<th>").html("계좌개설일");
				    		var th6 = $("<th>").html("이자율");
				    		tr.append(th1).append(th2).append(th3).append(th4).append(th5).append(th6);
				    		table.append(tr);
							$(res).each(function(i, obj) {
								var tr = $("<tr>");
								var td1 = $("<td>").html(obj.accountNum);
								var td2 = $("<td>").html(obj.custCode.custName);
								var td3 = $("<td>").html(obj.accountPlanCode.planName);
								var str = obj.accountNum;
								var div = str.substring(8, 9)=='1'?"예금": str.substring(8, 9)=='2'?"적금":"마이너스";
								var td4 = $("<td>").html(div);
								var date = new Date(obj.accountOpenDate);
								var dateFormat = date.getFullYear() + '-' +('0' + (date.getMonth()+1)).slice(-2)+ '-' +  ('0' + date.getDate()).slice(-2) + ' '+date.getHours()+ ':'+('0' + (date.getMinutes())).slice(-2)+ ':'+date.getSeconds();
								var td5 = $("<td>").html(dateFormat);
								var interestToPercent = obj.accountInterest * 100;
								var td6 = $("<td>").html(interestToPercent + "%");
								tr.append(td1).append(td2).append(td3).append(td4).append(td5).append(td6);
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
				$.ajax({
					url: "${pageContext.request.contextPath}/bankwork/bankbook/mgn.do",
				    data: {search:search,div:div},
				    type: "POST", 
				    dataType: "json",
				    success : function(res) {
				    	if(res.errorCustName!=null) {
				    		alert("그런 고객은 없습니다. 다시 입력하세요");
				    	}
				    	else {
				    		console.log(res);
				    		$("#table table").remove();
				    		var table = $("<table>");
				    		var tr = $("<tr>");
				    		var th1 = $("<th>").html("계좌번호");
				    		var th2 = $("<th>").html("고객이름");
				    		var th3 = $("<th>").html("상품명");
				    		var th4 = $("<th>").html("통장구분");
				    		var th5 = $("<th>").html("계좌개설일");
				    		var th6 = $("<th>").html("이자율");
				    		tr.append(th1).append(th2).append(th3).append(th4).append(th5).append(th6);
				    		table.append(tr);
							$(res).each(function(i, obj) {
								var tr = $("<tr>");
								var td1 = $("<td>").html(obj.accountNum);
								var td2 = $("<td>").html(obj.custCode.custName);
								var td3 = $("<td>").html(obj.accountPlanCode.planName);
								var str = obj.accountNum;
								var div = str.substring(8, 9)=='1'?"예금": str.substring(8, 9)=='2'?"적금":"마이너스";
								var td4 = $("<td>").html(div);
								var date = new Date(obj.accountOpenDate);
								var dateFormat = date.getFullYear() + '-' +('0' + (date.getMonth()+1)).slice(-2)+ '-' +  ('0' + date.getDate()).slice(-2) + ' '+date.getHours()+ ':'+('0' + (date.getMinutes())).slice(-2)+ ':'+date.getSeconds();
								var td5 = $("<td>").html(dateFormat);
								var interestToPercent = obj.accountInterest * 100;
								var td6 = $("<td>").html(interestToPercent + "%");
								tr.append(td1).append(td2).append(td3).append(td4).append(td5).append(td6);
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
				$.ajax({
					url: "${pageContext.request.contextPath}/bankwork/bankbook/mgn.do",
				    data: {search:search,div:div},
				    type: "POST", 
				    dataType: "json",
				    success : function(res) {
				    	if(res.errorPlanName!=null) {
				    		alert("그런 상품은 없습니다. 다시 입력하세요");
				    	}
				    	else {
				    		console.log(res);
				    		$("#table table").remove();
				    		var table = $("<table>");
				    		var tr = $("<tr>");
				    		var th1 = $("<th>").html("계좌번호");
				    		var th2 = $("<th>").html("고객이름");
				    		var th3 = $("<th>").html("상품명");
				    		var th4 = $("<th>").html("통장구분");
				    		var th5 = $("<th>").html("계좌개설일");
				    		var th6 = $("<th>").html("이자율");
				    		tr.append(th1).append(th2).append(th3).append(th4).append(th5).append(th6);
				    		table.append(tr);
							$(res).each(function(i, obj) {
								var tr = $("<tr>");
								var td1 = $("<td>").html(obj.accountNum);
								var td2 = $("<td>").html(obj.custCode.custName);
								var td3 = $("<td>").html(obj.accountPlanCode.planName);
								var str = obj.accountNum;
								var div = str.substring(8, 9)=='1'?"예금": str.substring(8, 9)=='2'?"적금":"마이너스";
								var td4 = $("<td>").html(div);
								var date = new Date(obj.accountOpenDate);
								var dateFormat = date.getFullYear() + '-' +('0' + (date.getMonth()+1)).slice(-2)+ '-' +  ('0' + date.getDate()).slice(-2) + ' '+date.getHours()+ ':'+('0' + (date.getMinutes())).slice(-2)+ ':'+date.getSeconds();
								var td5 = $("<td>").html(dateFormat);
								var interestToPercent = obj.accountInterest * 100;
								var td6 = $("<td>").html(interestToPercent + "%");
								tr.append(td1).append(td2).append(td3).append(td4).append(td5).append(td6);
								table.append(tr);
							})
							$("#table").append(table);
				    	}
				    }
				})
				break;
			case "통장상품":
				var div = $("#searchMenu option:selected").val();
				var search = $("input[name='search']").val();
				$.ajax({
					url: "${pageContext.request.contextPath}/bankwork/bankbook/mgn.do",
				    data: {search:search,div:div},
				    type: "POST", 
				    dataType: "json",
				    success : function(res) {
				    	if(res.errorBankBookName!=null) {
				    		alert("예금,적금,마이너스만 입력하세요");
				    	}
				    	else {
				    		console.log(res);
				    		$("#table table").remove();
				    		var table = $("<table>");
				    		var tr = $("<tr>");
				    		var th1 = $("<th>").html("계좌번호");
				    		var th2 = $("<th>").html("고객이름");
				    		var th3 = $("<th>").html("상품명");
				    		var th4 = $("<th>").html("통장구분");
				    		var th5 = $("<th>").html("계좌개설일");
				    		var th6 = $("<th>").html("이자율");
				    		tr.append(th1).append(th2).append(th3).append(th4).append(th5).append(th6);
				    		table.append(tr);
							$(res).each(function(i, obj) {
								var tr = $("<tr>");
								var td1 = $("<td>").html(obj.accountNum);
								var td2 = $("<td>").html(obj.custCode.custName);
								var td3 = $("<td>").html(obj.accountPlanCode.planName);
								var str = obj.accountNum;
								var div = str.substring(8, 9)=='1'?"예금": str.substring(8, 9)=='2'?"적금":"마이너스";
								var td4 = $("<td>").html(div);
								var date = new Date(obj.accountOpenDate);
								var dateFormat = date.getFullYear() + '-' +('0' + (date.getMonth()+1)).slice(-2)+ '-' +  ('0' + date.getDate()).slice(-2) + ' '+date.getHours()+ ':'+('0' + (date.getMinutes())).slice(-2)+ ':'+date.getSeconds();
								var td5 = $("<td>").html(dateFormat);
								var interestToPercent = obj.accountInterest * 100;
								var td6 = $("<td>").html(interestToPercent + "%");
								tr.append(td1).append(td2).append(td3).append(td4).append(td5).append(td6);
								table.append(tr);
							})
							$("#table").append(table);
				    	}
				    }
				})
				break;
			}
		})
		$("button").eq(1).click(function() {
			$("input[name='search']").val("");
			 location.reload();
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
					<option>통장상품</option>
				</select>
				<input type="text" name='search'>
				<p>
					<button>조회</button>
					<button>취소</button>
				</p>
		</div>
		<div id="table">
			<table>
				<tr>
					<th>계좌번호</th>
					<th>고객이름</th>
					<th>상품명</th>
					<th>통장구분</th>
					<th>계좌개설일</th>
					<th>이자율</th>
				</tr>
				<c:forEach var="bankbook" items="${list}">
				<tr>
					<td><a href="${pageContext.request.contextPath}/bankwork/bankbook/detail.do?accountnum=${bankbook.accountNum}&custname=${bankbook.custCode.custName}">${bankbook.accountNum}</a></td>
					<td><a href="${pageContext.request.contextPath}/bankwork/bankbook/detail.do?accountnum=${bankbook.accountNum}&custname=${bankbook.custCode.custName}">${bankbook.custCode.custName}</a></td>
					<td><a href="${pageContext.request.contextPath}/bankwork/bankbook/detail.do?accountnum=${bankbook.accountNum}&custname=${bankbook.custCode.custName}">${bankbook.accountPlanCode.planName}</a></td>
					<td><a href="${pageContext.request.contextPath}/bankwork/bankbook/detail.do?accountnum=${bankbook.accountNum}&custname=${bankbook.custCode.custName}">${fn:substring(bankbook.accountNum,8,9) eq '1'?'예금':fn:substring(bankbook.accountNum,8,9) eq '2'?'적금':'마이너스'}</a></td>
					<td><a href="${pageContext.request.contextPath}/bankwork/bankbook/detail.do?accountnum=${bankbook.accountNum}&custname=${bankbook.custCode.custName}"><fmt:formatDate value="${bankbook.accountOpenDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a></td>
					<td><a href="${pageContext.request.contextPath}/bankwork/bankbook/detail.do?accountnum=${bankbook.accountNum}&custname=${bankbook.custCode.custName}"><fmt:formatNumber value="${bankbook.accountInterest}" type="percent"/></a></td>
				</tr>
				</c:forEach>
			</table>
		</div>
	</section>
</body>
</html>