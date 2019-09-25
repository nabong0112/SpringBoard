<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="image/MyMenuCSS.css" type="text/css">
<link rel="stylesheet" href="image/MenuStyleCSS.css" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>포켓몬고 게시판 메인</title>

<script type="text/javascript">
	function gowrite() { //글쓰기 버튼
		var bool = confirm('글을 작성하시겠습니까?');
		if (bool) {
			location.href = "write";
		} else {
			return false;
		}
	}
</script>
</head>
<body>
	<div id="container">
	<%@ include file ="include/header.jsp" %>
		<div id="content" style="background-color: #E3E3E3; height: 883px; width: 1900px; float: left;">
			<div id="menu" style="background-color: #E3E3E3; height: 883px; width: 145px; float: left;">
					<ul class="menu" style="padding-inline-start: 0px;">
						<li><a href="/bbs/TipBoard"> Tip 게시판</a></li>
						<li><a href="/bbs/QuestionBoard"> 질문 게시판</a></li>
						<li><a href="/bbs/FreeBoard"> 자유게시판</a></li>
					</ul>
			</div>
			<!-- ----------------------------------------------- 검색 하는곳 --------------------------------------------------------- -->
			<div id="searchForm" style="background-color: #EEEEEF; height: 130px;" align="center">
					<form action="search">
						<br> <b>게시글 검색 : </b> <select name="searchType" style="height: 23px;">
							<option value="0">공지사항</option>
							<option value="1">Tip게시판</option>
							<option value="2">질문게시판</option>
							<option value="3">자유게시판</option>
						</select> <input type="text" id ="searchName" name="searchName" size="40"
							placeholder="검색어를 입력하세요(내용+제목)"> <input type="submit" name="gosearch" size="20" value="검색"><br> <br>
					</form>
			</div>
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
							<td width="80"><a href="read?boardNo=${list.boardNo}&boardType=0">
								<c:out value='${j}'/></a></td>
							<td width="640"><a href="read?boardNo=${list.boardNo}&boardType=0">
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
			<!-- -----------------------------------------------검색 하는곳 끝 --------------------------------------------------------- -->
			
			<!-- ----------------------------------------------- 게시판 글 보여주는곳 --------------------------------------------------------- -->
			<%-- <div id="boardList" style="background-color: #EEEEEF; height: 733px; align-content: center;" align="center">
					<b>[공지사항 : ${listboard.size()} 개]
					</b><br>
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
							<c:set var='i' value='${i+1}'/>
							<tr align="center">
							<td width="80"><a href="/bbs/read?boardNo=${list.boardNo}"><c:out value='${listboard.size() - (i -1)}'/></a></td>
							<td width="640"><a href="/bbs/read?boardNo=${list.boardNo}"><c:out value='${list.boardTitle}'/></a></td>
							<td width="120"><c:out value='${list.boardUser}'/></td>
							<td width="180"><c:out value='${list.boardTime}'/></td>
							<td width="80"><c:out value='${list.boardCount}'/></td>
						</c:forEach>
						</c:when>
						<c:otherwise>
						 <tr align="center">
							<td colspan="5"><img src="image/Oh_sleep.gif" align="middle"><br>
							<b> 등록된 공지사항이 없습니다.</b></td>
						</tr>
						</c:otherwise>
						</c:choose>
					</table>
					<!-- ----------------------------------------------- 게시판 글 보여주는곳 끝--------------------------------------------------------- -->
					<div id="Page" align="center">
						<table>
							<tr>
								<%
									if (nowPage != 0) {
								%>
								<td align="center"><b>
								<a href="NoticeBoardServelet?nowPage=<%=nowPage - 1%>"> ◀ </a></b></td>

								<%
									}
									for (int Count = startPage; Count <= endPage; Count++) { //페이징 페이지 번호를 출력

										if (Count == nowPage) { //현재 페이지에는 굵은 표시
								%>

								<td align="center"><b>
								<a href="NoticeBoardServelet?nowPage=<%=Count%>">[<%=Count%>]</a></b></td>

								<%
									} else {
								%>
								<!-- 현재 페이지가 아닌 경우 아무표시 없음 -->

								<td align="center"><a
									href="NoticeBoardServelet?nowPage=<%=Count%>"><%=Count%></a></td>


								<%
									}

									}
								%>
								<%
									if (nowPage < totalPage) {
								%>
								<td align="center"><b><a
										href="NoticeBoardServelet?nowPage=<%=nowPage + 1%>"> ▶ </a></b></td>

								<%
									}
								%>



							</tr>
						</table>
					</div>
					<!-- ----------------------------------------------- 글 쓰러 가는곳 --------------------------------------------------------- -->
					<c:if test = "${sessionScope.userId != null}">
					<div id="gowrite" align="center">
						<br>
						<button id="myMenu" class="dropbtn" onclick="javascript:gowrite();">글쓰기</button>
					</div>
					</c:if>
					<!-- <input type="button" name="write" style="height: 50px; width: 100px;"  onClick= "javascript:write();">글쓰기</ -->
			</div> --%>
			</div>
		</div>
</body>
</html>