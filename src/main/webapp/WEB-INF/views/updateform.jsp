<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 수정하기</title>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="./resources/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
function Back() {
	var bool = confirm('돌아가시겠습니까? 지금까지 작성한 글은 저장되지 않습니다!');
	if (bool) {
		history.back();
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
    });
  //전송버튼
    $("#update").click(function(){
            	try{
            		obj.getById["boardText"].exec("UPDATE_CONTENTS_FIELD", []);
                 	$('#frm').submit();
                 	alert("수정 되었습니다!");
            	}catch(exception){
            		alert("데이터 등록을 실패하였습니다.");
                	 return false;
            	}
    });
});
</script>
</head>
<body>
	<c:if test="${sessionScope.userId == null}">
		<script type="text/javascript">
			alert("로그인 해주세요 !");
			location.href = "login";
		</script>
	</c:if>
	<%-- <c:if test="${sessionScope.userId != list.boardUser}">
		<script type="text/javascript">
			alert("글 작성하신 본인만 수정 가능합니다!");
			history.back();
		</script>
	</c:if> --%>
	<div class="container">
	<!-- 헤더 안에는 로그인,로그아웃,내정보 자바스크립트랑 로그인정보가 담겨있음 -->
		<%@ include file="include/header.jsp"%>
		<div align="center" style="line-height: 2.3em">
			<form id="frm" method="post" action="updateCheck?boardNo=${list.boardNo}">
				<input type="hidden" name="boardType" value="${boardType}">
				<h2>게시글 수정</h2>
				<fieldset style="width: 70%; height: 90%;">
					제목 : <input type="text" size="30px" id="boardTitle" name="boardTitle"
						value="${list.boardTitle}"><br> 작성자 :
					${sessionScope.userId} <br> 내용 <br>
					<textarea name="boardText" id="boardText"
						style="resize: none; width: 70%; height: 500px; text-align: left;">${list.boardText}</textarea>
					<br> <input type="button" id="update" value="수정하기"> 
					<input type="button" name="back" value="돌아가기" onclick="javascript:Back();">
				</fieldset>
			</form>
		</div>
	</div>
</body>
</html>