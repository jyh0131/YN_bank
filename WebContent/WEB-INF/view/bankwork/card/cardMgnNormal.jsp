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
		span#guide { font-weight: bold; 
					 font-size: 15px;    
					  }
		
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
		div#dummy { height: 75px; background: #292929;}
		/*금액 오른쪽 정렬*/
		div#table td.alright{
		  text-align: right;
		  padding-right:10px;
		}
		div#table td.pName{
		  width: 280px;
		}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	$(function(){
		$("#cardAdd").show();
		$("#cardList").show();
		$("button").eq(0).click(function() {
			switch($("#searchMenu option:selected").val()) {
			case "검색구분":
				alert("검색 구분을 선택해주세요");
				$("input[name='search']").val("");
				break;
			case "고객이름":
				var div = $("#searchMenu option:selected").val();
				var search = $("input[name='search']").val();
				if(search=="") {
					alert("고객이름을 입력하세요");
					return;
				}
				$.ajax({
					url: "${pageContext.request.contextPath}/bankwork/card/mgn.do?custdiv=${custdiv}",
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
				    		var th1 = $("<th>").html("카드번호");
				    		var th2 = $("<th>").html("고객이름");
				    		var th3 = $("<th class='pName'>").html("상품명");
				    		var th4 = $("<th>").html("카드구분");
				    		var th5 = $("<th>").html("카드보안코드");
				    		var th6 = $("<th>").html("카드발급일");
				    		var th7 = $("<th>").html("카드한도");
				    		var th8 = $("<th>").html("카드잔액");
				    		tr.append(th1).append(th2).append(th3).append(th4).append(th5).append(th6).append(th7).append(th8);
				    		table.append(tr);
							$(res).each(function(i, obj) {
								var tr = $("<tr>").attr("data-cardNum",obj.cardNum).attr("data-custName",obj.custCode.custName).addClass("pickedOne");
								var a = [];
								a[0] = $("<a>").html(obj.cardNum).attr("href","${pageContext.request.contextPath}/bankwork/card/detail.do?cardnum="+obj.cardNum+"&custname="+obj.custCode.custName);
								a[1] = $("<a>").html(obj.custCode.custName).attr("href","${pageContext.request.contextPath}/bankwork/card/detail.do?cardnum="+obj.cardNum+"&custname="+obj.custCode.custName);
								a[2] = $("<a>").html(obj.planCode.planName).attr("href","${pageContext.request.contextPath}/bankwork/card/detail.do?cardnum="+obj.cardNum+"&custname="+obj.custCode.custName);
								var str = obj.cardNum;
								var div = str.substring(6, 7)=='1'?"체크카드":"신용카드";
								a[3] = $("<a>").html(div).attr("href","${pageContext.request.contextPath}/bankwork/card/detail.do?cardnum="+obj.cardNum+"&custname="+obj.custCode.custName);
								a[4] = $("<a>").html(obj.cardSecuCode).attr("href","${pageContext.request.contextPath}/bankwork/card/detail.do?cardnum="+obj.cardNum+"&custname="+obj.custCode.custName);
								var date = new Date(obj.cardIssueDate);
								var dateFormat = date.getFullYear() + '-' +('0' + (date.getMonth()+1)).slice(-2)+ '-' +  ('0' + date.getDate()).slice(-2) + ' '+('0' + (date.getHours())).slice(-2)+ ':'+('0' + (date.getMinutes())).slice(-2)+ ':'+('0' + (date.getSeconds())).slice(-2);
								a[5] = $("<a>").html(dateFormat).attr("href","${pageContext.request.contextPath}/bankwork/card/detail.do?cardnum="+obj.cardNum+"&custname="+obj.custCode.custName);
								a[6] = $("<a>").html(obj.cardLimit.toLocaleString()).attr("href","${pageContext.request.contextPath}/bankwork/card/detail.do?cardnum="+obj.cardNum+"&custname="+obj.custCode.custName);
								a[7] = $("<a>").html(obj.cardBalance.toLocaleString()).attr("href","${pageContext.request.contextPath}/bankwork/card/detail.do?cardnum="+obj.cardNum+"&custname="+obj.custCode.custName);
								$(a).each(function(i, obj) {
								
									var td = $("<td>").append(a[i]);
									tr.append(td);
								})
								table.append(tr);
							})
							$("#table").append(table);
							$("#table tr.pickedOne").each(function(i, obj) {
								$(this).find("td").eq(6).addClass("alright");
								$(this).find("td").eq(7).addClass("alright");
							})
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
					url: "${pageContext.request.contextPath}/bankwork/card/mgn.do?custdiv=${custdiv}",
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
				    		var th1 = $("<th>").html("카드번호");
				    		var th2 = $("<th>").html("고객이름");
				    		var th3 = $("<th class='pName'>").html("상품명");
				    		var th4 = $("<th>").html("카드구분");
				    		var th5 = $("<th>").html("카드보안코드");
				    		var th6 = $("<th>").html("카드발급일");
				    		var th7 = $("<th>").html("카드한도");
				    		var th8 = $("<th>").html("카드잔액");
				    		tr.append(th1).append(th2).append(th3).append(th4).append(th5).append(th6).append(th7).append(th8);
				    		table.append(tr);
							$(res).each(function(i, obj) {
								var tr = $("<tr>").attr("data-cardNum",obj.cardNum).attr("data-custName",obj.custCode.custName).addClass("pickedOne");
								var a = [];
								a[0] = $("<a>").html(obj.cardNum).attr("href","${pageContext.request.contextPath}/bankwork/card/detail.do?cardnum="+obj.cardNum+"&custname="+obj.custCode.custName);
								a[1] = $("<a>").html(obj.custCode.custName).attr("href","${pageContext.request.contextPath}/bankwork/card/detail.do?cardnum="+obj.cardNum+"&custname="+obj.custCode.custName);
								a[2] = $("<a>").html(obj.planCode.planName).attr("href","${pageContext.request.contextPath}/bankwork/card/detail.do?cardnum="+obj.cardNum+"&custname="+obj.custCode.custName);
								var str = obj.cardNum;
								var div = str.substring(6, 7)=='1'?"체크카드":"신용카드";
								a[3] = $("<a>").html(div).attr("href","${pageContext.request.contextPath}/bankwork/card/detail.do?cardnum="+obj.cardNum+"&custname="+obj.custCode.custName);
								a[4] = $("<a>").html(obj.cardSecuCode).attr("href","${pageContext.request.contextPath}/bankwork/card/detail.do?cardnum="+obj.cardNum+"&custname="+obj.custCode.custName);
								var date = new Date(obj.cardIssueDate);
								var dateFormat = date.getFullYear() + '-' +('0' + (date.getMonth()+1)).slice(-2)+ '-' +  ('0' + date.getDate()).slice(-2) + ' '+('0' + (date.getHours())).slice(-2)+ ':'+('0' + (date.getMinutes())).slice(-2)+ ':'+('0' + (date.getSeconds())).slice(-2);
								a[5] = $("<a>").html(dateFormat).attr("href","${pageContext.request.contextPath}/bankwork/card/detail.do?cardnum="+obj.cardNum+"&custname="+obj.custCode.custName);
								a[6] = $("<a>").html(obj.cardLimit.toLocaleString()).attr("href","${pageContext.request.contextPath}/bankwork/card/detail.do?cardnum="+obj.cardNum+"&custname="+obj.custCode.custName);
								a[7] = $("<a>").html(obj.cardBalance.toLocaleString()).attr("href","${pageContext.request.contextPath}/bankwork/card/detail.do?cardnum="+obj.cardNum+"&custname="+obj.custCode.custName);
								$(a).each(function(i, obj) {
									
									var td = $("<td>").append(a[i]);
									tr.append(td);
								})
								table.append(tr);
							})
							$("#table").append(table);
							$("#table tr.pickedOne").each(function(i, obj) {
								$(this).find("td").eq(6).addClass("alright");
								$(this).find("td").eq(7).addClass("alright");
							})
				    	}
				    }
				})
				break;
			case "카드구분":
				var div = $("#searchMenu option:selected").val();
				var search = $("input[name='search']").val();
				if(search=="") {
					alert("카드 구분을 입력하세요");
					return;
				}
				$.ajax({
					url: "${pageContext.request.contextPath}/bankwork/card/mgn.do?custdiv=${custdiv}",
				    data: {search:search,div:div},
				    type: "POST", 
				    dataType: "json",
				    success : function(res) {
				    	if(res.errorNoDiv!=null) {
				    		alert("체크카드나 신용카드 상품이 존재하지 않습니다");
				    		$("input[name='search']").val("");
				    		return;
				    	}
				    	if(res.errorCardDiv!=null) {
				    		alert("그런 상품은 없습니다. 다시 입력하세요");
				    		$("input[name='search']").val("");
				    	}
				    	else {
				    		console.log(res);
				    		$("#table table").remove();
				    		var table = $("<table>");
				    		var tr = $("<tr>");
				    		var th1 = $("<th>").html("카드번호");
				    		var th2 = $("<th>").html("고객이름");
				    		var th3 = $("<th class='pName'>").html("상품명");
				    		var th4 = $("<th>").html("카드구분");
				    		var th5 = $("<th>").html("카드보안코드");
				    		var th6 = $("<th>").html("카드발급일");
				    		var th7 = $("<th>").html("카드한도");
				    		var th8 = $("<th>").html("카드잔액");
				    		tr.append(th1).append(th2).append(th3).append(th4).append(th5).append(th6).append(th7).append(th8);
				    		table.append(tr);
							$(res).each(function(i, obj) {
								var tr = $("<tr>").attr("data-cardNum",obj.cardNum).attr("data-custName",obj.custCode.custName).addClass("pickedOne");
								var a = [];
								a[0] = $("<a>").html(obj.cardNum).attr("href","${pageContext.request.contextPath}/bankwork/card/detail.do?cardnum="+obj.cardNum+"&custname="+obj.custCode.custName);
								a[1] = $("<a>").html(obj.custCode.custName).attr("href","${pageContext.request.contextPath}/bankwork/card/detail.do?cardnum="+obj.cardNum+"&custname="+obj.custCode.custName);
								a[2] = $("<a>").html(obj.planCode.planName).attr("href","${pageContext.request.contextPath}/bankwork/card/detail.do?cardnum="+obj.cardNum+"&custname="+obj.custCode.custName);
								var str = obj.cardNum;
								var div = str.substring(6, 7)=='1'?"체크카드":"신용카드";
								a[3] = $("<a>").html(div).attr("href","${pageContext.request.contextPath}/bankwork/card/detail.do?cardnum="+obj.cardNum+"&custname="+obj.custCode.custName);
								a[4] = $("<a>").html(obj.cardSecuCode).attr("href","${pageContext.request.contextPath}/bankwork/card/detail.do?cardnum="+obj.cardNum+"&custname="+obj.custCode.custName);
								var date = new Date(obj.cardIssueDate);
								var dateFormat = date.getFullYear() + '-' +('0' + (date.getMonth()+1)).slice(-2)+ '-' +  ('0' + date.getDate()).slice(-2) + ' '+('0' + (date.getHours())).slice(-2)+ ':'+('0' + (date.getMinutes())).slice(-2)+ ':'+('0' + (date.getSeconds())).slice(-2);
								a[5] = $("<a>").html(dateFormat).attr("href","${pageContext.request.contextPath}/bankwork/card/detail.do?cardnum="+obj.cardNum+"&custname="+obj.custCode.custName);
								a[6] = $("<a>").html(obj.cardLimit.toLocaleString()).attr("href","${pageContext.request.contextPath}/bankwork/card/detail.do?cardnum="+obj.cardNum+"&custname="+obj.custCode.custName);
								a[7] = $("<a>").html(obj.cardBalance.toLocaleString()).attr("href","${pageContext.request.contextPath}/bankwork/card/detail.do?cardnum="+obj.cardNum+"&custname="+obj.custCode.custName);
								$(a).each(function(i, obj) {
									/* if(i==6 || i==7) {
										var td = $("<td>").append(a[i]).addClass("alright");
									} */
									var td = $("<td>").append(a[i]);
									tr.append(td);
								})
								table.append(tr);
							})
							$("#table").append(table);
							$("#table tr.pickedOne").each(function(i, obj) {
								$(this).find("td").eq(6).addClass("alright");
								$(this).find("td").eq(7).addClass("alright");
							})
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
		
		$(".pickedOne").click(function(){
		  var cardtNumForPick = $(this).attr("data-cardNum");
		  var custNameForPick = $(this).attr("data-custName");
		  
		  location.href="${pageContext.request.contextPath}/bankwork/card/detail.do?cardnum="+cardtNumForPick+"&custname="+custNameForPick;
	  	})
	  	$(document).on("click",'.pickedOne',function() {
	  		var accountNumForPick = $(this).attr("data-cardNum");
			var custNameForPick = $(this).attr("data-custName");
			  
			location.href="${pageContext.request.contextPath}/bankwork/card/detail.do?cardnum="+accountNumForPick+"&custname="+custNameForPick;
	  	});
	})
</script>
</head>
<body>
	<section>
	<jsp:include page="../../include/menu.jsp"/>
	<h2 id="menuLocation">일반 고객 카드 정보 조회</h2>
		<div id="search">
				<select id="searchMenu">
					<option>검색구분</option>
					<option>고객이름</option>
					<option>상품명</option>
					<option>카드구분</option>
				</select>
				<fieldset>
					<input type="search" name="search"  placeholder="검색어를 입력하세요."/>
					<button type="submit">
						<i class="fa fa-search"></i>
					</button>	
				</fieldset>
		</div>
		<div id="table">
		<span><i class="fas fa-exclamation-circle"></i></span><span id="guide">카드 세부 정보를 보려면 카드를 클릭하세요.</span>
			<table>
				<tr>
					<th>카드번호</th>
					<th>고객이름</th>
					<th class="pName">상품명</th>
					<th>카드구분</th>
					<th>카드보안코드</th>
					<th>카드발급일</th>
					<th>카드한도</th>
					<th>카드잔액</th>
				</tr>
				<c:forEach var="card" items="${list}">
				<tr class="pickedOne" data-cardNum="${card.cardNum }" data-custName="${card.custCode.custName }">
					<td>${card.cardNum}</td>
					<td>${card.custCode.custName}</td>
					<td>${card.planCode.planName}</td>
					<td>${fn:substring(card.cardNum,6,7) eq '1'?'체크카드':'신용카드'}</td>
					<td>${card.cardSecuCode}</td>
					<td><fmt:formatDate value="${card.cardIssueDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<td class='alright'><fmt:formatNumber value="${card.cardLimit}" type="number" maxFractionDigits="3"/></td>
					<td class='alright'><fmt:formatNumber value="${card.cardBalance}" type="number" maxFractionDigits="3"/></td>
				</tr>
				</c:forEach>
			</table>
		</div>
		<c:if test="${successmod!=null}">
			<script>
				alert("수정되었습니다");
			</script>
			<%
				session.removeAttribute("successmod");
			%>
		</c:if>
		<c:if test="${successdel!=null}">
			<script>
				alert("삭제되었습니다");
			</script>
			<%
				session.removeAttribute("successdel");
			%>
		</c:if>
	</section>
</body>
</html>