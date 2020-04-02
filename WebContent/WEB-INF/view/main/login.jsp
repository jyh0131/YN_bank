<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
* {
	padding: 0;
	margin: 0;
}

#container {
	width: 652px;
	margin: 0 auto;
	margin-top: 70px;
}

#mainLogo2 {
	
}

form {
	width: 652px;
	height: 378px;
	border: 0px solid gray;
	background: url("${pageContext.request.contextPath}/images/loginMain.jpg") no-repeat;
	background-size: contain;
	position: relative;
}

label {
	float: left;
	width: 100px;
	font-weight: bold;
	font-size: 17px;
}

fieldset {
	width: 400px;
	height: 100px;
	margin-left: 110px;
	padding: 20px;
	background: rgba(213, 213, 213, 0.4);
	border-radius: 10px;
	position: absolute;
	top: 110px;
}

fieldset input {
	height: 30px;
}

fieldset p {
	margin-bottom: 10px;
}

fieldset div {
	width: 190px;
}

fieldset div#loginDiv1 {
	float: left;
	width: 300px;
	margin-top: 10px;
}

fieldset div#loginDiv2 {
	float: left;
	width: 50px;
}

#btnLogin {
	width: 100px;
	height: 80px;
	margin-top: 10px;
	background: goldenrod;
}

#bottomColor {
	height: 80px;
	width: 647px;
	background: goldenrod;
}
</style>
</head>
<body>
	<div id="container">
		<!--    <img src="images/bank.png" id="mainLogo"> -->
		<img src="${pageContext.request.contextPath}/images/Logo.png" id="mainLogo2">
		<form>
			<fieldset>
				<div id="loginDiv1">
					<p>
						<label>Id </label><input type="text" name="id">
					</p>
					<p>
						<label>Password</label> <input type="password" name="password">
					</p>
				</div>
				<div id="loginDiv2">
					<input type="submit" value="Login" id="btnLogin">
				</div>
			</fieldset>

		</form>
		<div id="bottomColor"></div>

		<!--    <img src="images/banner.jpg" id="bottomLogo"> -->

	</div>
</body>
</html>