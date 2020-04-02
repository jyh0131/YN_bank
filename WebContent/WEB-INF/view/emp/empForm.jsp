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
<%@include file="../include/menu.jsp" %>
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
					  margin-left: 400px;  }
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
				 line-height: 130px; }
	div#submit input { width: 100px;  height: 40px; 
					   border: none;
					   background: gray; 
					   margin-left:20px; 
					   font-size: 15px;
					   color: whitesmoke;}		
	/* 에러 메세지 */
	.errorMSG {
	  color:tomato;
	  display: none;
	}	
	
   div#profileEdit table td #inputEmpAuth{
	  background: darkgray;
	}
	
   div#profileEdit table td #inputEmpAuth::placeholder{
      color: black;
   }
  div#profileEdit table td #inputEmpPwd::placeholder{
      font-size:12px;
  }
				   				    
</style>

<script>
    $(function(){
		
		
		
		
		//get에서 부서별로 사원들의 마지막 값을 받아옴 
    	var lastNumForHR = "${numHR}";
    	var lastNumForCS = "${numCS}";
    	// alert(deptInfo); -1이 뜸 
    	$("input[name='empCode']").val(lastNumForHR);
    	//부서 선택이 바뀔때마다 
    	$("#selectForDept").on("change",function(){
    		var deptInfo = $("#selectForDept option:selected").val();
    		if(deptInfo == 1){
        		$("input[name='empCode']").val(lastNumForHR);
        	}else{
        		$("input[name='empCode']").val(lastNumForCS);
        	}
  	  })
    	
      //아이디와 비밀번호 정규표현식으로 걸러내기 
      $("form").submit(function(){
    	    $(".errorMSG").css("display","none");
    	var empCode = $("input[name='empCode']").val();
  		var empName = $("input[name='empName']").val();
  		var empTitle =$("input[name='empTitle']").val();
  		var empAuth = $("input[name='empAuth']").val();
  		var empSalary = $("input[name='empSalary']").val();
  		var empTel = $("input[name='empTel']").val();
  		var empId = $("input[name='empId']").val();
  		var empPwd = $("input[name='empPwd']").val();
  		
    	    //빈 값이 있을땐 못넘어 가도록 처리 /정규표현식 이용 
    	    if(empName==""){
    	    	$("input[name='empName']").next().next().css("display","inline");
    	    	return false;
    	    }
    	    //네임은 2-5 한글
    	    var nameReg =/^[가-힣]{2,5}$/;
    	    if(nameReg.test(empName) == false){
    	    	$("input[name='empName']").next().next().next().css("display","inline");
    	    	return false;	
    	    }
    	   
    	    
    	    
    	    else if(empCode==""){
    	    	$("input[name='empCode']").next().next().css("display","inline");
    	    	return false;
    	    }else if(empTitle==""){
    	    	$("input[name='empTitle']").next().next().css("display","inline");
    	    	return false;
    	    }else if(empSalary==""){
    	    	$("input[name='empSalary']").next().next().css("display","inline");
    	    	return false;
    	    }else if(empTel==""){
    	    	$("input[name='empTel']").next().next().css("display","inline");
    	    	return false;
    	    }
    	  
    	    var idReg = /^[a-z0-9]{6,15}$/i ; //영어, 숫자 6-15	
    		if(idReg.test(empId)==false || empId==""){ //아이디가 빈값일 때도 넘어가지 못하게 처리 
    			//alert("안돼 돌아가");
    	    	$("input[name='empId']").next().next().css("display","inline");
    	    	return false;
    	    }
    	    
    	    
    		 $.ajax({
     	    	url: "${pageContext.request.contextPath}/emp/empAdd.do",
 			    type: "post", 
 			    dataType: "json",
 			    success : function(res){
 			    	if(res.error == "notExist"){
 			    		$("input[name='empName']").next().next().next().next().css("display","inline");
 		    	    	return false;	
 			    	}
 			    }

     	    })

      })

    })

</script>



<body>
	<div id="container">
		<div id="header">
			<h1>사용자 프로필</h1>
		</div>
		<form action="empAdd.do" method="post" enctype="multipart/form-data">
			
			<div id="profile">
				<h2>프로필</h2>
				<div id="profileMain">
					<div id="pic">
						<img alt="사원사진" src="${pageContext.request.contextPath}/images/no-img.png"> 
						<span id="proName"></span>
						<span id="proDept"></span>
						
					</div>
					<div id="nameInfo">
						
					</div>
				</div>
				<div id="profileEdit">
					<table>
						<tr>
							<th>사원 코드</th>
							<td><input type="text" name="empCode"><br>
							<span class="errorMSG">사원코드를 입력해주세요. 부서 선택시 자동으로 출력됩니다.</span></td>
						</tr>
						<tr>
							<th>이름</th>
							<td><input type="text" name="empName"><br>
							<span class="errorMSG">사원이름을 입력해주세요.</span>
							<span class="errorMSG">사원이름은 2-5자리 한글로 입력해주세요.</span>
							<span class="errorMSG">사원이름 중복입니다. 구분이 필요합니다.</span></td>
							</td>
						</tr>
						<tr>
							<th>직책</th>
							<td><input type="text" name="empTitle" placeholder="사원,대리,과장,차장,부장,부지점장,지점장"><br>
							<span class="errorMSG">직책을 입력해주세요.</span></td>
						</tr>
						<tr>
							<th>권한</th>
							<td><input type="text" name="empAuth" readonly="readonly" placeholder="권한탭에서 부여가능한 부분입니다." id="inputEmpAuth"></td>
						</tr>
						<tr>
							<th>월급</th>
							<td><input type="text" name="empSalary" placeholder="숫자만입력"><br>
							<span class="errorMSG">월급을 입력해주세요</span>
							<span class="errorMSG">숫자만 입력해주세요.</span></td></td>
						</tr>
						<tr>
							<th>연락처</th>
							<td><input type="text" name="empTel" placeholder="예시: 010-000-0000"><br>
							<span class="errorMSG">연락처를 입력해주세요 010-000-0000</span></td>
						</tr>
						<tr>
							<th>아이디</th>
							<td><input type="text" name="empId" placeholder="6-15자리 영어,숫자 조합"><br>
							<span class="errorMSG">아이디를 입력해주세요. </span></td>
							<span class="errorMSG">아이디를 확인해 주세요. 6-15자리 영어,숫자 조합</span></td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td><input type="text" name="empPwd" placeholder="4-15자리 영어,숫자,특수문자!@#$%^&*사용가능" id="inputEmpPwd"><br>
							<span class="errorMSG">비밀번호를 입력해주세요</span></td>
							<span class="errorMSG">비밀번호를 확인해주세요. 4-15자리 영어,숫자,특수문자!@#$%^&*사용가능</span></td>
							</td>
						</tr>
						<tr>
							<th>부서</th>
							<td>
								<select name="deptNo" id="selectForDept">
									<option value="1">인사(1)</option>
									<option value="2">고객(2)</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>이미지 선택</th>
							<td id="noline"><input type="file" name="pic"></td>
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