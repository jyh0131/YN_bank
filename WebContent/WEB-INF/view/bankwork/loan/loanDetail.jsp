<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../../include/sectionBar.jsp"%>
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
    	$("#loanAdd").show();
		$("#loanList").show();
		$("#del").click(function() {
			if(!confirm("삭제하시겠습니까?")) {
				alert("삭제가 취소되었습니다");
				return false;
			}
		})
    	$("#cancel").click(function() {
    		location.href = "${pageContext.request.contextPath}/bankwork/loan/mgn.do?div=${custdiv}";
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
	div#dummy { height: 75px; background: #292929;}						    
</style>
<body>
	<jsp:include page="/WEB-INF/view/include/menu.jsp"/>
	<div id="container">
		<div id="header">
			<h1>대출 세부 정보</h1>
		</div>
		<form>
			<div id="profile">
				<h2>${loan.custCode.custName}님의 ${loan.planCode.planName} 정보</h2>
				<div id="profileEdit">
					<table>
						<tr>
							<th>고객명</th>
							<td>
								<input type="text" name="custname" readonly="readonly" value='${loan.custCode.custName}'>
							</td>
						</tr>
						<tr>
							<th>대출 계좌 번호</th>
							<td><input type="text" name="loanaccountnum" readonly="readonly" value='${loan.loanAccountNum}'></td>
						</tr>
						<tr>
							<th>상품명</th>
							<td>
								<input type="text" name="planname" readonly="readonly" value='${loan.planCode.planName}'>
							</td>	
						</tr>
						<tr>
							<th>대출날짜</th>
							<td><input type="text" name="loandate"  value="<fmt:formatDate value="${loan.loanDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" readonly="readonly"></td>
						</tr>
						<tr>
							<th>대출이자</th>
							<td><input type="text" name="loaninterest" value=<fmt:formatNumber value="${loan.loanInterest}" type="percent"/>></td>
						</tr>
						<tr>
							<th>대출금액</th>
							<td><input type="text" name="loanbalance" value=<fmt:formatNumber value="${loan.loanBalance}" type="number" maxFractionDigits="3"/>></td>
						</tr>
					</table>
				</div>
				
				<div id="submit">
					<input type="submit" value="수정" formaction="${pageContext.request.contextPath}/bankwork/loan/detail.do?cmd=mod&custdiv=${custdiv}" formmethod="post">
					<input type="submit" value="삭제" formaction="${pageContext.request.contextPath}/bankwork/loan/detail.do?cmd=del&custdiv=${custdiv}" formmethod="post" id="del">
					<input type="reset" value="취소" id="cancel">
				</div>
				
			</div>
		</form>
	</div>
</body>
</html>