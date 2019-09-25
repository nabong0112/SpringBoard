<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="image/MyMenuCSS.css" type="text/css">
<link rel="stylesheet" href="image/MenuStyleCSS.css" type="text/css">
<style type="text/css">
#panel{
            position:relative;
        }
        #img_1{
            position:absolute;
            left:495px;
            top:150px; 
        }
        #img_1:hover{
              transform : scale(2,2) rotate(40deg);
        }
        
</style>
<script>
        var nX = 495;
        var nY = 150;
        var nStepSize = 4;
        var nStepX = nStepSize;
        var nStepY = nStepSize;
        // 움직임을 줄 대상인 #img_1을 저장할 변수.
        var img1;
        var nTimerID = 0;
        var nEndX = 0;
        var nEndY = 0;
    
        window.onload=function(){    
            // 요소 초기화.    
            this.init();
            // 이벤트 초기화
            this.initEventListener();
            
            document.getElementById("img_1").onclick = function(){
                location.href="main";
            }
            document.getElementById("img_1").onkeydown = function(){
                location.href="Tip_board";
            }
            // $("#img_1").bind("onclick",function(){
            //       location.href="http://jsfiddle.net";
            // });
        }
        
        // 요소 초기화.    
        function init(){
            this.nTimerID = 0;
        
            var panel = document.getElementById("panel");
            this.img1 = document.getElementById("img_1");       
            
            // 이미지가 움직일 최종 X,Y값을 구한다.    
            this.nEndX = panel.offsetWidth-img1.offsetWidth;
            this.nEndY = panel.offsetHeight-img1.offsetHeight;
            
        }
        
        // 이벤트 초기화
        function initEventListener(){
            document.getElementById("btn_start").addEventListener("click",function(){
                start();
            },false);
            
            document.getElementById("btn_stop").addEventListener("click",function(){
                stopMove();
            },false);
            
        }
        // 타이머 시작.
        function start(){
            if(this.nTimerID==0)
                this.nTimerID = setInterval(this.startMove,15);
            
        }
    
        // 이미지 움직이기.
        function startMove(){
        
            this.nX += this.nStepX;
            this.nY += this.nStepY;
            
            // 오른쪽 벽과 부딫쳤는지 체크.
            if(this.nX>this.nEndX)
                this.nStepX = -this.nStepSize;        
            //왼쪽 벽과 부딫쳤는지 체크.    
            if(this.nX<0)
                this.nStepX    = this.nStepSize;
            
            // 아래벽과 부딫쳤는지 체크.    
            if(this.nY>this.nEndY)
                this.nStepY = -this.nStepSize;
            //위쪽벽과 부딫쳤는지 체크.
            if(this.nY<0)
                this.nStepY = this.nStepSize;        
            
            // 최종 이동값을 left,top에 대입.
            img1.style.left = this.nX+"px";
            img1.style.top = this.nY+"px";
            
            //console.log("--- x : " + this.nX + " , y : " + this.nY);
        }
        start();
    </script>
<title>로그인</title>
</head>
<body>
	<!-- #에 꼭 넘어갈 페이지 넣어주333-->
	<div id="panel" align="center" style="line-height: 2.3em">
			<div id="img_1">
                <img style="width: 100px; height: 100px;" src="image/포켓몬_누오.png">
            </div>
		<form name="login" method="post" action="loginCheck">
			<h3>게시글을 읽으시거나 글을 작성하시기 위해서는 로그인이 필요합니다!</h3>
			<img alt="#" src="image/Oh.png">
			<fieldset style="width: 300px">
				<legend>로그인</legend>
				<label for="insert_id">아이디 : </label> 
				<input type="text" size="15" id="userId" name="userId"><br> 
					<label for="insert_pw">비밀번호 :</label> 
					<input type="password" size="15" id="userPw" name="userPw"><br>
					<input type="button" name="loginID" value="   로그인   " onclick="javascript:logincheck()">
					<br> 계정이 없으신가요?? <b><a href="joinform" id="join">가입하기</a></b>
					<br> 계정을 까먹으셨나요?? <b><a href="findUser" id="find">계정찾기</a></b>
					<c:if test ="${msg eq 'no'}">
						<br><p style="color: red">아이디 또는 비밀번호를 확인하세요!</p>
					</c:if>
					<c:if test ="${msg eq 'NoUserInfo'}">
						<br><p style="color: red">회원만 정보를 확인할수 있습니다!</p>
					</c:if>
					<c:if test ="${msg eq 'NoWriteUser'}">
						<br><p style="color: red">회원만 글 작성이 가능합니다!</p>
					</c:if>
					<c:if test ="${msg eq 'join'}">
						<br><p style="color: blue">회원가입을 축하합니다! 로그인해주세요!</p>
					</c:if>
				<script type="text/javascript">
					function logincheck() {
						var form = document.login;

						if (!form['userId'].value) {
							alert("어!! 아이디를 빼먹으셨네!");
							form['userId'].focus();
							return false;
						} else if (!form['userPw'].value) {
							alert("어!! 비밀번호를 빼먹으셨네!");
							form['userPw'].focus();
							return false;
						} else {

							form.submit();
						}
					}
				</script>
			</fieldset>
		</form>
	</div>
</body>
</html>