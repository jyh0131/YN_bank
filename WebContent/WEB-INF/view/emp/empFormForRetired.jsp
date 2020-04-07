<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</head>
<%@include file="../include/menu.jsp"%>
<%@include file="../include/sectionBar.jsp"%>
<style>
* {
	margin: 0;
	padding: 0;
	font-family: 'Noto Sans KR', sans-serif;
	color: #252525;
}

#container {
	width: 1000px;
	margin: 0 auto;
}

div#header {
	background: goldenrod;
	height: 150px;
}

div#header h1 {
	padding: 30px;
}

div#profile {
	background: whitesmoke;
	height: 600px;
	border-radius: 10px;
	padding: 50px;
}

div#profile h2 {
	height: 50px;
}

div#profileMain {
	float: left;
}

div#profileMain div#pic {
	width: 250px;
	height: 350px;
}

div#profileMain div#pic span {
	display: block;
	width: 100px;
	height: 100px;
	float: left;
	text-align: center;
}

div#profileMain div#pic #proName {
	width: 100x;
	font-size: 25px;
	font-weight: bold;
	line-height: 100px;
}

div#profileMain div#pic #proDept {
	line-height: 110px;
	font-size: 20px;
	text-align: left;
}

div#profile div#pic img {
	width: 200px;
	height: 250px;
	display: block;
}

div#profileEdit {
	width: 600px;
	overflow: hidden;
	margin-left: 400px;
}

div#profileEdit table {
	width: 500px;
}

div#profileEdit table tr {
	height: 30px;
}

div#profileEdit table th {
	width: 100px;
	text-align: left;
}

div#profileEdit table td {
	width: 200px;
	text-align: center;
}

div#profileEdit table td input {
	width: 250px;
	background: whitesmoke;
	border: none;
	padding: 10px;
	border-bottom: 1px solid gray;
}

table td#noline input[name='file'] {
	border: none;
}

div#profileEdit table td select {
	width: 250px;
	margin: 20px 0;
}

div#submit {
	text-align: center;
	height: 100px;
	line-height: 130px;
}

div#submit input {
	width: 100px;
	height: 40px;
	border: none;
	background: gray;
	margin-left: 20px;
	font-size: 15px;
	color: whitesmoke;
}
/* 에러 메세지 */
.errorMSG {
	color: tomato;
	display: none;
	font-size: 12px;
}


div#profileEdit table td input {
	background: lightgray;
}


</style>

<script>
	$(function() {
		//선택한 메뉴 보이도록 
		$("#empAdd").show();
		$("#empList").show();

	
			
			$("#empName").change(function(){
				var empNameForProfile = $("#empName").val(); 
				//alert(empNameForProfile);
				$("#proName").html(empNameForProfile);
			})
		
			
	
			//취소 버튼 누르면
			$("#returnToList").click(function(){
				location.href="${pageContext.request.contextPath}/emp/empSearchRetired.do";
			})
			
			
	})
</script>



<body>
	<div id="container">
		<div id="header">
			<h1>퇴사 사원 정보</h1>
		</div>
		<form action="empUpdate.do" method="post" enctype="multipart/form-data">

			<div id="profile">
				<h2>프로필</h2>
				<div id="profileMain">
					<div id="pic">
						<img alt="사원사진"
							src="${pageContext.request.contextPath}/images/${emp.pic ==null?'no-img.jpg':emp.pic}" id="empPicture">
						<span id="proName">${emp.empName }</span> <span id="proDept">${emp.dept.deptName }팀</span>

					</div>
					<div id="nameInfo"></div>
				</div>
				<div id="profileEdit">
					<table>
						<tr>
							<th>사원 코드</th>
							<td><input type="text" name="empCode" readonly="readonly" value="${emp.empCode}" id="inputCode"><br> <span
								class="errorMSG">사원코드를 입력해주세요. 부서 선택시 자동으로 출력됩니다.</span></td>
						</tr>
						<tr>
							<th>이름</th>
							<td><input type="text" name="empName" id="empName" value="${emp.empName }" readonly="readonly"><br> <span
								class="errorMSG">사원이름을 입력해주세요.</span> <span class="errorMSG">사원이름은
									2-5자리 한글로 입력해주세요.</span> <span class="errorMSG">사원이름 중복입니다. 구분이
									필요합니다.</span></td>
							</td>
						</tr>
						<tr>
							<th>직책</th>
							<td><input type="text" name="empTitle" readonly="readonly" placeholder="사원,대리,과장,차장,부장,부지점장,지점장" value="${emp.empTitle }"><br> 
							<span class="errorMSG">직책을 입력해주세요.</span> 
							<span class="errorMSG">직책을 확인해주세요.</span></td>
						</tr>
						<tr>
							<th>권한</th>
							<td><input type="text" name="empAuth" readonly="readonly"
								placeholder="권한탭에서 부여가능한 부분입니다." id="inputEmpAuth" value="${emp.empAuth ==''?'':emp.empAuth }"></td>
						</tr>
						<tr>
							<th>월급</th>
							<td><input type="text" name="empSalary" placeholder="숫자만입력"  readonly="readonly" value="<fmt:formatNumber value='${emp.empSalary }' pattern='###,###,###'/>"><br>
								<span class="errorMSG">월급을 입력해주세요</span> 
								<span class="errorMSG">숫자만 입력해주세요.</span></td>
						</tr>
						<tr>
							<th>연락처</th>
							<td><input type="text" name="empTel" readonly="readonly"
								placeholder="예시: 010-000-0000" value="${emp.empTel }"><br> <span
								class="errorMSG">연락처를 확인해주세요 000-000-0000</span></td>
						</tr>
						<tr>
							<th>아이디</th>
							<td><input type="text" name="empId"
								placeholder="6-15자리 영어,숫자 조합" value="${emp.empId }" readonly="readonly" id="inputId"><br> 
								<span class="errorMSG">아이디를 입력해주세요. </span>
							    <span class="errorMSG">아이디를 확인해 주세요. 6-15자리 영어,숫자 조합</span>
							</td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td><input type="text" name="empPwd" readonly="readonly"
								placeholder="4-15자리 영어,숫자,특수문자!@#$%^&*사용가능" id="inputEmpPwd" value="**********"><br>
								<span class="errorMSG">비밀번호를 입력해주세요</span>
							<span class="errorMSG">비밀번호를 확인해주세요. <br> 4-15자리
								영어,숫자,특수문자!@#$%^&*사용가능</span>
							</td>
							
						</tr>
						<tr>
							<th>부서</th> <!-- 바로 부서별로 선택되도록 하기  -->
							<td><input type="text" name="deptNo" id="selectForDept" value="${emp.dept.deptName }"></td>
						</tr>
						

					</table>
				</div>

				<div id="submit">
				
					<input type="button" value="목록으로" id="returnToList">
			
				</div>

			</div>
		</form>
	</div>
</body>
</html>