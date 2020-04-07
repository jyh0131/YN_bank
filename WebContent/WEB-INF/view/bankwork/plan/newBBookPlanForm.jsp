<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../include/menu.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://kit.fontawesome.com/6f2f0f2d95.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<style>
	* { margin:0; padding:0; 
		font-family: 'Noto Sans KR', sans-serif;
		color: #252525; }
	div#dummy { height: 75px; background: #292929;}
	#container { width: 1000px; margin: 30px auto;}
	div#header { background: goldenrod;
			     height: 150px; }
	div#header h1 { padding: 30px;  }
	
	/* 프로필 */
	
	div#profile { background: whitesmoke;
				  height: 500px;
				  border-radius: 10px;
				  padding: 50px;}
	div#profile h2 { height: 50px; }				  
	div#profileMain { float: left; }
	
	
	div#profileEdit { width:600px; 
					  overflow: hidden;
					  margin-left: 200px;  }
	div#profileEdit table { width: 600px; }
	div#profileEdit table tr { height: 50px; }
	div#profileEdit table th { width: 100px; text-align: left; }
	div#profileEdit table tr td { width: 250px; text-align: center; }
	div#profileEdit table td.mark { width: 50px; height: 50px; text-align: left; line-height: 80px;}
	div#profileEdit table tr.long { height: 70px; }
	div#profileEdit table td#regExp { width: 200px; 
									  color: maroon;
									  font-weight: bold;  
									  font-size: 14px;
									  height: 40px;
									  line-height: 40px;
									  display: none;  }
	div#profileEdit table td input { width: 250px;
									 background: whitesmoke;
								     border: none; 
								     padding: 10px; 
								     border-bottom: 1px solid gray;}						     
	div#profileEdit table td select { width: 250px; margin: 20px 0;}		  
	div#submit { text-align: center; 
				 height: 100px;           
				 line-height: 160px; }
	div#submit input { width: 100px;  height: 40px; 
					   border: none;
					   background: gray; 
					   margin-left:20px;    
					   font-size: 15px;
					   color: whitesmoke;}						         
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	$(function(){
		$("#custAdd").show();
		$("#custList").show();
		
		
		   $("input[type='submit']").submit(function(){
			var add = confirm("상품을 추가하시겠습니까?");
			if(add==false){
				return false;
			}
			
		})
		
		
		$("input[type='reset']").click(function(){
			var choose = confirm("신규 상품 추가를 취소하시겠습니까? 메인으로 돌아갑니다.");
			if(choose){
				$(location).attr('href','${pageContext.request.contextPath}/main/main.do');
			}else {
				return false;
			}
			
		})
	})
</script>
<body>
	<%@include file="../../include/sectionBar.jsp"%>
	<div id="container">
		<div id="header">
			<h1>상품 추가</h1>
		</div>
		<form action="addPlan.do" method="post">
			
			<div id="profile">
				<h2>상품</h2>
				<div id="profileEdit">
					<table>
						<tr>
							<th>상품 코드</th>
							<td>
								<input type="text" name="planCode" value="${planA }" readonly="readonly">
							</td>
							<td class="mark"><i class="far fa-question-circle"></i></td>
						</tr>
						<tr>
							<th>상품 세부코드</th>
							<td><input type="text" name="planDetail" value="${planAwhat }" readonly="readonly"></td>
							<td class="mark"><i class="far fa-question-circle"></i></td>
						</tr>
						<tr>
							<th>상품 명</th>     
							<td>
								<input type="text" name="planName">
							</td>  
								
						</tr>
						<tr>
							<th>상품 세부 설명</th>
							<td><textarea cols="50" rows="3" name="planDesc"></textarea></td>
						</tr>  
						<tr class="long">
							<th>상품 구분코드</th>
							<td><select name="planDiv">
									<option>구분 코드 선택</option>
									<option>V</option>
									<option>N</option>
								</select></td>
							<td class="mark"><i class="far fa-question-circle"></i></td>
						</tr>
						
						
						
					</table>
				</div> 
				
				<div id="submit">
					<input type="submit" value="추가">
					<input type="reset" value="취소">
				</div>
				
			</div>
		</form>
	</div>
</body>
</html>