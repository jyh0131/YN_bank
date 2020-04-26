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
<link href="${pageContext.request.contextPath}/css/listCSS.css" rel="stylesheet" />
</head>
<script>

    
    function getAjaxData(ajaxPaging,ajaxKey){
    	
    	div = $("#searchMenu option:selected").val();
		search = $("input[name='search']").val();
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
        
    	 $.ajax({
			    url: "${pageContext.request.contextPath}/emp/empSearch.do",
			    type: "post", 
			    data: {"search":search,"div":div},
			    dataType: "json",
			    success : function(res){
			    	//console.log(res);
			    	if(res.error == "notExist"){   
			    		alert("해당 데이터가 존재하지 않습니다");
			    	}else{
			    		//console.log(res.employee);
			    		//console.log(ajaxKey);
			    		
			    		$(".tableList").remove();
			    		$table.append($menutr);
			    		$(ajaxKey).each(function(i,obj){
			    			var $tr = $("<tr class='oneEmp'>").attr("data-empCode",obj.empCode);
			    			var $td1 = $("<td>").html(obj.empCode);
			    			var $td2 = $("<td>").html(obj.empName);
			    			var $td3 = $("<td>").html(obj.empTitle);
			    			var $td4 = $("<td>").html(obj.empAuth);
			    			var $td5 = $("<td class='alright'>").html(obj.empSalary.toLocaleString());
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
			    		
			    		$(".sorter").remove();
			    		$divSorter = $("<div>").addClass("sorter");
			    		$ulPaging = $("<ul>").addClass("pagination");
			    		$liPaging1 = $("<li>");
			    		$aPaging1 = $("<a>").attr("href", "#").addClass("prev").html("Prev");
			    		
			    		$liPaging1.append($aPaging1);
			    		$ulPaging.append($liPaging1);
			    		
			    		
			    		for(var i=ajaxPaging.startPageNo; i<=ajaxPaging.endPageNo; i++){
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
			    		ajax = true;
			    	}
			    }
			  
		    })
    	
    }

   $(function(){
	   //전역변수
	   var ajax;
	   var div;
	   var search;
	   //선택한 메뉴 보이도록 설정 
	   $("#empAdd").show();
	   $("#empList").show();
	   //새로고침 수정
	  $("select").on("change",function(){
		  $(".tableList").load(location.href+" .tableList tr");
		  $("#searchForEmp").val("");
		  $(".pagination").load(location.href+" .pagination li");
	  })   
	  

        
        
	  $("button").eq(0).click(function(){
		
		    div = $("#searchMenu option:selected").val();
			search = $("input[name='search']").val();
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
					    	//console.log(res);
					    	if(res.error == "notExist"){   
					    		alert("해당 사원이 존재하지 않습니다.");
					    	}else{
					    		//console.log(res.employee);
					    	
				        getAjaxData(res.paging,res.employee);
			      }
			  } 
		  });
			  break; 
			case "사원이름":
					$.ajax({
					    url: "${pageContext.request.contextPath}/emp/empSearch.do",
					    type: "post", 
					    data: {"search":search,"div":div},
					    dataType: "json",
					    success : function(res){
					    	//console.log(res);
					    	if(res.error == "notExist"){   
					    		alert("조건을 만족하는 사원이 없습니다.");
					    	}else{
					    		//console.log(res.employee);
					    	
				        getAjaxData(res.paging,res.list);
			      }
			  } 
		  });
			  break;  
			case "부서(인사 or 고객)":
				$.ajax({
				    url: "${pageContext.request.contextPath}/emp/empSearch.do",
				    type: "post", 
				    data: {"search":search,"div":div},
				    dataType: "json",
				    success : function(res){
				    	//console.log(res);
				    	if(res.error == "notExist"){   
				    		console.log(res.error);
				    		alert("존재하지 않는 부서이거나 데이터가 존재하지 않습니다");
				    	}else{
				    		//console.log(res.employee);
				    	
			        getAjaxData(res.paging,res.list);
		          }
		       } 
		   });
			  break;  	
			case "직급":
				$.ajax({
				    url: "${pageContext.request.contextPath}/emp/empSearch.do",
				    type: "post", 
				    data: {"search":search,"div":div},
				    dataType: "json",
				    success : function(res){
				    	//console.log(res);
				    	if(res.error == "notExist"){   
				    		alert("존재하지 않는 직급이거나 해당 직급을 가진 사원이 없습니다.");
				    	}else{
				    		//console.log(res.employee);
				    	
			        getAjaxData(res.paging,res.list);
		       }
			}
	    });
			  break;
	 }
		  
	  }) //버튼 이벤트 끝나는 것 

	  
	  
	  //각 줄을 클릭할 때마다 내가 부여한 data-empCode를 받아오기 
	  $(document).on("click",".oneEmp",function(){
		  var OneCode = $(this).attr("data-empCode");
		  //alert(OneCode);
		  location.href="${pageContext.request.contextPath}/emp/empDetail.do?empCode="+OneCode;
	  })
	  

	  
	  //페이징 시작
	  //페이지 각 번호 클릭 시  
		$(document).on("click", ".page",function() {
			if(ajax) {
				var page = $(this).html();
				ajax = false;
		        location.href = "${pageContext.request.contextPath}/emp/empSearch.do?page="+page+"&search="+search+"&div="+div;
			}
			else {
				if(isPagingAjax) {
					var page = $(this).html();
					div = $("#searchMenu option:selected").val();
					search = $("input[name='search']").val();
					location.href = "${pageContext.request.contextPath}/emp/empSearch.do?page="+page+"&search="+search+"&div="+div;
				}
				else {
					var page = $(this).html();
			        location.href = "${pageContext.request.contextPath}/emp/empSearch.do?page="+page;
				}
			}
			
		})   
		
		//prev 클릭시 이전 번호로 돌아감 (paging.pageNo = 현재 페이지 넘버)
		$(document).on("click", ".prev" , function(){
			if(ajax) {
				var page = ${paging.pageNo}-1;
				//.page 태그(페이징의 번호)가 1개 밖에 없을 경우(1페이지 밖에 없을 경우) prev, next 버튼으로 이동 제한
				if($(".page").size()==1){
					return false;       
				}
				ajax = false;
				location.href = "${pageContext.request.contextPath}/emp/empSearch.do?page="+page+"&search="+search+"&div="+div;
			}
			else {
				if(isPagingAjax) {
					var page = ${paging.pageNo}-1;
					if($(".page").size()==1){
						return false;       
					}
					div = $("#searchMenu option:selected").val();
					search = $("input[name='search']").val();
					//.page 태그(페이징의 번호)가 1개 밖에 없을 경우(1페이지 밖에 없을 경우) prev, next 버튼으로 이동 제한
					location.href = "${pageContext.request.contextPath}/emp/empSearch.do?page="+page+"&search="+search+"&div="+div;
				}
				else {
					var page = ${paging.pageNo}-1;
					//.page 태그(페이징의 번호)가 1개 밖에 없을 경우(1페이지 밖에 없을 경우) prev, next 버튼으로 이동 제한
					if($(".page").size()==1){
						return false;       
					}
					location.href = "${pageContext.request.contextPath}/emp/empSearch.do?page="+page;
				}
			}
			
		})  
		//next 클릭시  다음 번호로 넘어감 (paging.pageNo = 현재 페이지 넘버)    
		$(document).on("click", ".next" , function(){
			if(ajax) {
				var page = ${paging.pageNo}+1;
				if($(".page").size()==1){         
					return false;   
				} 
				ajax = false;
				location.href = "${pageContext.request.contextPath}/emp/empSearch.do?page="+page+"&search="+search+"&div="+div;
			}
			else {
				if(isPagingAjax) {
					var page = ${paging.pageNo}+1;
					if($(".page").size()==1){         
						return false;   
					} 
					div = $("#searchMenu option:selected").val();
					search = $("input[name='search']").val();
					if($(".page").size()==1){         
						return false;   
					}
					location.href = "${pageContext.request.contextPath}/emp/empSearch.do?page="+page+"&search="+search+"&div="+div;
				}
				else {
					var page = ${paging.pageNo}+1;
					//.page 태그(페이징의 번호)가 1개 밖에 없을 경우(1페이지 밖에 없을 경우) prev, next 버튼으로 이동 제한
					if($(".page").size()==1){         
						return false;   
					}       
					location.href = "${pageContext.request.contextPath}/emp/empSearch.do?page="+page;
				}
			}
			
		})
		//페이징 끝
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
		var isPagingAjax = "${pagingAjax}"=="true"?true:false;
   });
</script>   
<body>   
	<section>
	<!-- paging c:if -->
	<c:if test="${pagingAjax=='true'}">
		<script>
			$(function(){
				var search = "${search}";
				var div = "${searchdiv}";
				$("#searchMenu option").each(function(i, obj) {
					if($(obj).val()==div) {
						$(obj).prop("selected",true);
					}
				})
				$("#searchForEmp").val(search);
			})
		</script>
	</c:if>
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
		<span id="coutOfEmp">인사팀  : ${HR }명 ,  고객팀 : ${CS }명</span>
		<span id="avgSalary"> 평균급여 : <fmt:formatNumber value="${avgSal}" pattern="###,###,###"/> 원</span>
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
				<c:forEach var='empList' items="${list}">
				<tr class="oneEmp" data-empCode="${empList.empCode }" >
					<td>${empList.empCode }</td>
					<td>${empList.empName }</td>
					<td>${empList.empTitle }</td>
					<td>${empList.empAuth }</td>
					<td class='alright'><fmt:formatNumber value='${empList.empSalary }' pattern='###,###,###'/></td>
					<td>${empList.empTel }</td>
					<td>${empList.empId }</td>
					<td>**********</td>
					<td>${empList.dept}</td>
					
				</tr>
	          
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
		<c:if test="${successed !=null}">
	    	<script>
	    		alert("${deletedEmp}님 퇴사처리 되었습니다.");
	    		<%
	    			session.removeAttribute("successed");
	    		    session.removeAttribute("deletedEmp");
	    		%>
	    	</script>
        </c:if>
        <c:if test="${successedForAdd !=null}">
	    	<script>
	    		alert("${addedEmp}님의 정보가 등록되었습니다.");
	    		<%
	    			session.removeAttribute("successedForAdd");
	    		    session.removeAttribute("addedEmp");
	    		%>
	    	</script>
        </c:if>
		</section>
</body>
</html>