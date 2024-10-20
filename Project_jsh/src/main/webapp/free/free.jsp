<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../top.jsp"%>
<%@ include file="free_top.jsp"%>

<style>
.custom-background {
  background-image: url('../img/main1.jpg'); /* 배경 이미지 URL */
  background-size: cover; /* 배경 이미지가 div를 전부 커버하도록 설정 */
}
</style>

<br>
<main class="container">
 	<div class="p-4 p-md-5 mb-4 rounded text-body-emphasis bg-body-secondary custom-background">
    <div class="col-lg-6 px-0" style="color:white;">
      <h1 class="display-4 fst-italic">사용하지 않는 물건을<br>무료나눔해요</h1>
      <br>
      <p class="lead my-3">내 주변의 가까운 사람과 필요한 물건을 주고 받아요!</p>
      <p class="lead my-3">내가 베푼만큼 나에게도 분명 좋은일이 돌아올거예요!</p>
      <br>
      <p class="lead mb-0"><a href="free_input.jsp" class="text-body-emphasis fw-bold" style="text-decoration: none;"><font color="#ffc">나눔하러가기...</font></a></p>
    </div>
  </div>
</main>
<br>
<%@ include file="../bottom.jsp"%>
    