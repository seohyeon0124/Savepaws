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

.form-check-group {
  display: flex;
  gap: 20px; /* 라디오 버튼 사이의 간격을 20px로 설정 */
  padding-left: 20px;
}
</style>
<script>
	function check(){
		if($('input[name=name]').val()==""){
			alert('이름을 입력하세요');
			$('input[name=name]').focus();
			return false;
		}
		
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
		
		if($('input[name=rrn]').val()==""){
			alert('주민등록번호를 입력하세요');
			$('input[name=rrn]').focus();
			return false;
		}
		
		if($('input[name=phone]').val()==""){
			alert('전화번호를 입력하세요');
			$('input[name=phone]').focus();
			return false;
		} else if(!$('input[name=phone]').val().match(/^\d+$/)){
			alert('전화번호는 숫자만 입력하세요');
			return false;
		} else if($('input[name=phone]').val().includes("-")){
			alert('전화번호는 "-" 없이 입력하세요');
			$('input[name=phone]').select();
			return false;
		}
		
		if($('select[name=age] option:selected').val()=="연령대"){
			alert("연령대를 선택하세요");
			$('select[name=age]').focus();
			return false;
		}
	}
	function checkEmail(){
		$.ajax({
			url : "checkEmailProc.jsp",
			data : ({
				userEmail : f.email.value
			}),
			success : function(data){
				if($('input[name=email]').val()==""){
					$('#msg').html("입력 누락").css('color','red').show();
					$('input[name=email]').focus();
				} else if(!$('input[name=email]').val().includes("@")){
					$('#msg').html("이메일 형식 필요").css('color','red').show();
					$('input[name=email]').select();
				} else if($.trim(data)=="YES"){
					$('#msg').html("사용 가능").css('color','blue').show();
				} else if($.trim(data)=="NO"){
					$('#msg').html("사용 불가능").css('color','red').show();
					$('input[name=email]').select();
				}
			}
		});
	}
</script>
<main class="form-signin">


<form method="post" action="registerProc.jsp" name="f">

	<!-- <img class="mb-4" src="../img/tiger.png" alt="" width="80" height="80">&nbsp;&nbsp;&nbsp; -->
    <span class="h3 mb-3 fw-normal"><b>회원가입</b></span>
	<br><br>
    <div class="form-floating">
      <input type="text" name="name" class="form-control" id="floatingInput" placeholder="name">
      <label for="floatingInput">이름</label>
    </div>
    <div class="form-floating">
      <input type="text" name="email" class="form-control" id="floatingInput" placeholder="email" onblur="checkEmail()">
      <label for="floatingInput">아이디&nbsp;<span id="msg"></span></label>
    </div>
    <div class="form-floating">
      <input type="text" name="pw" class="form-control" id="floatingPassword" placeholder="pw">
      <label for="floatingPassword">비밀번호</label>
    </div>
    <div class="form-floating">
      <input type="text" name="rrn" class="form-control" id="floatingInput" placeholder="rrn" maxlength=13>
      <label for="floatingInput">주민등록번호(13자리)</label>
    </div>
    <div class="form-floating">
      <input type="text" name="phone" class="form-control" id="floatingInput" placeholder="phone" maxlength=11>
      <label for="floatingInput">전화번호(-없이입력)</label>
    </div>
    <select name="age" class="form-select form-select-lg mb-3" aria-label=".form-select-lg example" style="font-size: 15px; padding-top: 16px; padding-bottom: 16px;">
		<option value="연령대">연령대</option>
		<option value="10~19">10~19</option>
		<option value="20~29">20~29</option>
		<option value="30~39">30~39</option>
		<option value="40~49">40~49</option>
		<option value="50~59">50~59</option>
		<option value="60~69">60~69</option>
		<option value="70~79">70~79</option>
		<option value="80~89">80~89</option>
	</select>
	<div class="form-check-group" style="display: flex;">
		<b>성별</b>&nbsp;
		<div class="form-check">
			<input value="M" class="form-check-input" type="radio" name="gender" id="flexRadioDefault1" checked> 
			<label class="form-check-label" for="flexRadioDefault1"> 남자 </label>
		</div>
		<div class="form-check">
			<input value="F" class="form-check-input" type="radio" name="gender" id="flexRadioDefault2"> 
			<label class="form-check-label" for="flexRadioDefault2"> 여자 </label>
		</div>
	</div>
	<br>
	<button class="w-100 btn btn-lg btn btn-secondary" type="submit" style="color:white;" onclick="return check()">가입하기</button>
</form>
<div align=center id="gitar" style="padding:15px; font-size: 13px; font-weight: bold;">
		<a href="<%=request.getContextPath()%>/member/login.jsp">로그인화면 돌아가기</a>
	</div>
