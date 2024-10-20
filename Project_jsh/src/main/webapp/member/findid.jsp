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
		if($('input[name=name]').val()==""){
			alert('이름을 입력하세요');
			$('input[name=name]').focus();
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
	}
</script>
<main class="form-signin">
  <form method="post" action="findidProc.jsp">
    <!-- <img class="mb-4" src="../img/tiger.png" alt="" width="80" height="80">&nbsp;&nbsp;&nbsp; -->
    <span class="h3 mb-3 fw-normal"><b>아이디 찾기</b></span>
	<br><br>
    <div class="form-floating">
      <input type="text" name="name" class="form-control" id="floatingInput" placeholder="name">
      <label for="floatingInput">이름</label>
    </div>
    <div class="form-floating">
      <input type="text" name="rrn" class="form-control" id="floatingInput" placeholder="rrn" maxlength=13>
      <label for="floatingInput">주민등록번호(13자리)</label>
    </div>
    <div class="form-floating">
      <input type="text" name="phone" class="form-control" id="floatingInput" placeholder="phone" maxlength=11>
      <label for="floatingInput">전화번호(-없이입력)</label>
    </div><br><br>
    <button class="w-100 btn btn-lg btn btn-secondary" type="submit" style="color:white;" onclick="return check()">검색</button>
  </form>
  <div align=center id="gitar" style="padding:15px; font-size: 13px; font-weight: bold;">
		<a href="<%=request.getContextPath()%>/member/login.jsp">로그인화면 돌아가기</a>
	</div>
</main>