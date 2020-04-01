<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/menu.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
				    		console.log(res);
				    		if(res==null) {
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
				    		$table.append($tr1);
				    		
				    		$(res).each(function(i, obj) {
				    			var $tr2 = $("<tr>");
					    		var $td1 = $("<td>").html(obj.custCode);
					    		var $td2 = $("<td>").html(obj.custName);
					    		var $td3 = $("<td>").html(obj.custRank);
					    		var $td4 = $("<td>").html(obj.custCredit);
					    		var $td5 = $("<td>").html(obj.custAddr); 
					    		var $td6 = $("<td>").html(obj.custTel);
					    		
					    		$tr2.append($td1);
					    		$tr2.append($td2);
					    		$tr2.append($td3);
					    		$tr2.append($td4);
					    		$tr2.append($td5);
					    		$tr2.append($td6);
					    		
					    		var $a = $("<a>").attr("href", "#");
					    		/* $a.append($tr2); */
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
				    		if(res==null) {
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
				    		$table.append($tr1);
				    		
				    		$(res).each(function(i, obj) {
				    			var $tr2 = $("<tr>");
					    		var $td1 = $("<td>").html(obj.custCode);
					    		var $td2 = $("<td>").html(obj.custName);
					    		var $td3 = $("<td>").html(obj.custRank);
					    		var $td4 = $("<td>").html(obj.custCredit);
					    		var $td5 = $("<td>").html(obj.custAddr); 
					    		var $td6 = $("<td>").html(obj.custTel);
					    		
					    		$tr2.append($td1);
					    		$tr2.append($td2);
					    		$tr2.append($td3);
					    		$tr2.append($td4);
					    		$tr2.append($td5);
					    		$tr2.append($td6);
					    		
					    		var $a = $("<a>").attr("href", "#");
					    		/* $a.append($tr2); */
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
				    		if(res==null) {
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
				    		$table.append($tr1);
				    		
				    		$(res).each(function(i, obj) {
				    			var $tr2 = $("<tr>");
					    		var $td1 = $("<td>").html(obj.custCode);
					    		var $td2 = $("<td>").html(obj.custName);
					    		var $td3 = $("<td>").html(obj.custRank);
					    		var $td4 = $("<td>").html(obj.custCredit);
					    		var $td5 = $("<td>").html(obj.custAddr); 
					    		var $td6 = $("<td>").html(obj.custTel);
					    		
					    		$tr2.append($td1);
					    		$tr2.append($td2);
					    		$tr2.append($td3);
					    		$tr2.append($td4);
					    		$tr2.append($td5);
					    		$tr2.append($td6);
					    		
					    		var $a = $("<a>").attr("href", "#");
					    		/* $a.append($tr2); */
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
			
					<fieldset><input type="search" name="search"/>
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

				</tr>
				<c:forEach var='custList' items="${list }">
				<tr>
						<td>${custList.custCode }</td>
						<td>${custList.custName }</td>
						<td>${custList.custRank }</td>
						<td>${custList.custCredit }</td>
						<td>${custList.custAddr }</td>
						<td>${custList.custTel }</td>
				</tr>
				</c:forEach>
		</table>
		
		</div>
		</section>
</body>
</html>