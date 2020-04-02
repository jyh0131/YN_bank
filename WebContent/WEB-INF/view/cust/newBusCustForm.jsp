<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<style>
	* { margin:0; padding:0; 
		font-family: 'Noto Sans KR', sans-serif;
		color: #252525; }
	#container { width: 1000px; margin: 0 auto;}
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
	div#profileEdit table td input.contact { width: 63px; }									     
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
		$("input[type='submit']").click(function(){
			var name = $("input[name='name']").val();
			var addr = $("input[name='addr']").val();
			var contact = $("input[name='contact']").val();
			var rank = $("select[name='rank']").val();
			var credit = $("select[name='credit']").val();
			
			if(name=="" || addr=="" || contact=="" || rank=="등급 선택" || credit=="신용등급 선택" || custDiv=="분류 선택"){
				alert("모든 항목을 선택해주세요.");
				return false;
			}
			
		})
		
		
		$("input[type='reset']").click(function(){
			var choose = confirm("신규 고객 추가를 취소하시겠습니까? 목록으로 돌아갑니다.");
			if(choose){
				$(location).attr('href','${pageContext.request.contextPath}/cust/custSearch.do');
			}else {
				return false;
			}
			
		})
	})
</script>
<body>
	<div id="container">
		<div id="header">
			<h1>고객 추가</h1>
		</div>
		<form action="addBusCust.do" method="post">
			
			<div id="profile">
				<h2>기업 고객</h2>
				<div id="profileEdit">
					<table>
						<tr>   
							<th>고객 코드</th>
							<td><input type="text" name="code" value="${nextCustNum }" disabled></td>
						</tr>
						<tr>
							<th>대표자 명</th>
							<td><input type="text" name="name"></td>
						</tr>
						<tr>
							<th>등급</th>
							<td>
								<select name="rank">
									<option>등급 선택</option>
									<option>Diamond</option>
									<option>Platinum</option>
									<option>Gold</option>
									<option>Silver</option>
									<option>Bronze</option>
								</select>
							</td>
								
						</tr>
						<tr>
							<th>신용등급</th>
							<td><select name="credit">
									<option>신용등급 선택</option>
									<option>1</option>
									<option>2</option>
									<option>3</option>
									<option>4</option>
									<option>5</option>
								</select></td>
						</tr>
						<tr>
							<th>회사 주소</th>
							<td><input type="text" name="addr"></td>
						</tr>
						<tr>
							<th>대표 연락처</th>
							<td>
								<input type="text" class="contact" name="contact1">-
								<input type="text" class="contact"  name="contact2">-
								<input type="text" class="contact"  name="contact3">
							</td>
						</tr>
						
						
					</table>
				</div>
				
				<div id="submit">
					<input type="submit" value="등록">
					<input type="reset" value="취소">
				</div>
				
			</div>
		</form>
	</div>
</body>
</html>