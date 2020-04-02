<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script>
    $(function() {
    	$("#cancel").click(function() {
    		location.href = "${pageContext.request.contextPath}/bankwork/bankbook/mgn.do";
    	})
    });
</script>
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
	div#profileMain { float: left; }
	div#profileMain div#pic { width: 250px; height: 350px;}
	div#profileMain div#pic span { display: block;
							       width: 100px; height: 100px;
							       float: left; 
							       text-align: center;}
	div#profileMain div#pic #proName { width: 100x; font-size: 30px; 
									   font-weight: bold;
							    	   line-height: 100px;  }
	div#profileMain div#pic #proDept { line-height: 110px;
									   font-size: 20px;
									   text-align: left; }
	div#profile div#pic img { width: 200px; height: 250px; display: block;}
	
	div#profileEdit { width:600px; 
					  overflow: hidden;
					  margin-left: 200px;  }
	div#profileEdit table { width: 500px; }
	div#profileEdit table tr { height: 30px; }
	div#profileEdit table th { width: 100px; text-align: left; }
	div#profileEdit table td { width: 200px; text-align: center;}
	div#profileEdit table td input { width: 250px;
									 background: whitesmoke;
								     border: none; 
								     padding: 10px; 
								     border-bottom: 1px solid gray;}
	table td#noline input[name='file'] { border: none;}									     
	div#profileEdit table td select { width: 250px; margin: 20px 0;}		
	div#submit { text-align: center; 
				 height: 100px; 
				 line-height: 250px; }
	div#submit input { width: 100px;  height: 40px; 
					   border: none;
					   background: gray; 
					   margin-left:20px; 
					   font-size: 15px;
					   color: whitesmoke;}						    
</style>
<body>
	<jsp:include page="/WEB-INF/view/include/menu.jsp"/>
	<div id="container">
		<div id="header">
			<h1>통장 세부 정보</h1>
		</div>
		<form>
			<div id="profile">
				<h2>${bankbook.custCode.custName}님의 ${bankbook.accountPlanCode.planName} 통장 정보</h2>
				<div id="profileEdit">
					<table>
						<tr>
							<th>고객명</th>
							<td>
								<input type="text" name="custname" readonly="readonly" value='${bankbook.custCode.custName}'>
							</td>
						</tr>
						<tr>
							<th>계좌번호</th>
							<td><input type="text" name="accountnum" readonly="readonly" value='${bankbook.accountNum}'></td>
						</tr>
						<tr>
							<th>상품명</th>
							<td>
								<input type="text" name="planname" readonly="readonly" value='${bankbook.accountPlanCode.planName}'>
							</td>
								
						</tr>
						<tr>
							<th>계좌개설일</th>
							<td><input type="text" name="accountOpenDate"  value=<fmt:formatDate value="${bankbook.accountOpenDate}" pattern="yyyy-MM-dd HH:mm:ss"/>></td>
						</tr>
						<tr>
							<th>이자율</th>
							<td><input type="text" name="accountInterest" value=<fmt:formatNumber value="${bankbook.accountInterest}" type="percent"/>></td>
						</tr>
					</table>
				</div>
				
				<div id="submit">
					<input type="submit" value="수정">
					<input type="submit" value="삭제">
					<input type="submit" value="휴면계좌전환">
					<input type="reset" value="취소" id="cancel">
				</div>
				
			</div>
		</form>
	</div>
</body>
</html>