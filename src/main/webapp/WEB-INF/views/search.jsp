<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="image/MyMenuCSS.css" type="text/css">
<link rel="stylesheet" href="image/MenuStyleCSS.css" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>검색 결과</title>

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
		<%@ include file="include/header.jsp"%>
		<div id="content"
			style="background-color: #E3E3E3; height: 883px; width: 1900px; float: left;">
			<div id="menu"
				style="background-color: #E3E3E3; height: 883px; width: 145px; float: left;">
				<ul class="menu" style="padding-inline-start: 0px;">
					<li><a href="TipBoard"> Tip 게시판</a></li>
					<li><a href="QuestionBoard"> 질문 게시판</a></li>
					<li><a href="FreeBoard"> 자유게시판</a></li>
				</ul>
			</div>
			<!-- ----------------------------------------------- 검색 하는곳 --------------------------------------------------------- -->
			<div id="searchForm"
				style="background-color: #EEEEEF; height: 130px;" align="center">
				<form action="search">
					<br> <b>게시글 검색 : </b> <select name="searchType"
						style="height: 23px;">
						<option value="0">공지사항</option>
						<option value="1">Tip게시판</option>
						<option value="2">질문게시판</option>
						<option value="3">자유게시판</option>
					</select> <input type="text" id="searchName" name="searchName" size="40"
						placeholder="검색어를 입력하세요(내용+제목)"> <input type="submit"
						name="gosearch" size="20" value="검색"><br> <br>
				</form>
			</div>
			<div id="boardlist"
				style="background-color: #EEEEEF; height: 733px; align-content: center;"
				align="center">
				<b>[검색 결과 : ${searchList.size()} 개] </b><br>
				<table style="line-height: 2.3em;" draggable="true">
					<tr align="center" bgcolor="gray">
						<th width="80"><b>번호</b></th>
						<th width="640"><b>제목</b></th>
						<th width="120"><b>작성자</b></th>
						<th width="180"><b>작성 일자</b></th>
						<th width="80"><b>조회수</b></th>
					</tr>
					<c:choose>
						<c:when test="${searchList.size() != 0}">

							<c:forEach items='${searchList}' var='list'
								begin="${page.startWriting}" end="${page.endWriting}">
								<c:set var='i' value='${i+1}' />
								<tr align="center">
									<td width="80"><a
										href="read?boardNo=${list.boardNo}&boardType=${searchType}"><c:out
												value='${searchList.size() - (i -1)}' /></a></td>
									<td width="640"><a
										href="read?boardNo=${list.boardNo}&boardType=${searchType}"><c:out
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
									align="middle"><br> <b> 검색된 글이 없습니다!</b></td>
							</tr>
						</c:otherwise>
					</c:choose>
				</table>
				<div id="gowrite" align="center">
					<c:if test="${sessionScope.userId != null}">
						<br>
						<button id="myMenu" class="dropbtn"
							onclick="javascript:gowrite();">글쓰기</button>
					</c:if>
					<button id="myMenu" class="dropbtn" onclick="history.back();">뒤로가기</button>
				</div>
				<div align="center">
					<%-- <c:if test="${page.isPre ne true}"><!-- 마지막 페이지 - 7 -->
				<a href="main?PageNum=${page.endPage + page.pageSize}">이전페이지</a>	
				</c:if> --%>
					<c:forEach var='i' begin="${page.startPage}" end="${page.endPage}">
						<c:choose>
						<c:when test="${ i == curPage }">
							<b><c:out value="${i}"/></b>
						</c:when>
						<c:otherwise>
						<a href="search?searchType=0&searchName=d&curPage=${i}"><c:out value="${i}"/></a>
						</c:otherwise>
						</c:choose>
					</c:forEach>
					<%--  <c:if test="${page.isNext}"><!-- 시작페이지 + 7 -->
				<a href="main?PageNum=${page.startPage + page.pageSize}">다음페이지</a>	
				</c:if>  --%>
				</div>
			</div>
			<!-- -----------------------------------------------검색 하는곳 끝 --------------------------------------------------------- -->

			<!-- ----------------------------------------------- 게시판 글 보여주는곳 --------------------------------------------------------- -->
		</div>
	</div>
</body>
</html>