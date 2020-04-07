<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/menu.jsp"%>
<%@include file="../include/sectionBar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</head>
<style>
		* { font-family: 'Noto Sans KR', sans-serif; }
		div#search {
			width: 900px;
			margin: 50px auto;
			text-align: center;
		}
		
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
		
		
		div#table {
			width: 900px;
			margin: 100px auto;
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
		
		div#table th.thPlanName{
		 width: 300px;
		}
		
</style>
<script>
   $(function(){
	   //메뉴보이기
	   $("#empBonusList").show();
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
        var $menutd1 = $("<td>").html("사원코드");
        var $menutd2 = $("<td>").html("사원이름");
        var $menutd3 = $("<td>").html("직책");
        var $menutd4 = $("<td>").html("실적");
        var $menutd5 = $("<td>").html("인센티브");
        var $menutd6 = $("<td>").html("상품종류");
        var $menutd7 = $("<td class='thPlanName'>").html("상품이름");
    
       
        $menutr.append($menutd1);
        $menutr.append($menutd2);
        $menutr.append($menutd3);
        $menutr.append($menutd4);
        $menutr.append($menutd5);
        $menutr.append($menutd6);
        $menutr.append($menutd7);
  
        
        
		  switch(div) {
			case "검색구분":
				alert("검색 조건을 선택해주세요.");
				  break;
			 
			case "사원번호":
				
				
				  $.ajax({
				    url: "${pageContext.request.contextPath}/emp/empBonus.do",
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
				    			var $tr = $("<tr class='oneEmp'>").attr('data-empCode',obj.empCode).attr('data-perf',obj.perf);
				    			var $td1 = $("<td>").html(obj.empCode);
				    			var $td2 = $("<td>").html(obj.empName);
				    			var $td3 = $("<td>").html(obj.empTitle);
				    			var $td4 = $("<td>").html(obj.perf);
				    			var $td5 = $("<td>").html(obj.bonus.toLocaleString());
				    			var $td6 = $("<td>").html(obj.pCode);
				    			var $td7 = $("<td>").html(obj.pName);
	                         
				    			$tr.append($td1);
				    			$tr.append($td2);
				    			$tr.append($td3);
				    			$tr.append($td4);
				    			$tr.append($td5);
				    			$tr.append($td6);
				    			$tr.append($td7);
				    			
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
				    url: "${pageContext.request.contextPath}/emp/empBonus.do",
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
				    			var $tr = $("<tr class='oneEmp'>").attr('data-empCode',obj.empCode).attr('data-perf',obj.perf);
				    			var $td1 = $("<td>").html(obj.empCode);
				    			var $td2 = $("<td>").html(obj.empName);
				    			var $td3 = $("<td>").html(obj.empTitle);
				    			var $td4 = $("<td>").html(obj.perf);
				    			var $td5 = $("<td>").html(obj.bonus.toLocaleString());
				    			var $td6 = $("<td>").html(obj.pCode);
				    			var $td7 = $("<td>").html(obj.pName);
	                         
				    			$tr.append($td1);
				    			$tr.append($td2);
				    			$tr.append($td3);
				    			$tr.append($td4);
				    			$tr.append($td5);
				    			$tr.append($td6);
				    			$tr.append($td7);
				    			
				    			
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
				    url: "${pageContext.request.contextPath}/emp/empBonus.do",
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
				    			var $tr = $("<tr class='oneEmp'>").attr('data-empCode',obj.empCode).attr('data-perf',obj.perf);
				    			var $td1 = $("<td>").html(obj.empCode);
				    			var $td2 = $("<td>").html(obj.empName);
				    			var $td3 = $("<td>").html(obj.empTitle);
				    			var $td4 = $("<td>").html(obj.perf);
				    			var $td5 = $("<td>").html(obj.bonus.toLocaleString());
				    			var $td6 = $("<td>").html(obj.pCode);
				    			var $td7 = $("<td>").html(obj.pName);
	                         
				    			$tr.append($td1);
				    			$tr.append($td2);
				    			$tr.append($td3);
				    			$tr.append($td4);
				    			$tr.append($td5);
				    			$tr.append($td6);
				    			$tr.append($td7);
				    			
				    			
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
				    url: "${pageContext.request.contextPath}/emp/empBonus.do",
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
				    			
				    			var $tr = $("<tr class='oneEmp'>").attr('data-empCode',obj.empCode).attr('data-perf',obj.perf);
				    			var $td1 = $("<td>").html(obj.empCode);
				    			var $td2 = $("<td>").html(obj.empName);
				    			var $td3 = $("<td>").html(obj.empTitle);
				    			var $td4 = $("<td>").html(obj.perf);
				    			var $td5 = $("<td>").html(obj.bonus.toLocaleString());
				    			var $td6 = $("<td>").html(obj.pCode);
				    			var $td7 = $("<td>").html(obj.pName);
	                         
				    			$tr.append($td1);
				    			$tr.append($td2);
				    			$tr.append($td3);
				    			$tr.append($td4);
				    			$tr.append($td5);
				    			$tr.append($td6);
				    			$tr.append($td7);
				    			
				    			
				    			
				    			
				    			$table.append($tr);
				    		})
				    		//테이블 div
				    		$("#table").append($table);
				    	}
				    }
				  
			    })
			  break;
		  }
		  
	  })
	   
	    //각 줄을 클릭할 때마다 내가 부여한 data-empCode를 받아오기 
	    
	    
	    $(document).on("click",".oneEmp",function(){
          var OneCode = $(this).attr("data-empCode");
		  var perf = $(this).attr("data-perf");
		  if(perf == 0){
			  alert("실적이 없는 사원입니다.");
			  return false
		  }
		  //alert(OneCode);
		  location.href="${pageContext.request.contextPath}/emp/empBonusDetail.do?empCode="+OneCode;
	  })
	  
	  
   })


</script>
<body>
	<section>
		<div id="search">
				<select id="searchMenu">
				    <option>검색구분</option>
					<option>사원번호</option>
					<option>사원이름</option>
					<option>부서(인사 or 고객)</option>
					<option>직급</option>
					
				</select>
			
					<fieldset><input type="search" name="search" id="searchForEmp" />
						<button type="submit">
							<i class="fa fa-search"></i>
						</button>	
					</fieldset>
				
		</div>
		<div id="table">
			<table class="tableList">
				<tr>
					<th>사원코드</th>
					<th>사원이름</th>
					<th>직책</th>
					<th>실적</th>
					<th>인센티브</th>
					<th>상품 종류</th>
					<th class="thPlanName">상품 이름</th>
				

				</tr>
				<span id="renew">
				<c:forEach var='empList' items="${list }">
				<tr class="oneEmp" data-empCode="${empList.empCode }" data-perf="${empList.perf }">
					<td>${empList.empCode }</td>
					<td>${empList.empName }</td>
					<td>${empList.empTitle }</td>
					<td>${empList.perf}</td>
					<td><fmt:formatNumber value='${empList.bonus }' pattern='###,###,###'/></td>
					<td>${empList.pCode}</td>
					<td>${empList.pName }</td>	
				</tr>
	            </a>
				</c:forEach>
				</span>
		</table>
		
		</div>   
		</section>
</body>
</html>