<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/menu.jsp"%>
<%@include file="../include/sectionBar.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/6f2f0f2d95.js"></script>
</head>
<style>
		* { font-family: 'Noto Sans KR', sans-serif; }
		div#search {
			width: 900px;
			margin: 50px auto;
			text-align: center;
		}
		
		h2#menuLocation { width: 200px; height: 60px;  
						  line-height: 60px; 
						  margin: 0 500px;      
						  border-bottom: 2px solid #e9ebec;}  
		
		div#search select {
			width: 200px; height : 30px;
			border: none;
			font-size: 16px;
			border: 1px solid goldenrod;;
		}
		
		fieldset { position: relative;  
				   top:10px; 
		 		   display: inline-block;  
		 		   padding: 0 0 0 40px;  
		 		   background: #fff;  
		 		   border: none;  
		 		   border-radius: 5px; } 
		 		   
		input, button { position: relative;  
						width: 200px;  height: 35px;  
						padding: 0;  
						display: inline-block;  
						float: left; }
		input {  color: #666;  
		 		 z-index: 2; 
		 		 border:none;  
		 		 border-bottom: 1px solid goldenrod; }
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
		span#guide { font-weight: bold; 
					 font-size: 15px;    
					  }
		
		div#table {
			width: 900px;
			margin: 20px auto;
		}
		
		div#table table {
			border-collapse: collapse; 
		}
		
		div#table th, td {
			width: 200px; 
			height: 30px;
			text-align: center;
			font-size: 15px;
		}
		
		div#table tr:nth-child(odd) {
			width: 200px; 
			height: 30px;
			text-align: center;
			background: gainsboro;
			font-size: 15px;
		}
		
		div#table tr:hover td { background: goldenrod;}
	#btnNone{
	   margin-left:500px;
	   width:150px;
	   border:2px solid goldenrod;
	   border-radius: 10px;
	   background: none;
	}	
	#btnNone:hover {
	  background: goldenrod;
	  font-weight: bold;
}

  div#table th.thTel{
      width: 300px;
   }
  div#coutOfEmp{
      width:300px;
      margin-left:500px;
  }
  div#avgSalary{
      width:300px;
      margin-left:790px; 
      margin-bottom:50px;
  }
</style>
<script>
   $(function(){
	   
	   //선택한 메뉴 보이도록 설정 
	   $("#empAdd").show();
	   $("#empList").show();
	  $("select").on("change",function(){
		  $("table").load(location.href+" table");
		  $("#searchForEmp").val("");
	  })
	  $("button").eq(0).click(function(){
		  var div = $("#searchMenu option:selected").val();
	      var search = $("input[name='search']").val();
    //			alert(search);
    
    
        var $table = $("<table>").addClass("tableList");
        
        var $menutr = $("<tr>");
        var $menutd1 = $("<th>").html("사원코드");
        var $menutd2 = $("<th>").html("사원이름");
        var $menutd3 = $("<th>").html("직책");
        var $menutd4 = $("<th>").html("권한");
        var $menutd5 = $("<th>").html("월급");
        var $menutd6 = $("<th class='thTel'>").html("연락처");
        var $menutd7 = $("<th>").html("아이디");
        var $menutd8 = $("<th>").html("비밀번호");
        var $menutd9 = $("<th>").html("부서");
        $menutr.append($menutd1);
        $menutr.append($menutd2);
        $menutr.append($menutd3);
        $menutr.append($menutd4);
        $menutr.append($menutd5);
        $menutr.append($menutd6);
        $menutr.append($menutd7);
        $menutr.append($menutd8);
        $menutr.append($menutd9);
        
        
		  switch(div) {
			case "검색구분":
				alert("검색 조건을 선택해주세요.");
				  break;
			 
			case "사원번호":
				
				
				  $.ajax({
				    url: "${pageContext.request.contextPath}/emp/empSearch.do",
				    type: "post", 
				    data: {"search":search,"div":div},
				    dataType: "json",
				    success : function(res){
				    	console.log(res);
				    	if(res.error == "notExist"){
				    		alert("존재하지 않는 사원입니다. 사원번호를 확인해주세요");
				    	}else{
				    		
				    		$(".tableList").remove();
		
				    		$(res).each(function(i,obj){
				    			var $tr = $("<tr class='oneEmp'>").attr("data-empCode",obj.empCode);
				    			var $td1 = $("<td>").html(obj.empCode);
				    			var $td2 = $("<td>").html(obj.empName);
				    			var $td3 = $("<td>").html(obj.empTitle);
				    			var $td4 = $("<td>").html(obj.empAuth);
				    			var $td5 = $("<td>").html(obj.empSalary.toLocaleString());
				    			var $td6 = $("<td>").html(obj.empTel);
				    			var $td7 = $("<td>").html(obj.empId);
				    			var $td8 = $("<td>").html("**********");
				    			var $td9 = $("<td>").html(obj.dept.deptName);
	                         
				    			$tr.append($td1);
				    			$tr.append($td2);
				    			$tr.append($td3);
				    			$tr.append($td4);
				    			$tr.append($td5);
				    			$tr.append($td6);
				    			$tr.append($td7);
				    			$tr.append($td8);
				    			$tr.append($td9);
				    			
				    			$table.append($menutr);
				    			$table.append($tr);
				    		})
				    		//테이블 div
				    		$("#table").append($table);
				    	}
				    }
				  
			    })
			  break; 
			case "사원이름":
				
				
				  $.ajax({
				    url: "${pageContext.request.contextPath}/emp/empSearch.do",
				    type: "post", 
				    data: {"search":search,"div":div},
				    dataType: "json",
				    success : function(res){
				    	console.log(res);
				    	if(res.error == "notExist"){
				    		alert("존재하지 않는 사원입니다");
				    	
				    	}else{
				    		
				    		$(".tableList").remove();
				    		$table.append($menutr);
				    		$(res).each(function(i,obj){
				    			var $tr = $("<tr class='oneEmp'>").attr("data-empCode",obj.empCode);
				    			var $td1 = $("<td>").html(obj.empCode);
				    			var $td2 = $("<td>").html(obj.empName);
				    			var $td3 = $("<td>").html(obj.empTitle);
				    			var $td4 = $("<td>").html(obj.empAuth);
				    			var $td5 = $("<td>").html(obj.empSalary.toLocaleString());
				    			var $td6 = $("<td>").html(obj.empTel);
				    			var $td7 = $("<td>").html(obj.empId);
				    			var $td8 = $("<td>").html("**********");
				    			var $td9 = $("<td>").html(obj.dept.deptName);
	                         
				    			$tr.append($td1);
				    			$tr.append($td2);
				    			$tr.append($td3);
				    			$tr.append($td4);
				    			$tr.append($td5);
				    			$tr.append($td6);
				    			$tr.append($td7);
				    			$tr.append($td8);
				    			$tr.append($td9);
				    			
				    			
				    			$table.append($tr);
				    		})
				    		//테이블 div
				    		$("#table").append($table);
				    	}
				    }
				  
			    })
			  break;  
			case "부서(인사 or 고객)":
				
				
				  $.ajax({
				    url: "${pageContext.request.contextPath}/emp/empSearch.do",
				    type: "post", 
				    data: {"search":search,"div":div},
				    dataType: "json",
				    success : function(res){
				    	console.log(res);
				    	if(res.error == "notExist"){
				    		alert("존재하지 않는 부서입니다.");
				    	}else{
				    		
				    		$(".tableList").remove();
				    		$table.append($menutr);
				    		$(res).each(function(i,obj){
				    			var $tr = $("<tr class='oneEmp'>").attr("data-empCode",obj.empCode);
				    			var $td1 = $("<td>").html(obj.empCode);
				    			var $td2 = $("<td>").html(obj.empName);
				    			var $td3 = $("<td>").html(obj.empTitle);
				    			var $td4 = $("<td>").html(obj.empAuth);
				    			var $td5 = $("<td>").html(obj.empSalary.toLocaleString());
				    			var $td6 = $("<td>").html(obj.empTel);
				    			var $td7 = $("<td>").html(obj.empId);
				    			var $td8 = $("<td>").html("**********");
				    			var $td9 = $("<td>").html(obj.dept.deptName);
	                         
				    			$tr.append($td1);
				    			$tr.append($td2);
				    			$tr.append($td3);
				    			$tr.append($td4);
				    			$tr.append($td5);
				    			$tr.append($td6);
				    			$tr.append($td7);
				    			$tr.append($td8);
				    			$tr.append($td9);
				    			
				    			
				    			$table.append($tr);
				    		})
				    		//테이블 div
				    		$("#table").append($table);
				    	}
				    }
				  
			    })
			  break;  
			
			case "직급":
				
				
				  $.ajax({
				    url: "${pageContext.request.contextPath}/emp/empSearch.do",
				    type: "post", 
				    data: {"search":search,"div":div},
				    dataType: "json",
				    success : function(res){
				    	console.log(res);
				    	if(res.error == "notExist"){
				    		alert("존재하지 않는 직급입니다");
				    	}else{
				    		
				    		$(".tableList").remove();
				    		$table.append($menutr);
				    		$(res).each(function(i,obj){
				    			var $tr = $("<tr class='oneEmp'>").attr("data-empCode",obj.empCode);
				    			var $td1 = $("<td>").html(obj.empCode);
				    			var $td2 = $("<td>").html(obj.empName);
				    			var $td3 = $("<td>").html(obj.empTitle);
				    			var $td4 = $("<td>").html(obj.empAuth);
				    			var $td5 = $("<td>").html(obj.empSalary.toLocaleString());
				    			var $td6 = $("<td>").html(obj.empTel);
				    			var $td7 = $("<td>").html(obj.empId);
				    			var $td8 = $("<td>").html("**********");
				    			var $td9 = $("<td>").html(obj.dept.deptName);
	                         
				    			$tr.append($td1);
				    			$tr.append($td2);
				    			$tr.append($td3);
				    			$tr.append($td4);
				    			$tr.append($td5);
				    			$tr.append($td6);
				    			$tr.append($td7);
				    			$tr.append($td8);
				    			$tr.append($td9);
				    			
				    			
				    			$table.append($tr);
				    		})
				    		//테이블 div
				    		$("#table").append($table);
				    	}
				    }
				  
			    })
			  break;
		  }
		  
	  }) //버튼 이벤트 끝나는 것 
	   
	  
	  //각 줄을 클릭할 때마다 내가 부여한 data-empCode를 받아오기 
	  $(document).on("click",".oneEmp",function(){
		  var OneCode = $(this).attr("data-empCode");
		  //alert(OneCode);
		  location.href="${pageContext.request.contextPath}/emp/empDetail.do?empCode="+OneCode;
	  })
	   
   })


</script>   
<body>   
	<section>
	<h2 id="menuLocation">사원 목록</h2>
		<div id="search">
				<select id="searchMenu">
				    <option>검색구분</option>
					<option>사원번호</option>
					<option>사원이름</option>
					<option>부서(인사 or 고객)</option>    
					<option>직급</option>
					   
				</select>
			
					<fieldset><input type="search" name="search" id="searchForEmp" placeholder="검색어를 입력하세요."/>
						<button type="submit">
							<i class="fa fa-search"></i>
						</button>	
					</fieldset>
				
		</div>
		<a href="empSearchRetired.do"><button id="btnNone">퇴사사원 조회</button></a><br><br>
		<div id="coutOfEmp">인사팀  : ${HR }명 ,  고객팀 : ${CS }명</div>
		
		<div id="table">
			<span><i class="fas fa-exclamation-circle"></i></span><span id="guide">사원 세부 정보를 보려면 사원을 클릭하세요.</span>
			<table class="tableList">
				<tr>
					<th>사원코드</th>
					<th>사원이름</th>
					<th>직책</th>
					<th>권한</th>
					<th>월급</th>
					<th class="thTel">연락처</th>
					<th>아이디</th>
					<th>비밀번호</th>
					<th>부서</th>

				</tr>
				<span id="renew">
				<c:forEach var='empList' items="${list }">
				<tr class="oneEmp" data-empCode="${empList.empCode }" >
					<td>${empList.empCode }</td>
					<td>${empList.empName }</td>
					<td>${empList.empTitle }</td>
					<td>${empList.empAuth }</td>
					<td><fmt:formatNumber value='${empList.empSalary }' pattern='###,###,###'/></td>
					<td>${empList.empTel }</td>
					<td>${empList.empId }</td>
					<td>**********</td>
					<td>${empList.dept}</td>
					
				</tr>
	          
				</c:forEach>
				</span>
		</table>
		
		</div>
		<div id="avgSalary"> 평균급여 : <fmt:formatNumber value="${avgSal}" pattern="###,###,###"/> 원</div>
		</section>
</body>
</html>