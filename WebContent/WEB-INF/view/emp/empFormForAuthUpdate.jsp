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

 div#profileEdit table td #inputEmpAuth {
	background: darkgray;
}

div#profileEdit table td #inputEmpAuth::placeholder {
	color: black;
}

/* div#profileEdit table td #inputEmpPwd::placeholder {
	font-size: 12px;
}  */
</style>

<script>
	$(function() {

/* 		//get에서 부서별로 사원들의 마지막 값을 받아옴 
		var lastNumForHR = "${numHR}";
		var lastNumForCS = "${numCS}";
		// alert(deptInfo); -1이 뜸 
		$("input[name='empCode']").val(lastNumForHR);
		//부서 선택이 바뀔때마다 
		$("#selectForDept").on("change", function() {
			var deptInfo = $("#selectForDept option:selected").val();
			if (deptInfo == 1) {
				$("input[name='empCode']").val(lastNumForHR);
			} else {
				$("input[name='empCode']").val(lastNumForCS);
			}
		}) */

		//아이디와 비밀번호 정규표현식으로 걸러내기 
		$("form").submit(
				function() {
					$(".errorMSG").css("display", "none");
					var empCode = $("input[name='empCode']").val();
					var empName = $("input[name='empName']").val();
					var empTitle = $("input[name='empTitle']").val();
					var empAuth = $("input[name='empAuth']").val();
					

					//빈 값이 있을땐 못넘어 가도록 처리 /정규표현식 이용 

					if (empCode == "") {
						$("input[name='empCode']").next().next().css("display","inline");
						return false;

						// 이름체크
					} 
					
					
					if (empName == "") { //이름값을 입력하지 않은경우
						$("input[name='empName']").next().next().css("display","inline");
						return false;
					} else { //이름은 입력했으나 규칙에 맞지 않는경우 
						var nameReg = /^[가-힣]{2,5}$/; //네임은 2-5 한글
						if (nameReg.test(empName) == false) {
							$("input[name='empName']").next().next().next().css("display", "inline");
							return false;
						}
					} 
					
					
					if (empTitle == "") { //직책
						$("input[name='empTitle']").next().next().css("display", "inline");
						return false;
					} else { //직책
						if ((empTitle == "사원" || empTitle == "대리"
								|| empTitle == "과장" || empTitle == "차장"
								|| empTitle == "부장" || empTitle == "부지점장"
								|| empTitle == "지점장") == false ) {
							$("input[name='empTitle']").next().next().next().css("display", "inline");
							return false;
						}
					} 
			
			
					
				
					
					
					/*  $.ajax({
					 	url: "${pageContext.request.contextPath}/emp/empAdd.do",
					    type: "post", 
					    dataType: "json",
					    success : function(res){
					    	if(res.error == "notExist"){
					    		$("input[name='empName']").next().next().next().next().css("display","inline");
					 	    	return false;	
					    	}
					    }

					 }) */

				}) //서밋 끝나는거 
				
				
				
			
			$("#empName").change(function(){
				var empNameForProfile = $("#empName").val(); 
				//alert(empNameForProfile);
				$("#proName").html(empNameForProfile);
			})
			var pickedDeptNo = ${emp.dept.deptNo };
			//alert(pickedDeptNo);
			if(pickedDeptNo == 1){
				$("#proDept").html("인사팀");
			}else{
				$("#proDept").html("고객팀");
			}
			
			//부서 바꾸기
			$("#selectForDept").change(function(){
				var empDeptNo = $("#selectForDept").val(); 
				
				if(empDeptNo == 1){
					$("#proDept").html("인사팀");
				}else{
					$("#proDept").html("고객팀");
				}

			})
			
			
			
			
	})
</script>



<body>
	<div id="container">
		<div id="header">
			<h1>사용자 프로필</h1>
		</div>
		<form action="empAuthUpdate.do" method="post" >
            <input type="hidden" name="pic" value="${emp.pic }">
			<div id="profile">
				<h2>프로필</h2>
				<div id="profileMain">
					<div id="pic">
						<img alt="사원사진"
							src="${pageContext.request.contextPath}/images/${emp.pic ==null?'no-img.jpg':emp.pic}" id="empPicture">
						<span id="proName">${emp.empName }</span> <span id="proDept"></span>

					</div>
					<div id="nameInfo"></div>
				</div>
				<div id="profileEdit">
					<table>
					    
						<tr>
							<th>사원 코드</th>
							<td><input type="text" name="empCode" readonly="readonly" value="${emp.empCode}" ><br> <span
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
							<td><input type="text" name="empTitle" placeholder="사원,대리,과장,차장,부장,부지점장,지점장" value="${emp.empTitle }" readonly="readonly"><br> 
							<span class="errorMSG">직책을 입력해주세요.</span> 
							<span class="errorMSG">직책을 확인해주세요.</span></td>
						</tr>
						<tr>
							<th>권한</th>
							<td><select name="empAuth" id="selectForAuth" >
							        <option value="" ${emp.empAuth == '' ? 'selected': '' }>권한없음</option>
									<option value="HR" ${emp.empAuth == 'HR' ? 'selected': '' }>HR</option>
									<option value="CS" ${emp.empAuth == 'CS' ? 'selected': '' }>CS</option>
									<option value="AD" ${emp.empAuth == 'AD' ? 'selected': '' }>AD</option>
							</select></td>
						</tr>
						
						<tr>
							<th>부서</th> <!-- 바로 부서별로 선택되도록 하기  -->
							<td><input type="hidden" name="deptNo" id="selectForDept" value="${emp.dept.deptNo}">
								<input type="text" id="deptName" readonly="readonly" value="${emp.dept.deptName }">	
							</td>
						</tr>
					

					</table>
				</div>

				<div id="submit">
					<input type="submit" value="수정"> <input type="reset"
						value="취소">
				</div>

			</div>
		</form>
	</div>
</body>
</html>