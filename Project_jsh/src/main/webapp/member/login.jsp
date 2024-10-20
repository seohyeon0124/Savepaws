<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.security.SecureRandom"%>
<%@ page import="java.math.BigInteger"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Hugo 0.88.1">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<link rel="canonical" href="https://getbootstrap.com/docs/5.1/examples/sign-in/">
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"> -->
<link href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="signin.css" rel="stylesheet">
<style>
.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	user-select: none;
}

@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
}

#gitar a{
	text-decoration: none;
	color: gray;
}
</style>
<script type="text/javascript">
	function check(){
		if($('input[name=email]').val()==""){
			alert('아이디를 입력하세요');
			$('input[name=email]').focus();
			return false;
		} else if(!$('input[name=email]').val().includes("@")){
			alert('이메일 형식으로 입력하세요');
			$('input[name=email]').select();
			return false;
		} else if($('input[name=email]').val().includes("@kakao")){
			alert('카카오 로그인을 이용하세요');
			return false;
		} else if($('input[name=email]').val().includes("@naver")){
			alert('네이버 로그인을 이용하세요');
			return false;
		}
		if($('input[name=pw]').val()==""){
			alert('비밀번호를 입력하세요');
			$('input[name=pw]').focus();
			return false;
		}
	}
</script>
<main class="form-signin">
  <form method="post" action="loginProc.jsp">
    <!-- <img class="mb-4" src="../img/tiger.png" alt="" width="80" height="80">&nbsp;&nbsp;&nbsp; -->
    <span class="h3 mb-3 fw-normal"><b>로그인</b></span>
	<br><br>
    <div class="form-floating">
      <input type="text" name="email" class="form-control" id="floatingInput" placeholder="email">
      <label for="floatingInput">아이디</label>
    </div>
    <div class="form-floating">
      <input type="password" name="pw" class="form-control" id="floatingPassword" placeholder="pw">
      <label for="floatingPassword">비밀번호</label>
    </div>
	<div align=center id="gitar">
		<a href="<%=request.getContextPath()%>/member/findid.jsp">아이디찾기</a> |
		<a href="<%=request.getContextPath()%>/member/findpw.jsp">비밀번호찾기</a> |
		<a href="<%=request.getContextPath()%>/member/register.jsp">회원가입</a>
	</div> <br>
    <button class="w-100 btn btn-lg btn btn-secondary" type="submit" style="color:white;" onclick="return check()">로그인</button> <br><br>
    <%
  	/* 네이버 로그인 */
    String clientId = "MVkx5_4g4EYT1cvTJLMc";//애플리케이션 클라이언트 아이디값";
    String redirectURI = URLEncoder.encode("http://localhost:8080/Project_jsh/member/naverLogin.jsp", "UTF-8");
    SecureRandom random = new SecureRandom();
    String state = new BigInteger(130, random).toString();
    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
    apiURL += "&client_id=" + clientId;
    apiURL += "&redirect_uri=" + redirectURI;
    apiURL += "&state=" + state;
    session.setAttribute("state", state);
 	%>
	<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<script type="text/javascript">
	    Kakao.init('7adba8baafcd667f93cfc4b9e153872e');
	    function kakaoLogin() {
	        Kakao.Auth.login({
	            success: function (response) {
	                Kakao.API.request({
	                    url: '/v2/user/me',
	                    success: function (response) {
	                        // alert(JSON.stringify(response))
	                    	
	                    	$.ajax({
	                    		url : "loginProc.jsp",
	                    		data : ({
	                    			name : response.properties.nickname,
	                    			email : response.kakao_account.email,
	                    			phone : response.kakao_account.phone_number,
	                    			age : response.kakao_account.age_range,
	                    			gender : response.kakao_account.gender,
	                    			pw : "kakao"
	                    		}),	
	                    		success : function(data){
	                    			if(data.includes("환영합니다")){
		                    			alert(response.properties.nickname + "님 환영합니다!");
		                    			location.href = "../main.jsp";
	                    			} else if(data.includes("가입 성공")){
	                    				alert("가입 성공! 다시 로그인하세요!");
		                    			location.href = "login.jsp";
	                    			}
	                    		}
	                    	});
	                    },
	                    fail: function (error) {
	                        alert(JSON.stringify(error))
	                    },
	                })
	            },
	            fail: function (error) {
	                alert(JSON.stringify(error))
	            },
	        })
	    }
	</script>
    <div align="center">
		<a href="<%=apiURL%>"><img height="40" width=145 src="<%=request.getContextPath()%>/member/naverLogo/btnG_완성형.png" /></a>
	
		<!-- 카카오 로그인 -->
		<a id="kakao-login-btn" href="javascript:kakaoLogin()"> 
			<img src="<%=request.getContextPath()%>/member/kakaoLogo/ko/kakao_login_medium_narrow.png" height=40 width=145 alt="카카오 로그인 버튼"/>
		</a>
	</div>
	<div align=center id="gitar" style="padding:15px; font-size: 13px; font-weight: bold;">
		<a href="<%=request.getContextPath()%>/main.jsp">메인화면 돌아가기</a>
	</div>
  </form>
</main>