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
<script src="https://kit.fontawesome.com/6f2f0f2d95.js"></script>
</head>
<style>
		* { font-family: 'Noto Sans KR', sans-serif; }
		
		h2#menuLocation { width: 200px; height: 60px;  
						  line-height: 60px; 
						  margin: 0 500px;      
						  border-bottom: 2px solid #e9ebec;}
		div#search {
			width: 900px;
			margin: 20px auto;
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
		span#guide { font-weight: bold; 
					 font-size: 15px;    
					  }
		
		div#table {
			width: 900px;
			margin: 50px auto;
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
		
		span.imgSpan{
	   margin-left:0;
       width: 60px;
       height: 30px;
       position: relative;
       right:20px;
     }

	img.rankingImg{
	   width:25px;
	   height:20px;
	   margin-right:10px;
	   display: block;
	   position: absolute;
	   top:2;
	   left:-30px;
	}

		
</style>
<script>
   $(function(){
	   //메뉴보이기
	   $("#empBonusList").show();
	   $("#empRealBonusList").show();
	  //랭크 탑3의 코드를 불러옴  
	  var rankMemCode = ["${mem1}","${mem2}","${mem3}"];
	  //alert(rankMemCode[0]);
	  //alert($(".tdForRank").children().eq(1).html());
	  
	 $(document).on("mouseover",".tdForRank",function(){

		 if($(this).children().eq(1).html() == rankMemCode[0]){
			 $(this).children().eq(0).html("<img src='YN_bank../../../images/ranking1.png' class='rankingImg'>");
		 }else if($(this).children().eq(1).html() == rankMemCode[1]){
			 $(this).children().eq(0).html("<img src='YN_bank../../../images/ranking2.png' class='rankingImg'>");
		 }else if($(this).children().eq(1).html() == rankMemCode[2]){
			 $(this).children().eq(0).html("<img src='YN_bank../../../images/ranking3.png' class='rankingImg'>");
		 }
	 
	 })
	 
	 $("select#searchMenu").on("change",function(){
		 // $("table").load(location.href+" table");
		 var planName = $("select#searchMenu").val();
		// alert(planName);
		  $("#searchForEmp").val(planName);
	  })
	
	  
	  
	  $("button").eq(0).click(function(){
		  var div = $("#searchMenu option:selected").val();
	      var search = $("input[name='search']").val();

         if(div =="상품조회"){
        	 alert("상품을 선택하세요");
        	 return false;
         }
         
         var $table = $("<table>").addClass("tableList");
         
         
         var $menutr = $("<tr>");
         var $menutd1 = $("<td>").html("사원코드");
         var $menutd2 = $("<td>").html("사원이름");
         var $menutd3 = $("<td>").html("직책");
         var $menutd4 = $("<td>").html("해당 실적");
         var $menutd5 = $("<td>").html("인센티브");
         
         $menutr.append($menutd1);
         $menutr.append($menutd2);
         $menutr.append($menutd3);
         $menutr.append($menutd4);
         $menutr.append($menutd5);
         

		  $.ajax({
		    url: "${pageContext.request.contextPath}/emp/empRealBonus.do",
		    type: "post", 
		    data: {"search":search,"div":div},
		    dataType: "json",
		    success : function(res){
		    	console.log(res);
		    	if(res.error == "notExist"){
		    		alert("해당 상품의 실적이 존재하지 않습니다.");
		    	}else{
		    		
		    		$(".tableList").remove();
		    		$table.append($menutr);

		    		$(res).each(function(i,obj){
		    			var $tr = $("<tr class='oneEmp'>").attr('data-empCode',obj.empCode).attr('data-perf',obj.perf);
		    			var $td1 = $("<td>").html(obj.empCode);
		    			var $td2 = $("<td>").html(obj.empName);
		    			var $td3 = $("<td>").html(obj.empTitle);
		    			var $td4 = $("<td>").html(obj.perf);
		    			var $td5 = $("<td>").html(obj.bonus);

                    
		    			$tr.append($td1);
		    			$tr.append($td2);
		    			$tr.append($td3);
		    			$tr.append($td4);
		    			$tr.append($td5);
		
		
		    			$table.append($tr);
		    		})
		    		//테이블 div
		    		$("#table").append($table);
		    	}
		    }
		  
	    })
	  })//버튼클릭끝나는거
	   
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
	  
	  $(".tdForRank").mouseover();
   })


</script>
<body>
	<section>
	<h2 id="menuLocation">인센티브 조회</h2>
		<div id="search">
				<select id="searchMenu">
				    <option>상품조회</option>
					<c:forEach var='planList' items="${planList }">
					<option value='${planList.planCode }'>${planList.planName }</option>
					
					</c:forEach>
				</select>
			
					<fieldset><input type="search" name="search" id="searchForEmp" placeholder="인센티브 상품코드를 선택하세요."/>
						<button type="submit">
							<i class="fa fa-search"></i>
						</button>	
					</fieldset>
				
		</div>  
		<div id="table">
		<span><i class="fas fa-exclamation-circle"></i></span><span id="guide">검색 후 세부 내역을 조회하려면 사원을 클릭하세요.</span>
			<table class="tableList">
				<tr>
					<th>사원코드</th>
					<th>사원이름</th>
					<th>직책</th>
					<th>전체 실적</th>
					<th>인센티브</th>
<!-- 					<th>상품 종류</th>
					<th class="thPlanName">상품 이름</th> -->
				

				</tr>
				<span id="renew">
				<%-- <c:forEach var='empList' items="${list }">
				<tr class="oneEmp" data-empCode="${empList.empCode }" data-perf="${empList.perf }">

					<td class="tdForRank"><span class="imgSpan"></span><span class="codeSpan">${empList.empCode }</span></td>

					<td>${empList.empName }</td>
					<td>${empList.empTitle }</td>
					<td>${empList.perf}</td>
					<td><fmt:formatNumber value='${empList.bonus }' pattern='###,###,###'/></td>
	 				<td>${empList.pCode}</td>
					<td>${empList.pName }</td>	 
				</tr>
	          
				</c:forEach> --%>
				</span>
		</table>
		
		</div>   
		</section>
</body>
</html>