<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
		<%@ include file="include/header.jsp"%>
		<div id="content"
			style="background-color: #E3E3E3; height: 883px; width: 1900px; float: left;">
			<div id="menu"
				style="background-color: #E3E3E3; height: 883px; width: 145px; float: left;">
				<ul class="menu" style="padding-inline-start: 0px;">
					<li><a href="/bbs/TipBoard"> Tip 게시판</a></li>
					<li><a href="/bbs/QuestionBoard"> 질문 게시판</a></li>
					<li><a href="/bbs/FreeBoard"> 자유게시판</a></li>
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

							<c:forEach items='${listboard}' var='list'
							begin="${page.startWriting -1}" end="${page.endWriting -1}">
								<c:set var='j' value='${j+1}' />
								<tr align="center">
									<td width="80"><a
										href="read?boardNo=${list.boardNo}&boardType=0"> <c:out
												value='${page.startWriting + j - 1}' /></a></td>
									<td width="640"><a
										href="read?boardNo=${list.boardNo}&boardType=0"> <c:out
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
									align="middle"><br> <b> 등록된 글이 없습니다.</b></td>
							</tr>
						</c:otherwise>
					</c:choose>
				</table>
				<c:if test="${sessionScope.userId != null}">
					<div id="gowrite" align="center">
						<br>
						<button id="myMenu" class="dropbtn"
							onclick="javascript:gowrite();">글쓰기</button>
					</div>
				</c:if>		
				<!-- 페이징 게시글 수 : 120개 총 페이지 수 : ((총 게시글 수 - 1) / 보여줄 페이지 수) + 1 > ((120 - 1) / 7) + 1 = 18
				18 * 7 = 126 그럼 마지막장에는 네개
				1. 한페이지에 몇개의 글을 보여줄건가 : 5개
				2. 총 몇개의 페이지를 보여줄것인가 : 7개
				3. 그러면 << 2 3 4 5 6 7 8 >> << 3 4 5 6 7 8 9 >>이런식 
				4. 시작페이지는 ((현재 보고있는 페이지 번호 -1)/ 보여줄 페이지 수) * 보여줄 페이지 수 + 1 
				5. 그러면 만약내가 3페이지를 보고있으면 시작페이지는 ((3 - 1)/7)* 7 + 1 = 3
				6. 그러면 만약내가 1페이지를 보고있으면 시작페이지는 ((1 - 1)/7)* 7 + 1 = 1 
				7. 마지막 번호는 시작페이지 + 페이지 총 사이즈 - 1 
				8. 그러면 3페이지에서 마지막 번호는 3 + 7 - 1 = 9번 
				9. 만약 총 페이지 수가 5이면 3 + 5 - 1 = 7번 
				10. <<는 1페이지가 아닐때면 죄다 나와야됨 >>는 총 페이지 수(= 18)일때 보이면안됨 
				11. 현재 페이지 번호 * 보여줄 페이지 사이즈 하면 마지막 글의 번호가 나옴
				12. 그러면 1페이지에 있고 보여줄 페이지 사이즈가 7개니까 마지막 글의 번호는 1 * 5 = 5번까지
				13. 여기서 총 페이지 사이즈를 빼면 시작번호니까 5 - 5 = 0번부터 5번까지 
				14. 
				-->
				<c:if test="${page.startPage != curPage}">
					<a href="main?curPage=${page.startPage}">처음으로</a>
				</c:if>
				<c:forEach var='i' begin="${page.startPage}" end="${page.endPage}">
						<c:choose>
						<c:when test="${ i == curPage }">
							<b><c:out value="${i}"/></b>
						</c:when>
						<c:otherwise>
						<a href="main?curPage=${i}"><c:out value="${i}"/></a>
						</c:otherwise>
						</c:choose>
					</c:forEach>
				<c:if test="${page.endPage != curPage}">
					<a href="main?curPage=${page.endPage}">끝으로</a>
				</c:if>
			</div>
		</div>
	</div>
</body>
</html>