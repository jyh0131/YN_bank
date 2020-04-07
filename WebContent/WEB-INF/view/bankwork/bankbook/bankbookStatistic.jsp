<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../include/menu.jsp"%>
<%@include file="../../include/sectionBar.jsp"%>
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
	div.table {
		width: 900px;
		margin: 30px auto;
	}
	section h1 {
		margin-left : 500px;
	}
	div#dummy { height: 75px; background: #292929;}
	.btnMenu {
		margin : 30px 0;
	}
	.btnMenu:first-child {
	   margin-left:400px;
	   width:150px;
	   border:2px solid goldenrod;
	   border-radius: 10px;
	   background: none;
	}
	.btnMenu:nth-child(2) {
	   margin-left: 50px;
	   width:150px;
	   border:2px solid goldenrod;
	   border-radius: 10px;
	   background: none;
	}	
	.btnMenu:hover {
	  background: goldenrod;
	  font-weight: bold;
}

  div#table th.thTel{
      width: 300px;
   }
</style>
<script>
   $(function(){
	   $("#transInfo").hide();
	   $(".btnMenu").click(function() {
			if($(this).html()=='통장 거래 내역') {
				$("#transInfo").toggle();
			}
		})
   })
</script>
<body>
	<section>
	<button class="btnMenu">통장 거래 내역</button>
	<button class="btnMenu">통장 정보</button>
	<div id="transInfo">
		<h1>휴면 계좌 조회</h1>
		<div class="table">
			<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	    	<script type="text/javascript">
			     google.charts.load('current', {'packages':['table']});
			     google.charts.setOnLoadCallback(drawTable);
			
			     function drawTable() {
			       var data = new google.visualization.DataTable();
			       data.addColumn('string', 'Name');
			       data.addColumn('number', 'Salary');
			       data.addRows([
			         ['Mike',  {v: 10000, f: '$10,000'}],
			         ['Jim',   {v:8000,   f: '$8,000'}],
			         ['Alice', {v: 12500, f: '$12,500'}],
			         ['Bob',   {v: 7000,  f: '$7,000'}]
			       ]);
			
			       var table = new google.visualization.Table(document.getElementsByClassName('table')[0]);
			
			       table.draw(data, {showRowNumber: true, width: '100%', height: '20%'});
			     }
	    	</script>
		</div>
		<h1>해지 계좌 조회</h1>
		<div class="table">
			<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	    	<script type="text/javascript">
			     google.charts.load('current', {'packages':['table']});
			     google.charts.setOnLoadCallback(drawTable);
			
			     function drawTable() {
			       var data = new google.visualization.DataTable();
			       data.addColumn('string', 'Name');
			       data.addColumn('number', 'Salary');
			       data.addRows([
			         ['Mike',  {v: 10000, f: '$10,000'}],
			         ['Jim',   {v:8000,   f: '$8,000'}],
			         ['Alice', {v: 12500, f: '$12,500'}],
			         ['Bob',   {v: 7000,  f: '$7,000'}]
			       ]);
			
			       var table = new google.visualization.Table(document.getElementsByClassName('table')[1]);
			
			       table.draw(data, {showRowNumber: true, width: '100%', height: '20%'});
			     }
	    	</script>
		</div>
	</div>
	</section>
</body>
</html>