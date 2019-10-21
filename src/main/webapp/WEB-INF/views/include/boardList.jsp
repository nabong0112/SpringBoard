<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%
	int nowPage = 0;
	if (request.getParameter("nowPage") != null) {
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	} else {
		nowPage = 1;
	}
	int countPage = 5; //한번에 출력될 페이지 수
	int totalCount = 9;/*board.size();*/ //총 게시글 수
	int countList = 5; //한 페이지에 출력될 게시글 수
	int totalPage = totalCount / countList; //총 몇페이지인지 알기위해
	int startPage = ((nowPage - 1) / countPage) * countPage + 1; //첫 페이지 구하기
	//현재페이지에서 1을 뺀 수를 countPage로 나눈뒤 그 값을 다시 countPage로 곱한뒤 1을 더해준다
	int endPage = startPage + countPage - 1; //마지막 페이지 구하기
	int beginNum = (nowPage - 1) * countList; //현재페이지에서 1을 뺀 수에서 한 페이지에 출력될 게시글 수를 곱하면
	//예를들어 현재페이지가 1이면 1-1*7 이므로 0 그리고 0 + 7 하면 7 그러니까 0번글부터 7번글까지 나오게 함
	int endNum = beginNum + countList;
	if (totalCount % countList > 0) {

		totalPage++;

	} //여기까지 하면 총 페이지 수를 알 수 있게 됨
	if (totalPage < nowPage) { //총 페이지보다 페이지가 수가 더 클때 치환

		nowPage = totalPage;

	}
	if (endPage > totalPage) { //총 페이지보다 마지막 페이지 수가 더 클때 치환

		endPage = totalPage;

	}
	if (endNum > totalCount) {
		endNum = totalCount;
	}
%>

<%--<c:set var="nowPage" value="1" />
 <c:choose>
	<c:when test="${nowPage == null}">
		<c:set var="nowPage" value="0" />
	</c:when>
	<c:otherwise>
		<c:set var="nowPage" value='${Integer.parseInt(request.getParameter("nowPage"))}' />
	</c:otherwise>
</c:choose> --%>
<%-- <c:set var="nowPage" value="0" />
<c:set var="totalCount" value="${boardList.size()}" />
<c:set var="countList" value="7" />
<c:set var="totalPage" value="${totalCount / countList}" />
<c:set var="startPage"
	value="${((nowPage - 1) / countPage) * countPage + 1}" />
<c:set var="endPage" value="${startPage + countPage - 1}" />
<c:set var="beginNum" value="${(nowPage - 1) * countList}" />
<c:set var="endNum" value="${beginNum + countList}" />
<!--총 페이지 수를 알 수 있게 됨 -->
<c:if test="${totalCount % countList > 0}">
	<c:set var="totalPage" value="${totalCount / countList + 1}" />
</c:if>

<!-- 총 페이지보다 페이지가 수가 더 클때 치환 -->
<c:if test="${totalPage < nowPage}">
	<c:set var="nowPage" value="${totalPage}" />
</c:if>

<!-- 총 페이지보다 마지막 페이지 수가 더 클때 치환 -->
<c:if test="${endPage > totalPage}">

	<c:set var="endPage" value="${totalPage}" />

</c:if>

<c:if test="${endNum > totalCount}">

	<c:set var="endNum" value="${totalCount}" />
</c:if> --%>
</head>
<body>
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
							<td width="80"><a href="read?boardNo=${list.boardNo}">
								<c:out value='${j}'/></a></td>
							<td width="640"><a href="read?boardNo=${list.boardNo}">
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
		<!-- ----------------------------------------------- 게시판 글 보여주는곳 끝--------------------------------------------------------- -->
		<div id="Page" align="center">
						<table>
							<tr>
								<% 
								if(nowPage != 1) {%>
								<td align="center"><b><a href="main?nowPage=<%=nowPage - 1%>" style="text-decoration: none;"> ◀ </a></b></td>
								
								<%}
									for (int Count = startPage; Count <= endPage; Count++) { //페이징 페이지 번호를 출력
										
										if (Count == nowPage) { //현재 페이지에는 굵은 표시
								%>

								<td align="center"><b><a href="main?nowPage=<%=Count%>" style="text-decoration: none;"> [<%=Count%>]
									</a></b></td>

								<%
									} else {
								%>
								<!-- 현재 페이지가 아닌 경우 아무표시 없음 -->

								<td align="center">
								<a href="main?nowPage=<%=Count%>" style="text-decoration: none;"> <%=Count%></a>
								</td>
								

								<%}
										

								}  %>
								<% if(nowPage < totalPage) {%>
										<td align="center"><b><a href="main?nowPage=<%=nowPage + 1 %>" style="text-decoration: none; text-shadow: none;"> ▶ </a></b></td>
								
								<% 	} %>



							</tr>
						</table>
					</div>
		<%-- <div id="Page" align="center">
			<table>
				<tr>
					<c:set var="count" value="1"></c:set>
					<c:if test="${nowPage != 1}">
						<td align="center"><b> <a href="main?nowPage=&${nowPage}-1"> ◀ </a></b></td>
					</c:if>
					<c:choose>
					<c:when test="${count == nowPage}">
						<c:forEach begin="1" end="${1 <= endPage}" var="count" >
							<c:set var="count" value="${count+1}" />
								<td align="center"><b> <a href="main?nowPage=${count}">[<c:out value="${count}" />] </a></b></td>
						</c:forEach>
					</c:when>
							<c:otherwise>
								<!-- 현재 페이지가 아닌 경우 아무표시 없음 -->
								<c:forEach begin="1" end="${1 <= endPage}" var="count">
								<c:set var="count" value="${count+1}" />
								<td align="center"><a href="main?nowPage=${count}">[<c:out value="${count}" />]
								</a></td>
								</c:forEach>
							</c:otherwise>
					</c:choose>
					<c:if test="${nowPage < totalPage}">
						<td align="center"><b><a href="main?nowPage=${nowPage + 1}"> ▶ </a></b></td>
					</c:if>
				</tr>
			</table>
		</div>  --%>
		<%-- <div class="paging" align="center">
			<div class="element">
				<c:set var="page" value="${currentpage}" />
				<!-- page maxpage를 넘었을 경우 제한 -->
				<c:if test="${page > maxpage}">
					<c:set var="page" value="${maxpage}" />
				</c:if>
				<!-- 페이지를 8개씩 나누기 위해 현재 페이지에 보여줄 max값 설정 -->
				<fmt:formatNumber value="${page/8 - (page/8 % 1)}" type="pattern"
					pattern="0" var="full" />
				<c:set var="full" value="${full * 8}" />
				<!-- prev(전페이지), next(다음페이지) 개수 설정 -->
				<c:set var="scope" value="${page%8}" />
				<c:choose>
					<c:when test="${scope == 0}">
						<c:set var="prev" value="8" />
						<c:set var="next" value="1" />
					</c:when>
					<c:when test="${scope < 9}">
						<c:set var="prev" value="${scope}" />
						<c:set var="next" value="${9-scope}" />
					</c:when>
				</c:choose>
				<!-- prev 버튼 -->
				<c:if test="${page > 8}">
					<fmt:formatNumber value="${(page-1)/8 - (((page-1)/8) % 1)}"
						type="pattern" pattern="0" var="prevb" />
					<c:set value="${(prevb-1)*8 + 1}" var="prevb" />
					<span id="prevBtn" class="prev button"><c:out value="${prevb}"/></span>
				</c:if>
				<!-- 전 페이지 -->
				<c:if test="${page != 1}">
					<c:set var="j" value="${prev}" />
					<c:forEach var="i" begin="1" end="${prev-1}">
						<c:set var="j" value="${j - 1}" />
						<c:if test="${(page - j) > 0}">
							<span class="no">${page - j}</span>
						</c:if>
					</c:forEach>
				</c:if>
				<!-- 현재 페이지 -->
				<span class="no selected">${page}</span>
				<!-- 다음 페이지 -->
				<c:if test="${page != maxpage}">
					<c:forEach var="i" begin="1" end="${next-1}">
						<c:if test="${maxpage >= page+i}">
							<span class="no">${page+i}</span>
						</c:if>
					</c:forEach>
				</c:if>
				<!-- next 버튼 -->
				<c:if test="${maxpage >= page + next}">
					<fmt:formatNumber value="${(page-1)/8 - (((page-1)/8) % 1)}"
						type="pattern" pattern="0" var="nextb" />
					<c:set value="${(nextb+1)*8 + 1}" var="nextb" />
					<span id="nextBtn" class="next button" value="${nextb}"></span>
				</c:if>
			</div>
		</div> --%>
		<!-- ----------------------------------------------- 글 쓰러 가는곳 --------------------------------------------------------- -->
		<c:if test="${sessionScope.userId != null}">
			<div id="gowrite" align="center">
				<br>
				<button id="myMenu" class="dropbtn" onclick="javascript:gowrite();">글쓰기</button>
			</div>
		</c:if>
		<!-- <input type="button" name="write" style="height: 50px; width: 100px;"  onClick= "javascript:write();">글쓰기</ -->
	</div>
</body>
</html>