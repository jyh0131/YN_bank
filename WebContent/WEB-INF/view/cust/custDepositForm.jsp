<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
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
	#container { width: 1000px; margin: 0 auto;}
	div#header { background: goldenrod;
			     height: 150px; }
	div#header h1 { padding: 30px;  }
	div#profile { background: whitesmoke;
				  height: 600px;
				  border-radius: 10px;
				  padding: 50px;}

		 		   
		input, button { position: relative;  
						width: 200px;  height: 35px;  
						padding: 0;  
						display: inline-block;  
						float: left; }
		input {  color: #666;  
		 		 z-index: 2; 
		 		 border:none;  
		 		 border-bottom: 1px solid goldenrod; 
		 		 background: whitesmoke;}
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
				  
				  
	div#profile h2 { height: 50px; }	
	
	
	div#profileEdit { width:600px; 
					  height: 450px; 
					  overflow: hidden;
					  margin-left: 200px;  }
	div#profileEdit table { width: 500px;}
	div#profileEdit table tr { height: 30px; }
	div#profileEdit table th { width: 100px; text-align: left; }
	div#profileEdit table td { width: 200px; text-align: center;
							   padding-left: 70px; }
	div#profileEdit table td input { width: 250px;
									 background: whitesmoke;
								     border: none; 
								     margin: 10px 10px 10px 60px; 
								     border-bottom: 1px solid gray;}
	table td#noline input[name='file'] { border: none;}									     
	div#profileEdit table td select { width: 250px; margin: 20px 0 20px 40px;}		
	div#submit {  width: 500px;  
				 height: 80px; 
				 margin-left: 300px;
				 margin-top:30px; 
				  }
	div#submit input { width: 100px;  height: 40px;   
					   border: none;  
					   background: gray; 
					   margin-left:20px; 
					   font-size: 15px;
					   color: whitesmoke;}						    
</style>
<script>
	$(function(){
		$("#cancel").click(function() {
			var choose = confirm("취소하시겠습니까? 리스트로 돌아갑니다.");
			if(choose){
				location.href = "${pageContext.request.contextPath}/cust/custDWSearch.do";	
			}
    	})
    	
    	
    	$("input[value='입금']").click(function(){
    		
    		var deposit = confirm("입금하시겠습니까?");
    		if(deposit){

        		var accountNum = $("input[name='accNum']").val();
        		var amount=$("input[name='amount']").val();
        		
        		location.href= "${pageContext.request.contextPath}/cust/custDWFunction.do?accountNum="+accountNum+"&amount="+amount+"&text=입금";
    		}
    		
    	})  
    	
    	$("input[value='출금']").click(function(){
    		
    		var deposit = confirm("출금하시겠습니까?");
    		if(deposit){

        		var accountNum = $("input[name='accNum']").val();
        		var amount=$("input[name='amount']").val();
        		  
        		location.href= "${pageContext.request.contextPath}/cust/custDWFunction.do?accountNum="+accountNum+"&amount="+amount+"&text=출금";
    		}
    		
    	})
    	
	})
</script>
<body>
	<div id="container">
		<div id="header">
			<c:if test="${dw=='출금' }">
				<h1>출금</h1>
			</c:if>
			<c:if test="${dw=='입금' }">   
				<h1>입금</h1>
			</c:if>
		</div>	
			<div id="profile">
				<h2>고객 정보</h2>
						
						<div id="profileEdit">
							<table>
								
						<tr>
							<th>고객 코드</th>
							<td>
								<input type="text" name="code" value="${custBal.custCode }" readonly="readonly">
							</td>
						</tr>
						<tr>
							<th>고객명</th>
							<td><input type="text" name="name" value="${custBal.custName }" readonly="readonly"></td>
						</tr>
						<tr>
							<th>계좌번호</th>
							<td>
								<input type="text" name="accNum" value="${accountNum }" readonly="readonly">
							</td>
						</tr>   
						<tr>           
							<th>잔액</th>
							<td>
								<input type="text" name="accBal" value="${custBal.bankbook.accountBalance }" readonly="readonly">
							</td>   
						</tr>
						<tr>
							<th>입금 금액</th>
							<td><input type="text" name="amount"></td>  
						</tr>
						
					</table>
				</div>
				
				<div id="submit">
					<c:if test="${dw=='입금' }">
						<input type="submit" value="입금">
					</c:if>
					<c:if test="${dw=='출금' }">
						<input type="submit" value="출금">
					</c:if>
					<input type="reset" value="취소" id="cancel">
				</div>
				
			</div>
	</div>
</body>
</html>