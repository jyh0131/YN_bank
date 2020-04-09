<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    	//클릭한 메뉴만 보이게 하기
    	$("#custAdd").show();
		$("#custList").show();
		
		//로딩 될 때 확인버튼 없음
    	$("input[value='수정 완료']").css("display", "none");
		
		//취소 클릭 시
    	$("#cancel").click(function() {
    		location.href = "${pageContext.request.contextPath}/cust/custSearch.do";
    	})
    	//수정 클릭 시 input readonly  해제
    	$("input[value='수정 하기']").click(function(){
    		$(this).css("display", "none");
    		$("input[value='삭제']").css("display", "none");
    		$("input[value='수정 완료']").css("display", "inline");
    		$("h1").html("고객 세부 정보 수정");
    		$("input").removeAttr("readonly");
    		$("select").removeAttr("disabled");
    		$("input[name='custDiv']").attr("readonly", "readonly");
    		$("input[name='custCode']").attr("readonly", "readonly");
    		$("input[name='custName']").focus();
    		$("input[value='삭제']").remove();
    		$("input[value='수정']").remove();  
    		return false;
    	})     
    	
    	    
    	 //동적으로 생성된 input 태그에 이벤트
    	 //내용 수정 후 확인 클릭 시
 		$("input[value='수정 완료']").on({   
 			"click" : function(){
 				var edit = confirm("수정하시겠습니까?");
 				if(edit==false){
 					return false;
 				}
 			}
 		}) 
 		//삭제 클릭 시 
 		$("input[value='삭제']").on({
 			"click" : function(){
 				var del = confirm("삭제하시겠습니까?");
 				if(del==false){
 					return false;  
 				}
 			}
 		})
 		     
 		      
 
    });
</script>       
</head>
<style>
	* { margin:0; padding:0; 
		font-family: 'Noto Sans KR', sans-serif;
		color: #252525; }
	div#dummy { height: 75px; background: #292929;}
	#container { width: 1000px; margin: 50px auto;}
	/* 헤더(고객 세부 정보) */
	div#header { background: goldenrod;
			     height: 150px; }
			     
	div#header h1 { padding: 30px;  }
	
	/* 고객 정보 부분 */
	div#profile { background: whitesmoke;
				  height: 500px;
				  border-radius: 10px;
				  padding: 50px;}
	div#profile h2 { height: 50px; }				  
	
	
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
									     
	div#profileEdit table td select { width: 250px; margin: 20px 0;}	
	
	/* 버튼 */	
	div#submit { text-align: center; 
				 height: 100px; 
				 line-height: 200px; }
	div#submit input { width: 100px;  height: 40px; 
					   border: none;
					   background: gray; 
					   margin-left:20px; 
					   font-size: 15px;
					   color: whitesmoke;}						    
</style>
<body>
	<jsp:include page="/WEB-INF/view/include/menu.jsp"/>
	<%@include file="../include/sectionBar.jsp"%>
	<div id="container">
		<div id="header">
			<h1>고객 세부 정보</h1>
		</div>
		<form action="custUpdate.do" method="post">
			<div id="profile">
				<h2>고객 정보</h2>
				<div id="profileEdit">
					<table>
						<tr>
							<th>분류</th>
							<td>
								<c:if test="${customer.custDiv==false }">
									<input type="text" name="custDiv" readonly="readonly" value="일반">
								</c:if>
								<c:if test="${customer.custDiv==true }">
									<input type="text" name="custDiv" readonly="readonly" value="기업">
								</c:if>
								
							</td>
						</tr>  
						<tr>
							<th>고객코드</th>  
							<td>
								<input type="text" name="custCode" readonly="readonly" value="${customer.custCode }">
							</td>  
						</tr>
						<tr>
							<th>고객명</th>
							<td>
								<input type="text" name="custName" readonly="readonly" value="${customer.custName }">
							</td>
						</tr>
						<tr>
							<th>고객 신용등급</th>
							<td>
								<c:if test="${customer.custCredit==1 }">
									<select name="custCredit"  disabled="disabled">
										<option>신용등급 선택</option>
										<option selected>1</option>
										<option>2</option>
										<option>3</option>
										<option>4</option>
										<option>5</option>
									</select>
								</c:if>
								<c:if test="${customer.custCredit==2 }">
									<select name="custCredit">
										<option>신용등급 선택</option>
										<option>1</option>
										<option selected>2</option>
										<option>3</option>
										<option>4</option>
										<option>5</option>
									</select>
								</c:if>
								<c:if test="${customer.custCredit==3 }">
									<select name="custCredit">
										<option>신용등급 선택</option>
										<option>1</option>
										<option>2</option>
										<option selected>3</option>
										<option>4</option>
										<option>5</option>
									</select>
								</c:if>
								<c:if test="${customer.custCredit==4 }">
									<select name="custCredit">
										<option>신용등급 선택</option>
										<option>1</option>
										<option>2</option>
										<option>3</option>
										<option selected>4</option>
										<option>5</option>
									</select>
								</c:if>
								<c:if test="${customer.custCredit==5 }">
									<select name="custCredit">
										<option>신용등급 선택</option>
										<option>1</option>
										<option>2</option>
										<option>3</option>
										<option>4</option>
										<option selected>5</option>
									</select>
								</c:if>
								
							</td>
						</tr>   
						<tr>
							<th>주소</th>
							<td><input type="text" name="addr" readonly="readonly" value="${customer.custAddr }"></td>
						</tr>
						<tr>
							<th>연락처</th>
							<td>
								<input type="text" name="custTel" readonly="readonly" value="${customer.custTel }">
							</td>
						</tr>
					</table>
				</div>
				
				<div id="submit">
					<input type="submit" value="수정 하기">
					<input type="submit" value="수정 완료">
					<input type="submit" value="삭제" formaction="${pageContext.request.contextPath}/cust/custDelete.do?custCode=${customer.custCode}">   
					<input type="reset" value="취소" id="cancel">
				</div>
				
			</div>
		</form>
	</div>
</body>
</html>