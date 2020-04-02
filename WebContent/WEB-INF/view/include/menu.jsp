<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="https://fonts.googleapis.com/css2?family=Kanit:wght@800&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	nav div#logo h1 { padding: 15px; font-size: 30px; 
				      font-family: 'Kanit', sans-serif;
				      color: whitesmoke; text-shadow: 2px 2px 2px gray;}
	nav div#staff { height: 20%; background: goldenrod; }
	nav div#staff ul li { float: left; list-style: none; }
	nav div#staff ul li:first-child {
						  width: 120px; height: 120px; 
						  overflow: hidden; 
						  padding: 10px; 
						  }
	/* 프로필 영역  */
	nav div#staff ul li#greeting { width: 80px; 
								   margin: 50px 10px 10px 25px; 
								   text-align: center;}
	nav div#staff ul li#btns { width:150px; margin: 30px 5px 5px 5px; }	
	nav div#staff ul li#btns a { font-size: 14px; color: #000;
								 display: block; float: left;
								 padding-left: 5px; }	
	nav div#staff ul li#btns a:first-child {padding-right: 5px; border-right: 1px solid gray;}												  
	nav div#staff ul li span#name { font-weight: bold;}																		 
	nav div#staff ul li img { width: 120px; height: 120px; 
				margin: 10px; border-radius: 120px; }
	
	
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
			<h1>YN BANK</h1>
		</div>
		<div id="staff">
			<ul>
				<li><img src="${pageContext.request.contextPath}/images/staff1.jpg"></li>
				<li id="greeting"><span id="name">이주빈 </span>님 환영합니다.</li>
				<li id="btns">
					<a href="#">내 프로필</a>
					<a href="#">로그아웃</a>
				</li>
			</ul>
		</div>
		<div id="menu">
			<ul>
				<li id="menuTitle">Menu</li>
				<li id="emp" class="side1"><a href="#">사원 관리</a></li>
				<li id="add" class="side2"><a href="#">신규 사원 추가</a></li>
				<li id="list" class="side2"><a href="#">사원 목록</a></li>
				<li id="auth" class="side1"><a href="#">사원 권한 관리</a></li>
				<li id="authAdd" class="side2"><a href="#">사원 권한 추가</a></li>
				<li id="bonus" class="side1"><a href="#">인센티브</a></li>
				<li id="authAdd" class="side2"><a href="#">인센티브 조회</a></li>
				<li id="authAdd" class="side1"><a href="#">통계</a></li>
			</ul>
			
		</div>
	</nav>
</body>