<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>글 상세보기</title>
<c:if test="${sessionScope.userId == null}">
	<script type="text/javascript">
		alert("로그인해주세요");
		location.href = "login";
	</script>
</c:if>
<link rel="stylesheet" href="image/MyMenuCSS.css" type="text/css">
<link rel="stylesheet" href="image/MenuStyleCSS.css" type="text/css">
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

	$(function(){//에디터를 사용하기위한 함수
	    //전역변수
	    var obj = [];
	    //스마트에디터 프레임생성
	    nhn.husky.EZCreator.createInIFrame({
	        oAppRef: obj,
	        elPlaceHolder: "boardText",
	        sSkinURI: "./resources/editor/SmartEditor2Skin.html",
	        htParams : {
	            // 툴바 사용 여부
	            bUseToolbar : true,            
	            // 입력창 크기 조절바 사용 여부
	            bUseVerticalResizer : true,    
	            // 모드 탭(Editor | HTML | TEXT) 사용 여부
	            bUseModeChanger : true,
	        }
	    }
	    //수정버튼
	    fOnAppLoad : function(){
	    	obj.getById["boardText"].exec("PASTE_HTML",[]);
	    },
	    fCreator:"createSEditor2"
	});
</script>
<!-- 자바스크립트 끝 -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${list.boardUser}님의글입니다.</title>
</head>
<body>
	<div id="container">
		<%@ include file="include/header.jsp"%>
		<div id="content"
			style="background-color: #E3E3E3; height: 883px; width: 1900px; float: left;">
			<%@ include file="include/menu.jsp"%>
			<div id="boardName">
			<c:if test ="${boardType == 0 }">
			<p style="display: inline;">공지사항</p>
			</c:if>
			<c:if test ="${boardType == 1 }">
			<p style="display: inline;">팁게시판</p>
			</c:if>
			<c:if test ="${boardType == 2 }">
			<p style="display: inline;">질문게시판</p>
			</c:if>
			<c:if test ="${boardType == 3 }">
			<p style="display: inline;">자유게시판</p>
			</c:if>
				<button id="myMenu" class="dropbtn" onclick="javascript:gowrite();">글쓰기</button>
			</div>
			<div align="center"
				style="border: 1px solid #dddddd; overflow: auto;">
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd; line-height: 2.3em; background-color: white;">
					<thead>
						<tr>
							<th colspan="7"
								style="background-color: #eeeeee; text-align: center;">게시글</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="width: 20%; border: 1px solid #dddddd;">글 제목</td>
							<td colspan="2" style="width: 400px; border: 1px solid #dddddd;">${list.boardTitle}</td>

							<td style="width: 10%; border: 1px solid #dddddd;">조회수</td>
							<td colspan="2" style="width: 200px; border: 1px solid #dddddd;">${list.boardCount}
							</td>
						</tr>
						<tr>
							<td style="width: 20%; border: 1px solid #dddddd;">작성자</td>
							<td colspan="2" style="width: 300px; border: 1px solid #dddddd;">${list.boardUser}</td>
							<td style="width: 20%; border: 1px solid #dddddd;">작성일</td>
							<td colspan="2" style="width: 200px; border: 1px solid #dddddd;">${list.boardTime}</td>
						</tr>
						<tr>
							<td colspan="5" style="border: 1px solid #dddddd;">내용</td>
						</tr>
						<tr>
							<td colspan="5"
								style="height: 200px; text-align: left; border: 1px solid #dddddd;">
								${list.boardText} <%-- <%=text.replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br/>")%> --%>
							</td>
							<!-- 뒤에.replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br/>") -->
						</tr>
					</tbody>
				</table>
				<!-- ----------------------------------------------- 글 보여주는곳 끝 --------------------------------------------------------- -->
				<div align="center">
					<a onclick="history.back();" class="btn btn-primary"
						style="text-decoration: none;">목록으로</a>
					<c:if test="${sessionScope.userId == list.boardUser}">
						<a onclick="return confirm('수정하시겠습니까?')"
							href="update?boardNo=${list.boardNo}&boardType=${boardType}"  style="text-decoration: none;">수정하기</a>
						<a onclick="return confirm('글을 삭제하시겠습니까? 삭제하시면 복구할 수 없습니다!')"
							href="delete?boardNo=${list.boardNo}&boardType=${boardType}" style="text-decoration: none;">삭제하기</a>
					</c:if>
				</div>
				<br>
				<!-- --------------------------------------------------댓글 보여주는곳---------------------------------------------------------- -->
				<div id="comment-border"
					style="align-content: center; border: 1px solid #dddddd;">
					<h3 align="center" style="text-align: center; height: 10px;">댓글창</h3>
					<form method="post" action="comment?boardNo=${list.boardNo}&boardType=${boardType}"
						style="margin: 0">
						<table
							style="text-align: center; border: 1px solid #dddddd; line-height: 2.4em; background-color: white;">
							<tr align="right">
								<th style="background-color: #eeeeee;" colspan="3">댓글 :
									${commentList.size()}개</th>
							</tr>
							<tr align="center">
								<th width="120px"><b>작성자</b></th>
								<th width="720px">내용</th>
								<th width="180px"><b>작성 일자</b></th>
							</tr>
							<c:choose>
								<c:when test="${commentList.size() != 0}">
									<c:forEach items='${commentList}' var='comment'>
										<c:set var='i' value='${i+1}' />
										<tr align="center">
											<td><c:out value='${comment.commentUser}' /></td>
											<td><c:out value='${comment.commentText}' /> 
											<input type="text" size="10px" id="update" style="visibility: hidden;" value="${comment.commentText}">
												<button id="updateCheck" type="submit" class="dropbtn" style="visibility: hidden;" onclick="javascript:updateCheck();">수정</button></td>
											<td><c:out value='${comment.commentTime}' /><br> 
												<c:if test="${comment.commentUser == sessionScope.userId}">
													<a id="updateButton" href="javascript:updateComment();">수정하기(업데이트 예정)</a>
													<a onclick="return confirm('댓글을 삭제하시겠습니까? 삭제하시면 복구할 수 없습니다!')"
														href="deleteComment?boardNo=${list.boardNo}&commentNo=${comment.commentNo}&boardType=${boardType}">
														삭제하기</a><br>
												</c:if> 
											</td>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr align="center">
										<td colspan="4"><b> 댓글이 없습니다! </b></td>
									</tr>
								</c:otherwise>
							</c:choose>

							<c:if test="${sessionScope.userId != null}">
								<tr align="center" id="comment">
									<td>${sessionScope.userId}</td>
									<td><textarea name="commentText" placeholder="소중한 댓글을 입력해주세요."
											style="resize: none; width: 500px; height: 30px;"></textarea>
										<input type="hidden" name="userId" value="${sessionScope.userId}"></td>
									<td><button type="submit" class="dropbtn">댓글달기</button></td>
								</tr>
							</c:if>
						</table>
					</form>
				</div>
				<!-- ----------------------------------------------- 댓글 작성하는 곳 --------------------------------------------------------- -->
			</div>
		</div>
	</div>
</body>
</html>