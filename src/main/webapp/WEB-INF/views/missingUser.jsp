<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>계정 찾기</title>
<link rel="stylesheet" href="image/MyMenuCSS.css" type="text/css">
<link rel="stylesheet" href="image/MenuStyleCSS.css" type="text/css">
</head>
<body>
<form name="find" method="post" action="findUserCheck">
	<div align = "center" style="line-height: 2.3em">
		<fieldset style="width: 300px">
				<legend>아이디와 비밀번호 찾기</legend>
				<label for="userIdQustion">질문 : </label> 
				<input type="text" size="30" id="userIdQustion" name="userIdQustion"><br> 
					<label for="userIdAnswer">답 :</label> 
					<input type="text" size="30" id="userIdAnswer" name="userIdAnswer"><br>
					<input type="submit" name="find" value="   찾기   ">
					<c:if test ="${msg eq 'noQuestion'}">
						<br><p style="color: red">해당하는 계정이 없습니다! 다시확인해주세요</p>
					</c:if>
					<c:if test ="${msg eq 'yesQuestion'}">
						<br><p style="color: blue">당신의 아이디는 <c:out value="${find.userId}"></c:out>
						<br>비밀번호는 <c:out value="${find.userPw}"></c:out>입니다!</p>
					</c:if>
					<br><input type="button" class="dropbtn" name="myPage" value="뒤로가기" onclick="javascript:back();"> 
				<script type="text/javascript">
					
					function back(){
						location.href = "write";
					}
					
					function logincheck() {
						var form = document.login;

						if (!form['userId'].value) {
							alert("어!! 아이디를 빼먹으셨네!");
							form['userId'].focus();
							return false;
						} else if (!form['userPw'].value) {
							alert("어!! 비밀번호를 빼먹으셨네!");
							form['userPw'].focus();
							return false;
						} else {

							form.submit();
						}
					}
				</script>
			</fieldset>
			</div>
	</form>
</body>
</html>