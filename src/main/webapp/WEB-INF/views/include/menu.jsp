<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> </title>
</head>
<body>
			<div id="menu" style="background-color: #E3E3E3; height: 883px; width: 145px; float: left;">
					<div id="searchForm" style="background-color: #EEEEEF; height: 130px;">
						<form action="search">
							<br> <b>검색</b> <select name="searchType" style="height: 23px;">
								<option value="0">공지사항</option>
								<option value="1">팁게시판</option>
								<option value="2">질문게시판</option>
								<option value="3">자유게시판</option>
							</select> <input type="text" name="searchName" size="10" placeholder="제목+내용" align="middle">
							<input type="submit" name="gosearch" size="10" value="검색">
						</form>
					</div>
					<ul class="menu" style="padding-inline-start: 0px;">
						<li class="Tip"><a href="/bbs/TipBoard"> Tip 게시판</a></li>
						<li class="Question"><a href="/bbs/QuestionBoard"> 질문 게시판</a></li>
						<li class="Free"><a href="/bbs/FreeBoard"> 자유게시판</a></li>
					</ul>
			</div>
</body>
</html>