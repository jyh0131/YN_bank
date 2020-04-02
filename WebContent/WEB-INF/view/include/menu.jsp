<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link href="https://fonts.googleapis.com/css2?family=Kanit:wght@800&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script>
	$(function(){
		if(${Auth.empAuth=='AD'}) {
			$("#staff").css({"height":"10%","background":"goldenrod"});
			$("#staff ul li").css({"float":"left","list-style":"none"});
			$("#greeting").css({"width":"200px","margin":"15px 10px 10px 45px","text-align":"center"});
			$("#btns").css({"width":"150px","margin":"10px 5px 5px 70px","clear":"both"});
			$("#btns a").css({"font-size":"14px","color":"#000"});
			$("#btns a").eq(0).css({"padding-right":"5px","border-right":"1px solid grey"});
			$("#name").css("font-weight","bold");
			$("#staff ul li img").css({"width":"120px","height":"120px","margin":"10px","border-radius":"120px"});
		}
		else {
			$("#staff").css({"height":"20%","background":"goldenrod"});
			$("#staff ul li").css({"float":"left","list-style":"none"});
			$("#staff ul li").eq(0).css({"width":"120px","height":"120px","overflow":"hidden","padding":"10px"});
			$("#greeting").css({"width":"80px","margin":"50px 10px 10px 25px","text-align":"center"});
			$("#btns").css({"width":"150px","margin":"30px 5px 5px 5px"});
			$("#btns a").css({"font-size":"14px","color":"#000"});
			$("#btns a").eq(0).css({"padding-right":"5px","border-right":"1px solid grey"});
			$("#name").css("font-weight","bold");
			$("#staff ul li img").css({"width":"120px","height":"120px","margin":"10px","border-radius":"120px"});
		}
		$("#empMgn").click(function() {
			$("#empAdd").toggle();
			$("#empList").toggle();
		})
		$("#empAuth").click(function() {
			$("#empAuthAdd").toggle();
		})
		$("#empBonus").click(function() {
			$("#empBonusList").toggle();
		})
		$("#custMgn").click(function() {
			$("#custAdd").toggle();
			$("#custList").toggle();
		})
		$("#dwMgn").click(function() {
			$("#dwList").toggle();
		})
		$("#bankbookMgn").click(function() {
			$("#bankbookAdd").toggle();
			$("#bankbookList").toggle();
		})
		$("#cardMgn").click(function() {
			$("#cardAdd").toggle();
			$("#cardList").toggle();
		})
		$("#loanMgn").click(function() {
			$("#loanAdd").toggle();
			$("#loanList").toggle();
		})
		$("#planMgn").click(function() {
			$("#planAdd").toggle();
			$("#planList").toggle();
		})
		$("#custStatistic").click(function() {
			$("#custStatistic2").toggle();
			$("#bankworkStatistic").toggle();
		})
		$("#statistic").click(function() {
			$("#empStatistic").toggle();
			$("#custStatistic").toggle();
			$("#bankworkStatistic").toggle();
		})
		$(".side2").hide();
	});
</script>
<style>
	* { margin: 0; padding: 0; /* font-family: 'Noto Serif KR', serif; */font-family: 'Noto Sans KR', sans-serif;}
	body { min-width: 1900px;  }
	ul li { list-style: none; }
	a { text-decoration: none; color: #000; }
	nav { width: 300px; height: 100%;  
		  background: #292929;
		  position: absolute; top:0; left: 0;
		  }
	nav div#logo { background: #292929; }
	nav div#logo h1 { padding: 15px; font-size: 30px;}
	nav div#logo h1 a {font-family: 'Kanit', sans-serif;
				      color: whitesmoke; text-shadow: 2px 2px 2px gray;}

	
	/* 메뉴 */
	nav div#menu li { height: 40px;
					  line-height: 40px; 
					  
					  text-indent: 20px; }
	nav div#menu li#menuTitle { height: 40px; 
								color: gainsboro;
								background: #000;   }
	
	nav div#menu li.side1 { text-indent: 40px; }
	nav div#menu li.side2 {  text-indent:60px;
							background: #464646;
							border-top: 1px solid gray;
							border-bottom: 1px solid gray;}
	
	nav div#menu a {  color: gainsboro;
				     display: block;  }
				     
	section div#dummy { height: 75px; background: #292929;}						    
</style>
<body>
	<nav>
		<div id="logo">
			<h1><a href="${pageContext.request.contextPath}/main/main.do">YN BANK</a></h1>
		</div>
		<div id="staff">
			<ul>
				<c:if test="${Auth.empAuth!='AD'}">
				<li><img src="${pageContext.request.contextPath}/images/staff1.jpg"></li>
				</c:if>
				<li id="greeting"><span id="name">${Auth.empName} </span>님 환영합니다.</li>
				<li id="btns">
					<a href="#">내 프로필</a>
					<a href="${pageContext.request.contextPath}/main/logout.do">로그아웃</a>
				</li>
			</ul>
		</div>
		<div id="menu">
			<ul>
				<li id="menuTitle">Menu</li>
				<c:if test="${Auth.empAuth=='HR'}"> <!-- 인사팀일때 -->
					<li id="empMgn" class="side1"><a href="#">사원 관리</a>
					<li id="empAdd" class="side2"><a href="#">신규 사원 추가</a></li>
					<li id="empList" class="side2"><a href="#">사원 목록</a></li>
					<li id="empAuth" class="side1"><a href="#">사원 권한 관리</a></li>
					<li id="empAuthAdd" class="side2"><a href="#">사원 권한 추가</a></li>
					<li id="empBonus" class="side1"><a href="#">인센티브</a></li>
					<li id="empBonusList" class="side2"><a href="#">인센티브 조회</a></li>
					<li id="empStatistic" class="side1"><a href="#">통계</a></li>
				</c:if>
				<c:if test="${Auth.empAuth=='CS'}"> <!-- 고객팀일때 -->
					<li id="custMgn" class="side1"><a href="#">고객 관리</a></li>
					<li id="custAdd" class="side2"><a href="#">신규 고객 추가</a></li>
					<li id="custList" class="side2"><a href="#">고객 조회</a></li>
					<li id="dwMgn" class="side1"><a href="#">입출금 관리</a></li>
					<li id="dwList" class="side2"><a href="#">입출금 조회</a></li>
					<li id="bankbookMgn" class="side1"><a href="#">통장 관리</a></li>
					<li id="bankbookAdd" class="side2"><a href="${pageContext.request.contextPath}/bankwork/bankbook/add.do">통장 추가</a></li>
					<li id="bankbookList" class="side2"><a href="${pageContext.request.contextPath}/bankwork/bankbook/mgn.do">통장 조회</a></li>
					<li id="cardMgn" class="side1"><a href="#">카드 관리</a></li>
					<li id="cardAdd" class="side2"><a href="#">카드 추가</a></li>
					<li id="cardList" class="side2"><a href="${pageContext.request.contextPath}/bankwork/card/mgn.do">카드 조회</a></li>
					<li id="loanMgn" class="side1"><a href="#">대출 관리</a></li>
					<li id="loanAdd" class="side2"><a href="#">대출 추가</a></li>
					<li id="loanList" class="side2"><a href="${pageContext.request.contextPath}/bankwork/loan/mgn.do">대출 조회</a></li>
					<li id="planMgn" class="side1"><a href="#">상품 관리</a></li>
					<li id="planAdd" class="side2"><a href="#">상품 추가</a></li>
					<li id="planList" class="side2"><a href="#">상품 조회</a></li>
					<li id="custStatistic" class="side1"><a href="#">통계</a></li>	
					<li id="custStatistic2" class="side2"><a href="#">고객 통계</a></li>
					<li id="bankworkStatistic" class="side2"><a href="#">은행 업무 통계</a></li>
				</c:if>
				<c:if test="${Auth.empAuth=='AD'}"> <!-- 관리자일때 -->
					<li id="empMgn" class="side1"><a href="#">사원 관리</a></li>
					<li id="empAdd" class="side2"><a href="#">신규 사원 추가</a></li>
					<li id="empList" class="side2"><a href="#">사원 목록</a></li>
					<li id="empAuth" class="side1"><a href="#">사원 권한 관리</a></li>
					<li id="empAuthAdd" class="side2"><a href="#">사원 권한 추가</a></li>
					<li id="empBonus" class="side1"><a href="#">인센티브</a></li>
					<li id="empBonusList" class="side2"><a href="#">인센티브 조회</a></li>
					<li id="custMgn" class="side1"><a href="#">고객 관리</a></li>
					<li id="custAdd" class="side2"><a href="#">신규 고객 추가</a></li>
					<li id="custList" class="side2"><a href="#">고객 조회</a></li>
					<li id="dwMgn" class="side1"><a href="#">입출금 관리</a></li>
					<li id="dwList" class="side2"><a href="#">입출금 조회</a></li>
					<li id="bankbookMgn" class="side1"><a href="#">통장 관리</a></li>
					<li id="bankbookAdd" class="side2"><a href="${pageContext.request.contextPath}/bankwork/bankbook/add.do">통장 추가</a></li>
					<li id="bankbookList" class="side2"><a href="${pageContext.request.contextPath}/bankwork/bankbook/mgn.do">통장 조회</a></li>
					<li id="cardMgn" class="side1"><a href="#">카드 관리</a></li>
					<li id="cardAdd" class="side2"><a href="#">카드 추가</a></li>
					<li id="cardList" class="side2"><a href="${pageContext.request.contextPath}/bankwork/card/mgn.do">카드 조회</a></li>
					<li id="loanMgn" class="side1"><a href="#">대출 관리</a></li>
					<li id="loanAdd" class="side2"><a href="#">대출 추가</a></li>
					<li id="loanList" class="side2"><a href="${pageContext.request.contextPath}/bankwork/loan/mgn.do">대출 조회</a></li>
					<li id="planMgn" class="side1"><a href="#">상품 관리</a></li>
					<li id="planAdd" class="side2"><a href="#">상품 추가</a></li>
					<li id="planList" class="side2"><a href="#">상품 조회</a></li>
					<li id="statistic" class="side1"><a href="#">통계</a></li>
					<li id="empStatistic" class="side2"><a href="#">사원 통계</a></li>	
					<li id="custStatistic" class="side2"><a href="#">고객 통계</a></li>
					<li id="bankworkStatistic" class="side2"><a href="#">은행 업무 통계</a></li>
				</c:if>
			</ul>	
		</div>
	</nav>
</body>