<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> </title>
<link rel="stylesheet" href="image/MyMenuCSS.css" type="text/css">
<link rel="stylesheet" href="image/MenuStyleCSS.css" type="text/css">
<script type="text/javascript">
function login() { //로그인 버튼
		var form = document.login;
		var bool = confirm('로그인 하시겠습니까?');
		if (bool) {
			location.href = "login";
		} else {
			return false;
		}
	}

	function logout() { //로그아웃 버튼
		var form = document.logout;
		var bool = confirm('로그아웃 하시겠습니까?');
		if (bool) {
			alert("안녕히가세요!");
			location.href = "logout";
		} else {
			return false;
		}
	}
	function myPage() { //내 정보 버튼
		var form = document.myPage;
			location.href = "userInfo";
	}
	</script>
</head>
<body>
<div id="header" style="height: 150px; text-align: right;">
			<a href="/bbs/main"><img src="image/Oh_main.gif" width="200px"
				height="150px" align="left"></a>
			<c:choose>
				<c:when test="${sessionScope.userId == null}">
				<b>로그인해주세요!</b> <input type="button" class="dropbtn" name="login" value="로그인" onclick="javascript:login();">
				</c:when>
				<c:otherwise>
					<b>회원 ${sessionScope.userId}</b>님 안녕하세요! 
			<input type="button" class="dropbtn" name="myPage" value="내 정보" onclick="javascript:myPage();"> 
			<input type="button" class="dropbtn" name="logout" value="로그아웃" onclick="javascript:logout();">
				</c:otherwise>
			</c:choose>
		</div>
			<%-- <c:if test="${msg == OK }">
				<b>회원 ${sessionScope.userId} </b>님 안녕하세요! 
			<input type="button" class="dropbtn" name="myPage" value="내 정보" onclick="javascript:myPage();"> 
			<input type="button" class="dropbtn" name="logout" value="로그아웃" onclick="javascript:logout();">
			</c:if>
			<c:if test="${msg == logout || empty msg }">
					<b>로그인해주세요!</b> <input type="button" class="dropbtn" name="login" value="로그인" onclick="javascript:login();">
			</c:if> --%>
</body>
</html>