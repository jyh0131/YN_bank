<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	#container { width: 1000px; margin: 50px auto;}
	div#header { background: goldenrod;
			     height: 150px; }
	div#header h1 { padding: 30px;  }
	div#profile { background: whitesmoke;
				  height: 500px;
				  border-radius: 10px;
				  padding: 50px;}
	div#profile h2 { height: 50px; }				  
	div#profile h3 { text-align: center;}
	div#submit { text-align: center; 
				 height: 100px; 
				 line-height: 250px; }
	div#submit button { width: 200px;  height: 50px; 
					   border: none;
					   background: gray; 
					   margin-left:20px; 
					   font-size: 17px;
					   color: whitesmoke;}						    
</style>
<script>
	$(function(){
		$("#loanAdd").show();
		$("#loanList").show();
		$("#bus").click(function(){
			$(location).attr('href','${pageContext.request.contextPath}/bankwork/loan/add.do?div=1');
		})
		$("#nor").click(function(){
			$(location).attr('href','${pageContext.request.contextPath}/bankwork/loan/add.do?div=0');
		})
	})    
</script>
<body>
	<jsp:include page="../../include/menu.jsp"/>
	<div id="container">
		<div id="header">
			<h1>고객 추가</h1>
		</div>
			<div id="profile">
				<h2>프로필</h2>
				
				<h3>고객 분류를 선택해주세요.</h3>
				<div id="submit">
					<button id="bus">기업</button>
					<button id="nor">일반</button>
				</div>
			</div>
	</div>
</body>
</html>