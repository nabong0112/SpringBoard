<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원정보</title>
<link rel="stylesheet" href="image/MyMenuCSS.css" type="text/css">
<link rel="stylesheet" href="image/MenuStyleCSS.css" type="text/css">
</head>
<body>
	<div id="container">
		<%@ include file="include/header.jsp"%>
		<div id="content"
			style="background-color: #E3E3E3; height: 883px; width: 1900px; float: left;">
			<%@ include file="include/menu.jsp"%>
			<div align="center">
				<c:choose>
					<c:when test="${info.userJender == 'Male'}">
						<img alt="#" src="image/my_Page_Img.png">
					</c:when>
					<c:otherwise>
						<img alt="#" src="image/my_Page_Img_girl.png">
					</c:otherwise>
				</c:choose>
				<p>가입한 날짜 : ${info.joinTime}</p>
				<p>내 아이디 : ${info.userId}</p>
				<p>내 비밀번호 : ${info.userPw}</p>
				<p>내 이름 : ${info.userName}</p>
				<p>성별 : ${info.userJender}</p>
				<p>질문 : ${info.userIdQustion}</p>
				<p>답 : ${info.userIdAnswer}</p>
				
				<input type="button" class="dropbtn" name="myPage" value="수정하기(미구현)" onclick="history.back();"> 
				<input type="button" class="dropbtn" name="myPage" value="탈퇴하기(미구현)" onclick="history.back();">
				<input type="button" class="dropbtn" name="myPage" value="뒤로가기" onclick="history.back();"> 
				<input type="button" class="dropbtn" name="myPage" value="메인으로" onclick="history.back();">
				</div>
			</div>
		</div>
</body>
</html>