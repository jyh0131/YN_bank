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
	   margin-right:30px;
	   display: block;
	   position: absolute;
	   top:2;
	   left:-30px;
	}
	
	 /* 페이징 중앙 위치 처리 */	
		div.sorter { height: 50px; margin-top: 20px;}
		div.sorter ul.pagination {           
			float:right; position:relative; left:-45%;     
		}                
		div.sorter ul.pagination li {     
		float:left; position:relative; margin-right:20px; left:40%;        
		}         
		div.sorter ul.pagination li a {         
			display: block;
			width: 30px; 
			height: 30px;              
			border-radius: 10px;        
			line-height: 30px;  
			text-align: center;     
			font-weight: bold;
		}          
		    
		div#table tr:hover td { background: goldenrod;}
     
		
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
		 var page = ${paging.pageNo};
         if(page == 1){
		 if($(this).children().eq(1).html() == rankMemCode[0]){
			 $(this).children().eq(0).html("<img src='YN_bank../../../images/ranking1.png' class='rankingImg'>");
		 }else if($(this).children().eq(1).html() == rankMemCode[1]){
			 $(this).children().eq(0).html("<img src='YN_bank../../../images/ranking2.png' class='rankingImg'>");
		 }else if($(this).children().eq(1).html() == rankMemCode[2]){
			 $(this).children().eq(0).html("<img src='YN_bank../../../images/ranking3.png' class='rankingImg'>");
		 }
         }
	 })
	 
	 
	 /*  if($(".tdForRank").children().eq(1).html() == rankMemCode[0]){
		 $(".imgSpan").html("<img src='YN_bank../../../images/ranking1.png' class='rankingImg'>");
	  } 
		   */
	   
	  $("select").on("change",function(){
		  $("table").load(location.href+" table");
		  $("#searchForEmp").val("");
		  $(".pagination").load(location.href+" .pagination li");
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
   /*      var $menutd5 = $("<td>").html("인센티브");
        var $menutd6 = $("<td>").html("상품종류");
        var $menutd7 = $("<td class='thPlanName'>").html("상품이름"); */
    
       
        $menutr.append($menutd1);
        $menutr.append($menutd2);
        $menutr.append($menutd3);
        $menutr.append($menutd4);
/*         $menutr.append($menutd5);
        $menutr.append($menutd6);
        $menutr.append($menutd7); */
  
        
        
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
		
				    		$(res.employee).each(function(i,obj){
				    			var $tr = $("<tr class='oneEmp'>").attr('data-empCode',obj.empCode).attr('data-perf',obj.perf);
				    			var $td1 = $("<td>").html(obj.empCode);
				    			var $td2 = $("<td>").html(obj.empName);
				    			var $td3 = $("<td>").html(obj.empTitle);
				    			var $td4 = $("<td>").html(obj.perf);
				    	/* 		var $td5 = $("<td>").html(obj.bonus.toLocaleString());
				    			var $td6 = $("<td>").html(obj.pCode);
				    			var $td7 = $("<td>").html(obj.pName); */
	                         
				    			$tr.append($td1);
				    			$tr.append($td2);
				    			$tr.append($td3);
				    			$tr.append($td4);
				    		/* 	$tr.append($td5);
				    			$tr.append($td6);
				    			$tr.append($td7); */
				    			
				    			$table.append($menutr);
				    			$table.append($tr);
				    		})
				    		//테이블 div
				    		$("#table").append($table);
				    		
				    		$(".sorter").remove();
				    		$divSorter = $("<div>").addClass("sorter");
				    		$ulPaging = $("<ul>").addClass("pagination");
				    		$liPaging1 = $("<li>");
				    		$aPaging1 = $("<a>").attr("href", "#").addClass("prev").html("Prev");
				    		
				    		$liPaging1.append($aPaging1);
				    		$ulPaging.append($liPaging1);
				    		
				    		
				    		for(var i=res.paging.startPageNo; i<=res.paging.endPageNo; i++){
				    			$liPagingRepeat1 = $("<li>").addClass("active");
					    		$aPagingRepeat1 = $("<a>").attr("href", "#").addClass("page").html(i);
					    		$liPagingRepeat2 = $("<li>");
					    		$aPagingRepeat2 = $("<a>").attr("href", "#").addClass("page").html(i);
					    		
					    		$liPagingRepeat1.append($aPagingRepeat1);
					    		
					    		$ulPaging.append($liPagingRepeat1);
				    		}
				    		
				    		$liPaging2 = $("<li>");
				    		$aPaging2 = $("<a>").attr("href", "#").addClass("next").html("Next");
				    		
				    		$liPaging2.append($aPaging2);
				    		$ulPaging.append($liPaging2);
				    		
				    		$divSorter.append($ulPaging);
				    		
				    		$("#table").append($divSorter);
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
				    		$(res.list).each(function(i,obj){
				    			var $tr = $("<tr class='oneEmp'>").attr('data-empCode',obj.empCode).attr('data-perf',obj.perf);
				    			var $td1 = $("<td>").html(obj.empCode);
				    			var $td2 = $("<td>").html(obj.empName);
				    			var $td3 = $("<td>").html(obj.empTitle);
				    			var $td4 = $("<td>").html(obj.perf);
				    	/* 		var $td5 = $("<td>").html(obj.bonus.toLocaleString());
				    			var $td6 = $("<td>").html(obj.pCode);
				    			var $td7 = $("<td>").html(obj.pName); */
	                         
				    			$tr.append($td1);
				    			$tr.append($td2);
				    			$tr.append($td3);
				    			$tr.append($td4);
				/*     			$tr.append($td5);
				    			$tr.append($td6);
				    			$tr.append($td7); */
				    			
				    			
				    			$table.append($tr);
				    		})
				    		//테이블 div
				    		$("#table").append($table);
				    		
				    		$(".sorter").remove();
				    		$divSorter = $("<div>").addClass("sorter");
				    		$ulPaging = $("<ul>").addClass("pagination");
				    		$liPaging1 = $("<li>");
				    		$aPaging1 = $("<a>").attr("href", "#").addClass("prev").html("Prev");
				    		
				    		$liPaging1.append($aPaging1);
				    		$ulPaging.append($liPaging1);
				    		
				    		
				    		for(var i=res.paging.startPageNo; i<=res.paging.endPageNo; i++){
				    			$liPagingRepeat1 = $("<li>").addClass("active");
					    		$aPagingRepeat1 = $("<a>").attr("href", "#").addClass("page").html(i);
					    		$liPagingRepeat2 = $("<li>");
					    		$aPagingRepeat2 = $("<a>").attr("href", "#").addClass("page").html(i);
					    		
					    		$liPagingRepeat1.append($aPagingRepeat1);
					    		
					    		$ulPaging.append($liPagingRepeat1);
				    		}
				    		
				    		$liPaging2 = $("<li>");
				    		$aPaging2 = $("<a>").attr("href", "#").addClass("next").html("Next");
				    		
				    		$liPaging2.append($aPaging2);
				    		$ulPaging.append($liPaging2);
				    		
				    		$divSorter.append($ulPaging);
				    		
				    		$("#table").append($divSorter);
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
				    		$(res.list3).each(function(i,obj){
				    			var $tr = $("<tr class='oneEmp'>").attr('data-empCode',obj.empCode).attr('data-perf',obj.perf);
				    			var $td1 = $("<td>").html(obj.empCode);
				    			var $td2 = $("<td>").html(obj.empName);
				    			var $td3 = $("<td>").html(obj.empTitle);
				    			var $td4 = $("<td>").html(obj.perf);
				    	/* 		var $td5 = $("<td>").html(obj.bonus.toLocaleString());
				    			var $td6 = $("<td>").html(obj.pCode);
				    			var $td7 = $("<td>").html(obj.pName); */
	                         
				    			$tr.append($td1);
				    			$tr.append($td2);
				    			$tr.append($td3);
				    			$tr.append($td4);
				    /* 			$tr.append($td5);
				    			$tr.append($td6);
				    			$tr.append($td7); */
				    			
				    			
				    			$table.append($tr);
				    		})
				    		//테이블 div
				    		$("#table").append($table);
				    		
				    		$(".sorter").remove();
				    		$divSorter = $("<div>").addClass("sorter");  
				    		$ulPaging = $("<ul>").addClass("pagination");
				    		$liPaging1 = $("<li>");
				    		$aPaging1 = $("<a>").attr("href", "#").addClass("prev").html("Prev");
				    		
				    		$liPaging1.append($aPaging1);
				    		$ulPaging.append($liPaging1);
				    		
				    		
				    		for(var i=res.paging.startPageNo; i<=res.paging.endPageNo; i++){
				    			$liPagingRepeat1 = $("<li>").addClass("active");
					    		$aPagingRepeat1 = $("<a>").attr("href", "#").addClass("page").html(i);
					    		
					    		$liPagingRepeat1.append($aPagingRepeat1);
					    		
					    		$ulPaging.append($liPagingRepeat1);
				    		}
				    		
				    		$liPaging2 = $("<li>");
				    		$aPaging2 = $("<a>").attr("href", "#").addClass("next").html("Next");
				    		
				    		$liPaging2.append($aPaging2);
				    		$ulPaging.append($liPaging2);
				    		
				    		$divSorter.append($ulPaging);
				    		   
				    		$("#table").append($divSorter);
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
				    		$(res.list4).each(function(i,obj){
				    			
				    			var $tr = $("<tr class='oneEmp'>").attr('data-empCode',obj.empCode).attr('data-perf',obj.perf);
				    			var $td1 = $("<td>").html(obj.empCode);
				    			var $td2 = $("<td>").html(obj.empName);
				    			var $td3 = $("<td>").html(obj.empTitle);
				    			var $td4 = $("<td>").html(obj.perf);
				    	/* 		var $td5 = $("<td>").html(obj.bonus.toLocaleString());
				    			var $td6 = $("<td>").html(obj.pCode);
				    			var $td7 = $("<td>").html(obj.pName); */
	                         
				    			$tr.append($td1);
				    			$tr.append($td2);
				    			$tr.append($td3);
				    			$tr.append($td4);
				/*     			$tr.append($td5);
				    			$tr.append($td6);
				    			$tr.append($td7); */
				    			
				    			
				    			
				    			
				    			$table.append($tr);
				    		})
				    		//테이블 div
				    		$("#table").append($table);
				    		  
				    		$(".sorter").remove();
				    		$divSorter = $("<div>").addClass("sorter");
				    		$ulPaging = $("<ul>").addClass("pagination");
				    		$liPaging1 = $("<li>");
				    		$aPaging1 = $("<a>").attr("href", "#").addClass("prev").html("Prev");
				    		
				    		$liPaging1.append($aPaging1);
				    		$ulPaging.append($liPaging1);
				    		
				    		
				    		for(var i=res.paging.startPageNo; i<=res.paging.endPageNo; i++){
				    			$liPagingRepeat1 = $("<li>").addClass("active");
					    		$aPagingRepeat1 = $("<a>").attr("href", "#").addClass("page").html(i);
					    		
					    		$liPagingRepeat1.append($aPagingRepeat1);
					    		
					    		$ulPaging.append($liPagingRepeat1);
				    		}
				    		
				    		$liPaging2 = $("<li>");
				    		$aPaging2 = $("<a>").attr("href", "#").addClass("next").html("Next");
				    		
				    		$liPaging2.append($aPaging2);
				    		$ulPaging.append($liPaging2);
				    		
				    		$divSorter.append($ulPaging);
				    		
				    		$("#table").append($divSorter);
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
		  location.href="${pageContext.request.contextPath}/emp/empBonusDetail.do?empCode="+OneCode+"&bonus=bonus";
	  })
	  
	  $(".tdForRank").mouseover();
	
	//페이지 각 번호 클릭 시  
		$(document).on("click", ".page",function() {
			var page = $(this).html();
	        location.href = "${pageContext.request.contextPath}/emp/empBonus.do?page="+page;
		})   
		
		//prev 클릭시 이전 번호로 돌아감 (paging.pageNo = 현재 페이지 넘버)
		$(document).on("click", ".prev" , function(){
			var page = ${paging.pageNo}-1;
			//.page 태그(페이징의 번호)가 1개 밖에 없을 경우(1페이지 밖에 없을 경우) prev, next 버튼으로 이동 제한
			if($(".page").size()==1){
				return false;       
			}
			location.href = "${pageContext.request.contextPath}/emp/empBonus.do?page="+page;
		})  
		//next 클릭시  다음 번호로 넘어감 (paging.pageNo = 현재 페이지 넘버)    
		$(document).on("click", ".next" , function(){
			var page = ${paging.pageNo}+1;
			//.page 태그(페이징의 번호)가 1개 밖에 없을 경우(1페이지 밖에 없을 경우) prev, next 버튼으로 이동 제한
			if($(".page").size()==1){         
				return false;   
			}       
			location.href = "${pageContext.request.contextPath}/emp/empBonus.do?page="+page;
		})
		   
		$(document).on("mouseover", ".page", function(){
			$(this).css("background", "goldenrod");
		})
		$(document).on("mouseout", ".page", function(){  
			$(this).css("background", "#fff");
		})
		
		$(document).on("mouseover", ".prev", function(){
			$(this).css("background", "goldenrod");
		})
		
		$(document).on("mouseover", ".next", function(){
			$(this).css("background", "goldenrod");
		})
		
		$(document).on("mouseout", ".prev", function(){  
			$(this).css("background", "#fff");
		})
		
		$(document).on("mouseout", ".next", function(){  
			$(this).css("background", "#fff");        
		})
	  
		   
		   
   })


</script>
<body>
	<section>
	<h2 id="menuLocation">전체 실적 조회</h2>
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
		<div id="table">
		<span><i class="fas fa-exclamation-circle"></i></span><span id="guide">세부 내역을 조회하려면 사원을 클릭하세요.</span>
			<table class="tableList">
				<tr>
					<th>사원코드</th>
					<th>사원이름</th>
					<th>직책</th>
					<th>실적</th>
<!-- 					<th>인센티브</th>
					<th>상품 종류</th>
					<th class="thPlanName">상품 이름</th> -->
				

				</tr>
				<span id="renew">
				<c:forEach var='empList' items="${list }">
				<tr class="oneEmp" data-empCode="${empList.empCode }" data-perf="${empList.perf }">

					<td class="tdForRank"><span class="imgSpan"></span><span class="codeSpan">${empList.empCode }</span></td>

					<td>${empList.empName }</td>
					<td>${empList.empTitle }</td>
					<td>${empList.perf}</td>
<%-- 					<td><fmt:formatNumber value='${empList.bonus }' pattern='###,###,###'/></td>
					<td>${empList.pCode}</td>
					<td>${empList.pName }</td>	 --%>
				</tr>
	            </a>
				</c:forEach>
				</span>
		</table>
		<div class="sorter">   
		      <ul class="pagination">
		        <li><a href="#" class="prev">Prev</a></li>
		              <c:forEach var="i" begin="${paging.startPageNo}" end="${paging.endPageNo}" step="1">
		                  <c:choose>
		                      <c:when test="${i eq paging.pageNo}">
		                <li class="active"><a href="#" class="page">${i}</a></li>
		                      </c:when>
		                      <c:otherwise>
		                        <li><a href="#" class="page">${i}</a></li>
		                      </c:otherwise>
		                  </c:choose>
		              </c:forEach>
		        <li><a href="#" class="next">Next</a></li>
		      </ul>
		    </div> 
		</div>   
		</section>
</body>
</html>