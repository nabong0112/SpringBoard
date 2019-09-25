<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="boardlist">
	<table border="1">
		<tr>
		<th>번호</th>
		<th>제목</th>
		<th>작성자</th>
		<th>날짜</th>
		<th>조회수</th>
		</tr>
		<c:forEach items='${listboard}' var='list'>
			<c:set var='i' value='${i+1}'/>
			<tr>
			<td><c:out value='${list.board_no}'/></td>
			<td><c:out value='${list.board_title}'/></td>
			<td><c:out value='${list.board_user}'/></td>
			<td><c:out value='${list.board_time}'/></td>
			<td><c:out value='${list.board_view}'/></td>
		</c:forEach>
	</table>
	</div>
</body>
</html>