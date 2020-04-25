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
<link href="../formCSS.css" rel="stylesheet" />
<style>

div#submit input#delRed{
   background: tomato;
}
</style>

<script>
	$(function() {
		$("#empAdd").show();
		$("#empList").show();
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
					var empSalary = $("input[name='empSalary']").val();
					var empTel = $("input[name='empTel']").val();
					var empId = $("input[name='empId']").val();
					var empPwd = $("input[name='empPwd']").val();

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
					//월급
					if (empSalary == "") {
						$("input[name='empSalary']").next().next().css("display", "inline");
						return false;
					}else{
						//alert(Number(empSalary)); //NaN
						if(isNaN(Number(empSalary))){
							$("input[name='empSalary']").next().next().next().css("display", "inline");
							return false;
						}
					} 
					
					if (empTel == "") {
						$("input[name='empTel']").next().next().css("display","inline");
						return false;
					}else{
						var phoneReg = /^(010|011|019|018|017)-[0-9]{3,4}-[0-9]{4}$/; 
						if (phoneReg.test(empTel) == false) {
							$("input[name='empTel']").next().next().css("display", "inline");
							return false;
						}
						
					} 
					
					if (empId == "") { 
						$("input[name='empId']").next().next().css("display","inline");
						return false;
					} else {
						var idReg = /^[a-z0-9]{6,15}$/i; //영어, 숫자 6-15	

						if (idReg.test(empId) == false || empId == "") { //아이디가 빈값일 때도 넘어가지 못하게 처리 
							//alert("안돼 돌아가");
							$("input[name='empId']").next().next().next().css("display", "inline");
							return false;
						}

					}
					
					//비밀번호 
					if (empPwd =="")  { //4-15자리 영어,숫자,특수문자!@#$%^&*사용가능
						$("input[name='empPwd']").next().next().css("display","inline");
						return false;
					}else{
						 var pwdReg = /^[a-zA-Z0-9!@#%^&*]{4,15}/;
							 if(pwdReg.test(empPwd) == false){
								 $("input[name='empPwd']").next().next().next().css("display","inline");
								 return false;
						 }
					}
	

				}) //서밋 끝나는거 
				
				
				
				
				
				//파일 선택시 이미지 변경 
				$("#empFile").change(function(){
					var full = $(this).val().split("\\");
					//alert(full);
				    
					if(full ==""){
						$("#empPicture").attr("src","${pageContext.request.contextPath}/images/no-img.jpg");	
					}else{
					f_name = full[full.length-1]; //마지막 화일명
				//     s_name = f_name.substring(f_name.length-4, f_name.length);//확장자빼오기
                   // alert(f_name);
		
				  $("#empPicture").attr("src","upload/"+f_name);
				}	
			})
			
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
			//취소 버튼 누르면
			$("#returnToList").click(function(){
				location.href="${pageContext.request.contextPath}/emp/empSearch.do";
			})
			$("#empFile").change(function(){
					
					setImgFromFile(this,"#empPicture");
					
			});
			 function setImgFromFile(input, expression){
		    	if(input.files && input.files[0]){
		    		var reader = new FileReader();
		    		
		    		 reader.onload = function(e){
		    			 $(expression).attr('src',e.target.result);
		    		 }
		    		 reader.readAsDataURL(input.files[0])
		    	}
		    }
			
			//삭제버튼 누를 때 
			$("#delRed").click(function(){
				var con = confirm("해당 사원을 삭제하시겠습니까?");
			    if(con){
			    	
			    	location.href="empDelete.do?no=${emp.empCode }";
			    }
			
			})
	})
</script>



<body>
	<div id="container">
		<div id="header">
			<h1>사원 정보</h1>
		</div>
		<form action="empUpdate.do" method="post" enctype="multipart/form-data">

			<div id="profile">
				<h2>프로필</h2>
				<div id="profileMain">
					<div id="pic">
						<img alt="사원사진"
							src="${pageContext.request.contextPath}/empPic/${emp.pic ==null?'no-img.jpg':emp.pic}" id="empPicture">
						<span id="proName">${emp.empName }</span> <span id="proDept"></span>

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
							<td><input type="text" name="empName" id="empName" value="${emp.empName }"><br> <span
								class="errorMSG">사원이름을 입력해주세요.</span> <span class="errorMSG">사원이름은
									2-5자리 한글로 입력해주세요.</span> <span class="errorMSG">사원이름 중복입니다. 구분이
									필요합니다.</span></td>
							</td>
						</tr>
						<tr>
							<th>직책</th>
							<td><input type="text" name="empTitle" placeholder="사원,대리,과장,차장,부장,부지점장,지점장" value="${emp.empTitle }"><br> 
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
							<td><input type="text" name="empSalary" placeholder="숫자만입력" value='${emp.empSalary }'><br>
								<span class="errorMSG">월급을 입력해주세요</span> 
								<span class="errorMSG">숫자만 입력해주세요.</span></td>
						</tr>
						<tr>
							<th>연락처</th>
							<td><input type="text" name="empTel"
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
							<td><input type="text" name="empPwd"
								placeholder="4-15자리 영어,숫자,특수문자!@#$%^&*사용가능" id="inputEmpPwd" value="**********"><br>
								<span class="errorMSG">비밀번호를 입력해주세요</span>
							<span class="errorMSG">비밀번호를 확인해주세요. <br> 4-15자리
								영어,숫자,특수문자!@#$%^&*사용가능</span>
							</td>
							
						</tr>
						<tr>
							<th>부서</th> <!-- 바로 부서별로 선택되도록 하기  -->
							<td><select name="deptNo" id="selectForDept" >
									<option value="1" ${emp.dept.deptNo == 1 ? 'selected': '' }>인사(1)</option>
									<option value="2" ${emp.dept.deptNo == 2 ? 'selected': '' }>고객(2)</option>
							</select></td>
						</tr>
						<tr>
							<th>이미지 선택</th>
							<td id="noline"><input type="file" name="pic" id="empFile" value=${emp.pic }></td>
						</tr>

					</table>
				</div>

				<div id="submit">
					<input type="submit" value="수정"> 
					<input type="reset" value="취소" id="returnToList">
					<input type="button" value="삭제" id="delRed">
				</div>

			</div>
		</form>
	</div>
</body>
</html>