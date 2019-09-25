<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="./resources/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
	function Back() { //돌아가기 버튼
		var bool = confirm('돌아가시겠습니까? 지금까지 작성한 글은 저장되지 않습니다!');
		if (bool == true) {
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
	        $("#write").click(function(){
	                	try{
	                		obj.getById["boardText"].exec("UPDATE_CONTENTS_FIELD", []);
	                     	$('#frm').submit();
	                     	alert("등록 되었습니다!");
	                	}catch(exception){
	                		alert("데이터 등록을 실패하였습니다.");
	                    	 return false;
	                	}

	        });
	    });
</script>
<c:if test="${sessionScope.userId == null}">
	<script type="text/javascript">
		alert("비회원은 글을 작성할 수 없습니다!");
		location.href = "login";
	</script>
</c:if>
<title>글 작성하기</title>
</head>
<body>
	<div id="container">
		<%@ include file="include/header.jsp"%>
		<div align="center" style="line-height: 2.3em">
			<form id ="frm" method="post" action="writeCheck">
				<h2>게시글 작성</h2>
				<fieldset style="width: 70%; height: 90%;">
				<b>게시글 등록할 곳 : </b> <select name="boardType" style="height: 23px;">
							<option value="0">공지사항</option>
							<option value="1">Tip게시판</option>
							<option value="2">질문게시판</option>
							<option value="3">자유게시판</option>
						</select><br>
					제목 : <input type="text" size="30px" id="boardTitle" name="boardTitle" placeholder="제목을 입력하세요"> <br>
						<input type="hidden" name="boardUser" value="${sessionScope.userId}">
						작성자 : ${sessionScope.userId} <br> 내용 <br>
					<textarea id="boardText" name="boardText" style="resize: none; width: 70%; height: 70%; text-align: left;"></textarea>
					<br><input type="button" id="write" value="등록하기"> 
					<input type="button" name="back" value="돌아가기" onclick="javascript:Back();">
				</fieldset>
			</form>
		</div>
	</div>
</body>
</html>