<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/menu.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
</head>
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
		
		div#table table a { display: block; }
		
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
<script>
	$(function(){
		
		$("select").on("change", function(){
			if($("select option:selected").val()=="고객 코드"){
				$("input[name='search']").val("");  
				$("input[name='search']").val("B");
			}
				$("table").load(location.href+" table");
				$("input[name='search']").val("");   
		})
		
		$("button").click(function() {  
			switch($("#searchMenu option:selected").val()) {
			case "검색 구분":
				alert("검색 조건을 선택해주세요.");
				$("input[name='search']").val("");
				break;
			case "고객 코드":
				var div = $("#searchMenu option:selected").val();
				var search = $("input[name='search']").val();
				$.ajax({
					url: "${pageContext.request.contextPath}/cust/custSearch.do",
				    data: {search:search,div:div},  
				    type: "POST", 
				    dataType: "json", 
				    success : function(res) {
				    		//console.log(res);
				    		if(res.error=="notExist") {
				    			alert("존재하지 않는 고객 입니다.");
				    		}
				    	else {
				    		$(".tableList").remove();
				    		
				    		var $table = $("<table>").addClass("tableList");
				    		var $tr1 = $("<tr>");
				    		
				    		var $th1 = $("<th>").html("고객 코드");
				    		var $th2 = $("<th>").html("고객명");
				    		var $th3 = $("<th>").html("고객 등급명");
				    		var $th4 = $("<th>").html("고객 신용등급");
				    		var $th5 = $("<th>").html("고객 주소");
				    		var $th6 = $("<th>").html("연락처");
				    		var $th7 = $("<th>").html("분류");
				    		
				    		$tr1.append($th1);
				    		$tr1.append($th2);
				    		$tr1.append($th3);
				    		$tr1.append($th4);
				    		$tr1.append($th5);
				    		$tr1.append($th6);
				    		$tr1.append($th7);
				    		$table.append($tr1);
				    		
				    		$(res).each(function(i, obj) {
				    			var $tr2 = $("<tr>");
				    			
				    			var $a1 = $("<a>").html(obj.custCode).attr("href", "#");
					    		var $a2 = $("<a>").html(obj.custName).attr("href", "#");
					    		var $a3 = $("<a>").html(obj.custRank).attr("href", "#");
					    		var $a4 = $("<a>").html(obj.custCredit).attr("href", "#");
					    		var $a5 = $("<a>").html(obj.custAddr).attr("href", "#");
					    		var $a6 = $("<a>").html(obj.custTel).attr("href", "#");
					    		var $a7;
					    		if(obj.custDiv==true){
					    			$a7 = $("<a>").html("기업").attr("href", "#");
					    		}else{
					    			$a7 = $("<a>").html("고객").attr("href", "#");
					    		}
				    			   
					    		
					    		var $td1 = $("<td>");
					    		var $td2 = $("<td>");
					    		var $td3 = $("<td>");
					    		var $td4 = $("<td>");
					    		var $td5 = $("<td>"); 
					    		var $td6 = $("<td>");
					    		var $td7 = $("<td>");
					    		
					    		$td1.append($a1);
					    		$td2.append($a2);
					    		$td3.append($a3);
					    		$td4.append($a4);
					    		$td5.append($a5);
					    		$td6.append($a6);
					    		$td7.append($a7);
					    		
					    		$tr2.append($td1);
					    		$tr2.append($td2);
					    		$tr2.append($td3);
					    		$tr2.append($td4);
					    		$tr2.append($td5);
					    		$tr2.append($td6);
					    		$tr2.append($td7);
					    		
					    		
					    		$table.append($tr2);
					    		
				    		})      
				    		$("#table").append($table);
				    	 }    
				    }
				})   
				break;
			case "고객명":
				var div = $("#searchMenu option:selected").val();
				var search = $("input[name='search']").val();
				$.ajax({
					url: "${pageContext.request.contextPath}/cust/custSearch.do",
				    data: {search:search,div:div},  
				    type: "POST", 
				    dataType: "json", 
				    success : function(res) {
				    		console.log(res);
				    		if(res.error=="notExist") {
				    			alert("존재하지 않는 고객 입니다.");
				    		}
				    	else {
				    		$(".tableList").remove();
				    		
				    		var $table = $("<table>").addClass("tableList");
				    		var $tr1 = $("<tr>");
				    		
				    		var $th1 = $("<th>").html("고객 코드");
				    		var $th2 = $("<th>").html("고객명");
				    		var $th3 = $("<th>").html("고객 등급명");
				    		var $th4 = $("<th>").html("고객 신용등급");
				    		var $th5 = $("<th>").html("고객 주소");
				    		var $th6 = $("<th>").html("연락처");
				    		var $th7 = $("<th>").html("분류");
				    		
				    		$tr1.append($th1);
				    		$tr1.append($th2);
				    		$tr1.append($th3);
				    		$tr1.append($th4);
				    		$tr1.append($th5);
				    		$tr1.append($th6);
				    		$tr1.append($th7);
				    		$table.append($tr1);
				    		
				    		$(res).each(function(i, obj) {
								var $tr2 = $("<tr>");
				    			
								var $a1 = $("<a>").html(obj.custCode).attr("href", "#");
					    		var $a2 = $("<a>").html(obj.custName).attr("href", "#");
					    		var $a3 = $("<a>").html(obj.custRank).attr("href", "#");
					    		var $a4 = $("<a>").html(obj.custCredit).attr("href", "#");
					    		var $a5 = $("<a>").html(obj.custAddr).attr("href", "#");
					    		var $a6 = $("<a>").html(obj.custTel).attr("href", "#");
				    			var $a7 = $("<a>").html(obj.custDiv).attr("href", "#");
					    		
					    		var $td1 = $("<td>");
					    		var $td2 = $("<td>");
					    		var $td3 = $("<td>");
					    		var $td4 = $("<td>");
					    		var $td5 = $("<td>"); 
					    		var $td6 = $("<td>");
					    		var $td7 = $("<td>");
					    		
					    		$td1.append($a1);
					    		$td2.append($a2);
					    		$td3.append($a3);
					    		$td4.append($a4);
					    		$td5.append($a5);
					    		$td6.append($a6);
					    		$td7.append($a7);
					    		
					    		$tr2.append($td1);
					    		$tr2.append($td2);
					    		$tr2.append($td3);
					    		$tr2.append($td4);
					    		$tr2.append($td5);
					    		$tr2.append($td6);
					    		$tr2.append($td7);
					    		
					    		
					    		$table.append($tr2);
					    		
				    		})
				    		$("#table").append($table);
				    	 }    
				    }
				})
				break;
			case "연락처":
				var div = $("#searchMenu option:selected").val();
				var search = $("input[name='search']").val();
				$.ajax({
					url: "${pageContext.request.contextPath}/cust/custSearch.do",
				    data: {search:search,div:div},  
				    type: "POST", 
				    dataType: "json", 
				    success : function(res) {
				    		console.log(res);
				    		if(res.error=="notExist") {
				    			alert("존재하지 않는 고객 입니다.");
				    		}
				    	else {
				    		$(".tableList").remove();
				    		
				    		var $table = $("<table>").addClass("tableList");
				    		var $tr1 = $("<tr>");
				    		
				    		var $th1 = $("<th>").html("고객 코드");
				    		var $th2 = $("<th>").html("고객명");
				    		var $th3 = $("<th>").html("고객 등급명");
				    		var $th4 = $("<th>").html("고객 신용등급");
				    		var $th5 = $("<th>").html("고객 주소");
				    		var $th6 = $("<th>").html("연락처");
				    		
				    		$tr1.append($th1);
				    		$tr1.append($th2);  
				    		$tr1.append($th3);
				    		$tr1.append($th4);
				    		$tr1.append($th5);
				    		$tr1.append($th6);
				    		$tr1.append($th7);
				    		$table.append($tr1);
				    		
				    		$(res).each(function(i, obj) {
								var $tr2 = $("<tr>");
				    			
								var $a1 = $("<a>").html(obj.custCode).attr("href", "#");
					    		var $a2 = $("<a>").html(obj.custName).attr("href", "#");
					    		var $a3 = $("<a>").html(obj.custRank).attr("href", "#");
					    		var $a4 = $("<a>").html(obj.custCredit).attr("href", "#");
					    		var $a5 = $("<a>").html(obj.custAddr).attr("href", "#");
					    		var $a6 = $("<a>").html(obj.custTel).attr("href", "#");
				    			var $a7 = $("<a>").html(obj.custDiv).attr("href", "#");
					    		
					    		var $td1 = $("<td>");
					    		var $td2 = $("<td>");
					    		var $td3 = $("<td>");
					    		var $td4 = $("<td>");
					    		var $td5 = $("<td>"); 
					    		var $td6 = $("<td>");
					    		var $td7 = $("<td>");
					    		
					    		$td1.append($a1);
					    		$td2.append($a2);
					    		$td3.append($a3);
					    		$td4.append($a4);
					    		$td5.append($a5);
					    		$td6.append($a6);
					    		$td7.append($a7);
					    		
					    		$tr2.append($td1);
					    		$tr2.append($td2);
					    		$tr2.append($td3);
					    		$tr2.append($td4);
					    		$tr2.append($td5);
					    		$tr2.append($td6);
					    		$tr2.append($td7);
					    		
					    		
					    		$table.append($tr2);
					    		
				    		})
				    		$("#table").append($table);
				    	 }    
				    }
				})
				break;
				
			}
		})
		$("button").eq(1).click(function() {
			$("input[name='search']").val("");
		})
	})
</script>
<body>
	<section>
		<div id="search">
				<select id="searchMenu">
					<option>검색 구분</option>
					<option>고객 코드</option>
					<option>고객명</option>
					<option>연락처</option>   
					
				</select>
			
					<fieldset><input type="search" name="search" placeholder="검색어를 입력하세요."/>
						<button type="submit" id="searchBtn">
							<i class="fa fa-search"></i>
						</button>	
					</fieldset>
				
		</div>
		<div id="table">
			<table class="tableList">
				<tr>
					<th>고객 코드</th>
					<th>고객명</th>
					<th>고객 등급명</th>    
					<th>고객 신용등급</th>
					<th>고객 주소</th>
					<th>연락처</th>
					<th>분류</th>

				</tr>
				<c:forEach var='custList' items="${list }">
					
					<tr>
							<td><a href="${pageContext.request.contextPath}/cust/custDetail.do?custName=${custList.custName}">${custList.custCode }</a></td>
							<td><a href="${pageContext.request.contextPath}/cust/custDetail.do?custName=${custList.custName}">${custList.custName }</a></td>
							<td><a href="${pageContext.request.contextPath}/cust/custDetail.do?custName=${custList.custName}">${custList.custRank }</a></td>
							<td><a href="${pageContext.request.contextPath}/cust/custDetail.do?custName=${custList.custName}">${custList.custCredit }</a></td>
							<td><a href="${pageContext.request.contextPath}/cust/custDetail.do?custName=${custList.custName}">${custList.custAddr }</a></td>
							<td><a href="${pageContext.request.contextPath}/cust/custDetail.do?custName=${custList.custName}">${custList.custTel }</a></td>
							<c:if test="${custList.custDiv==true}">
								<td><a href="#">기업</a></td>
							</c:if>
							<c:if test="${custList.custDiv==false}">
								<td><a href="#">일반</a></td>
							</c:if>
							
					</tr>
				
				</c:forEach>
		</table>
		</div>  
		</section>
</body>
</html>