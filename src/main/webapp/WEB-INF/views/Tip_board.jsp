<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="image/MyMenuCSS.css" type="text/css">
<link rel="stylesheet" href="image/MenuStyleCSS.css" type="text/css">
<style type="text/css">
li.Tip {
	color: white;
	background-color: #1E90FF;
}
</style>
<!-- 자바스크립트 -->
<script type="text/javascript">
	function gowrite() { //글쓰기 버튼
		var bool = confirm('글을 작성하시겠습니까?');
		if (bool) {
			location.href = "wirte";
		} else {
			return false;
		}
	}
</script>
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
</script>
<script type="text/javascript">
	function logout() { //로그아웃 버튼
		var form = document.logout;
		var bool = confirm('로그아웃 하시겠습니까?');
		if (bool) {
			alert("안녕히가세요!");
			location.href = "main";
		} else {
			return false;
		}
	}
</script>
<!-- 자바스크립트 끝 -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>포켓몬고 Tip게시판</title>
</head>
<body>
	<div id="container">
		<%@ include file="include/header.jsp"%>
		<div id="content"
			style="background-color: #E3E3E3; height: 883px; width: 1900px; float: left;">
			<%@ include file="include/menu.jsp"%>
			<div id="boardName">
				<p style="display: inline;">Tip 게시판</p>
				<button id="myMenu" class="dropbtn" onclick="javascript:gowrite();">글쓰기</button>
			</div>
			<div id="bestTip">
				<h2 align="center">금주의 베스트 글</h2>
				<table style="line-height: 2.3em;" align="center">
					<tr align="center" bgcolor="gray">
						<th width="80"><b>번호</b></th>
						<th width="640"><b>제목</b></th>
						<th width="120"><b>작성자</b></th>
						<th width="180"><b>작성 일자</b></th>
						<th width="80"><b>조회수</b></th>
					</tr>
					<c:choose>
						<c:when test="${bestboard.size() != 0}">

							<c:forEach items='${bestboard}' var='list'>
								<c:set var='i' value='${i+1}' />
								<tr align="center">
									<td width="80"><a href="read?boardNo=${list.boardNo}&boardType=1"><c:out
												value='${i}' /></a></td>
									<td width="640"><a href="read?boardNo=${list.boardNo}&boardType=1"><c:out
												value='${list.boardTitle}' /></a></td>
									<td width="120"><c:out value='${list.boardUser}' /></td>
									<td width="180"><c:out value='${list.boardTime}' /></td>
									<td width="80"><c:out value='${list.boardCount}' /></td>
								</tr>
							</c:forEach>

						</c:when>
						<c:otherwise>
							<tr align="center">
								<td colspan="5"><img src="image/Oh_sleep.gif"
									align="middle"><br> <b> 베스트 글이 없습니다.</b></td>
							</tr>
						</c:otherwise>
					</c:choose>
				</table>
				<br>
				<br>
			</div>
			<!-- ----------------------------------------------- 게시판 글 보여주는곳 --------------------------------------------------------- -->
			<div id="boardlist"
		style="background-color: #EEEEEF; height: 733px; align-content: center;"
		align="center">
		<b>[총 갯수 : ${listboard.size()} 개] </b><br>
		<table style="line-height: 2.3em;" draggable="true">
			<tr align="center" bgcolor="gray">
				<th width="80"><b>번호</b></th>
				<th width="640"><b>제목</b></th>
				<th width="120"><b>작성자</b></th>
				<th width="180"><b>작성 일자</b></th>
				<th width="80"><b>조회수</b></th>
			</tr>
			<c:choose>
				 <c:when test="${listboard.size() != 0}">
						
						<c:forEach items='${listboard}' var='list'>
						<c:set var='j' value='${j+1}' />
						<tr align="center">
							<td width="80"><a href="read?boardNo=${list.boardNo}&boardType=1">
								<c:out value='${j}'/></a></td>
							<td width="640"><a href="read?boardNo=${list.boardNo}&boardType=1">
								<c:out value='${list.boardTitle}' /></a></td>
							<td width="120"><c:out value='${list.boardUser}' /></td>
							<td width="180"><c:out value='${list.boardTime}' /></td>
							<td width="80"><c:out value='${list.boardCount}' /></td>
						</tr>
						</c:forEach>
						
				</c:when>
				<c:otherwise> 
					<tr align="center">
						<td colspan="5"><img src="image/Oh_sleep.gif" align="middle"><br>
							<b> 등록된 글이 없습니다.</b></td>
					</tr>
				</c:otherwise>
			</c:choose>
		</table>
		<c:if test="${sessionScope.userId != null}">
			<div id="gowrite" align="center">
				<br>
				<button id="myMenu" class="dropbtn" onclick="javascript:gowrite();">글쓰기</button>
			</div>
		</c:if>
		<!-- <input type="button" name="write" style="height: 50px; width: 100px;"  onClick= "javascript:write();">글쓰기</ -->
	</div>
		</div>
		<!-- content div 끝 -->
	</div>
</body>
</html>