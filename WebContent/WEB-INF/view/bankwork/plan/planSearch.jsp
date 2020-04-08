<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../include/menu.jsp"%>

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
		
		div#dummy { height: 75px; background: #292929;}	
		
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
			width: 1000px;
			margin: 100px auto 100px auto;
			padding-left:100px;
		}  
		
		div#table table {
			border-collapse: collapse; 
		}
		
		div#table table a { display: block;  }
		
		div#table th, td {
			width: 250px; 
			height: 30px;
			text-align: center;
			font-size: 15px;
		}
		
		div#table td.long a {
			width: 220px;  text-align: center;
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
		
		$(".side2").hide();
		$("#planMgn").find(".side2").toggle();
		$("select").on("change", function(){
			
				$("table").load(location.href+" table");
				$("input[name='search']").val("");   
		})
		
		$("button").click(function() {  
			switch($("#searchMenu option:selected").val()) {
			case "검색 구분":
				alert("검색 조건을 선택해주세요.");
				$("input[name='search']").val("");
				break;
			case "상품 코드(A)":
				var div = $("#searchMenu option:selected").val();
				var search = $("input[name='search']").val();
				$.ajax({
					url: "${pageContext.request.contextPath}/bankwork/plan/planSearch.do",
				    data: {search:search,div:div},  
				    type: "POST", 
				    dataType: "json", 
				    success : function(res) {
				    		//console.log(res);
				    		if(res.error=="notExist") {
				    			alert("존재하지 않는 상품 입니다.");
				    		}
				    	else {
				    		$(".tableList").remove();
				    		
				    		var $table = $("<table>").addClass("tableList");
				    		var $tr1 = $("<tr>");
				    		
				    		var $th1 = $("<th>").html("상품 코드");
				    		var $th2 = $("<th>").html("상품 세부코드");
				    		var $th3 = $("<th>").html("상품명");
				    		var $th4 = $("<th>").html("상품 구분");
				    		
				    		$tr1.append($th1);
				    		$tr1.append($th2);
				    		$tr1.append($th3);
				    		$tr1.append($th4);
				    		$table.append($tr1);
				    		
				    		$(res).each(function(i, obj) {
				    			var $tr2 = $("<tr>");
				    			
				    			var $a1 = $("<a>").html(obj.planCode).attr("href", "${pageContext.request.contextPath}/bankwork/plan/planDetail.do?planCode="+obj.planCode);
					    		var $a2 = $("<a>").html(obj.planDetail).attr("href", "${pageContext.request.contextPath}/bankwork/plan/planDetail.do?planCode="+obj.planCode);
					    		var $a3 = $("<a>").html(obj.planName).attr("href", "${pageContext.request.contextPath}/bankwork/plan/planDetail.do?planCode="+obj.planCode);
					    		var $a4 = $("<a>").html(obj.planDiv).attr("href", "${pageContext.request.contextPath}/bankwork/plan/planDetail.do?planCode="+obj.planCode);
					    		
				    			   
					    		
					    		var $td1 = $("<td>");
					    		var $td2 = $("<td>");
					    		var $td3 = $("<td>");
					    		var $td4 = $("<td>");
					    		
					    		$td1.append($a1);
					    		$td2.append($a2);
					    		$td3.append($a3);
					    		$td4.append($a4);
					    		
					    		$tr2.append($td1);
					    		$tr2.append($td2);
					    		$tr2.append($td3);
					    		$tr2.append($td4);
					    		
					    		
					    		$table.append($tr2);
					    		
				    		})      
				    		$("#table").append($table);
				    	 }    
				    }
				})   
				break;
			case "상품 세부코드(AB)":
				var div = $("#searchMenu option:selected").val();
				var search = $("input[name='search']").val();
				$.ajax({
					url: "${pageContext.request.contextPath}/bankwork/plan/planSearch.do",
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
				    		
				    		var $th1 = $("<th>").html("상품 코드");
				    		var $th2 = $("<th>").html("상품 세부코드");
				    		var $th3 = $("<th>").html("상품명");
				    		var $th4 = $("<th>").html("상품 구분");
				    		
				    		$tr1.append($th1);
				    		$tr1.append($th2);
				    		$tr1.append($th3);
				    		$tr1.append($th4);
				    		$table.append($tr1);
				    		
				    		$(res).each(function(i, obj) {
				    			var $tr2 = $("<tr>");
				    			
				    			var $a1 = $("<a>").html(obj.planCode).attr("href", "${pageContext.request.contextPath}/bankwork/plan/planDetail.do?planCode="+obj.planCode);
					    		var $a2 = $("<a>").html(obj.planDetail).attr("href", "${pageContext.request.contextPath}/bankwork/plan/planDetail.do?planCode="+obj.planCode);
					    		var $a3 = $("<a>").html(obj.planName).attr("href", "${pageContext.request.contextPath}/bankwork/plan/planDetail.do?planCode="+obj.planCode);
					    		var $a4 = $("<a>").html(obj.planDiv).attr("href", "${pageContext.request.contextPath}/bankwork/plan/planDetail.do?planCode="+obj.planCode);
					    		
				    			   
					    		
					    		var $td1 = $("<td>");
					    		var $td2 = $("<td>");
					    		var $td3 = $("<td>");
					    		var $td4 = $("<td>");
					    		
					    		$td1.append($a1);
					    		$td2.append($a2);
					    		$td3.append($a3);
					    		$td4.append($a4);
					    		
					    		$tr2.append($td1);
					    		$tr2.append($td2);
					    		$tr2.append($td3);
					    		$tr2.append($td4);
					    		
					    		
					    		$table.append($tr2);
					    		
				    		})      
				    		$("#table").append($table);
				    	 }    
				    }
				})
				break;
			case "상품 명":
				var div = $("#searchMenu option:selected").val();
				var search = $("input[name='search']").val();
				$.ajax({
					url: "${pageContext.request.contextPath}/bankwork/plan/planSearch.do",
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
				    		
				    		var $th1 = $("<th>").html("상품 코드");
				    		var $th2 = $("<th>").html("상품 세부코드");
				    		var $th3 = $("<th>").html("상품명");
				    		var $th4 = $("<th>").html("상품 구분");
				    		
				    		$tr1.append($th1);
				    		$tr1.append($th2);
				    		$tr1.append($th3);
				    		$tr1.append($th4);
				    		$table.append($tr1);
				    		
				    		$(res).each(function(i, obj) {
				    			var $tr2 = $("<tr>");
				    			
				    			var $a1 = $("<a>").html(obj.planCode).attr("href", "${pageContext.request.contextPath}/bankwork/plan/planDetail.do?planCode="+obj.planCode);
					    		var $a2 = $("<a>").html(obj.planDetail).attr("href", "${pageContext.request.contextPath}/bankwork/plan/planDetail.do?planCode="+obj.planCode);
					    		var $a3 = $("<a>").html(obj.planName).attr("href", "${pageContext.request.contextPath}/bankwork/plan/planDetail.do?planCode="+obj.planCode);
					    		var $a4 = $("<a>").html(obj.planDiv).attr("href", "${pageContext.request.contextPath}/bankwork/plan/planDetail.do?planCode="+obj.planCode);
					    		
				    			   
					    		
					    		var $td1 = $("<td>");
					    		var $td2 = $("<td>");
					    		var $td3 = $("<td>");
					    		var $td4 = $("<td>");
					    		
					    		$td1.append($a1);
					    		$td2.append($a2);
					    		$td3.append($a3);
					    		$td4.append($a4);
					    		
					    		$tr2.append($td1);
					    		$tr2.append($td2);
					    		$tr2.append($td3);
					    		$tr2.append($td4);
					    		
					    		
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
	<%@include file="../../include/sectionBar.jsp"%>
		<div id="search">
				<select id="searchMenu">
					<option>검색 구분</option>
					<option>상품 코드(A)</option>
					<option>상품 세부코드(AB)</option>
					<option>상품 명</option>   
					
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
					<th>상품 코드</th>
					<th>상품 세부코드</th>
					<th>상품명</th>    
					<th>상품 구분</th>

				</tr>
				<c:forEach var='planList' items="${list }">
					
					<tr>
							<td><a href="${pageContext.request.contextPath}/bankwork/plan/planDetail.do?planCode=${planList.planCode}">${planList.planCode }</a></td>
							<td><a href="${pageContext.request.contextPath}/bankwork/plan/planDetail.do?planCode=${planList.planCode}">${planList.planDetail }</a></td>
							<td><a href="${pageContext.request.contextPath}/bankwork/plan/planDetail.do?planCode=${planList.planCode}">${planList.planName }</a></td>
							<td class="long"><a href="${pageContext.request.contextPath}/bankwork/plan/planDetail.do?planCode=${planList.planCode}">${planList.planDiv }</a></td>
		
							
					</tr>
				
				</c:forEach>
		</table>
		</div>  
		</section>
</body>
</html>