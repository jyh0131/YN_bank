<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../include/menu.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</head>
<style>
	* { margin:0; padding:0; 
		font-family: 'Noto Sans KR', sans-serif;
		color: #252525; }
	div#dummy { height: 75px; background: #292929;}
	#container { width: 1000px; margin: 30px auto;}
	div#dummy { height: 75px; background: #292929;}	
	
	div#header { background: goldenrod;
			     height: 150px; }
	div#header h1 { padding: 30px;  }
	div#profile { background: whitesmoke;
				  height: 500px;
				  border-radius: 10px;
				  padding: 50px;}
	div#profile h2 { height: 50px; }				  
	div#profile h3 {text-align: center; }
	div#submit { text-align: center; 
				 height: 250px; 
				  line-height: 250px;  }
	div#submit button { width: 200px;  height: 50px; 
					   border: none;
					   background: gray; 
					   margin-left:20px; 
					   font-size: 17px;
					   color: whitesmoke;}
					   
	div#backTotheMain {height: 100px; 
					   text-align: center;
					   line-height: 100px;  }
					   
	div#backTotheMain button { width: 200px;
							   height: 50px; 
							   font-weight: bold;
							   font-size: 17px; }					    
</style>
<script>
	$(function(){
		$("#custAdd").show();
		$("#custList").show();
		$(".card").click(function(){
			var text = $(this).html();
			$(location).attr('href','${pageContext.request.contextPath}/bankwork/plan/addCardPlan.do?text='+text);
		})
		$("#back").click(function(){
			$(location).attr('href','${pageContext.request.contextPath}/main/main.do');
		})
	})    
</script>
<body>
	<%@include file="../../include/sectionBar.jsp"%>
	<div id="container">
		<div id="header">
			<h1>카드 상품 추가</h1>
		</div>
			<div id="profile">
				<h2></h2>
				
				<h3>상품 분류를 선택해주세요.</h3>
				<div id="submit">
					<button class="card">체크 카드</button>
					<button class="card">신용 카드</button>
				</div>
				<div id="backTotheMain">
					<button id="back">이전으로</button>
				</div>
			</div>
	</div>
</body>
</html>