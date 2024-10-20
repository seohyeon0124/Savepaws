<%@page import="my.member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="top.jsp"%>

<main>

  <div id="myCarousel" class="carousel slide mb-6" data-bs-ride="carousel">
    <div class="carousel-indicators">
      <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
      <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
      <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
    </div>
    <div class="carousel-inner">
      <div class="carousel-item active">
        <img src="img/main1.jpg" class="bd-placeholder-img" width="100%" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false">
        <div class="container">
          <div class="carousel-caption text-start">
            <h1>Adopt Animals, Adopt Family</h1>
            <p class="opacity-75">세이브포스는 사지 않고 입양하는 문화를 만듭니다.</p> 
            <p><a class="btn btn-lg btn-light" style="color:black;" href="introduce/introduce.jsp"><b>세이브포스 소개</b></a></p>
          </div>
        </div>
      </div>
      <div class="carousel-item">
		<img src="img/main2.jpg" class="bd-placeholder-img" width="100%" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false">
        <div class="container">
          <div class="carousel-caption">
            <h1>소중한 생명이 당신을 기다립니다</h1>
            <p class="opacity-75">세이브포스를 통해 68,724 마리의 유기동물이 가족을 찾았습니다.</p> 
            <p><a class="btn btn-lg btn-light" style="color:black;" href="animal/animal.jsp"><b>만나러 가기</b></a></p>
          </div>
        </div>
      </div>
      <div class="carousel-item">
		<img src="img/main3.jpg" class="bd-placeholder-img" width="100%" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false">
        <div class="container">
          <div class="carousel-caption text-end">
            <h1>유기동물과 함께 나누는 세이브포스</h1>
            <p>후원금과 후원물품은 모두 유기동물을 위해 사용됩니다.</p>
            <p><font size=3>연락처[02-1234-5678] 이메일[savepaws@naver.com]</font></p>
          </div>
        </div>
      </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#myCarousel" data-bs-slide="prev">
      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#myCarousel" data-bs-slide="next">
      <span class="carousel-control-next-icon" aria-hidden="true"></span>
      <span class="visually-hidden">Next</span>
    </button>
  </div>


  <!-- Marketing messaging and featurettes
  ================================================== -->
  <!-- Wrap the rest of the page in another container to center all the content. -->

  <div class="container marketing">

    <!-- Three columns of text below the carousel -->
    <div class="row">
	  <div class="col-lg-4">
	    <!-- SVG 대신 이미지 사용 -->
	    <img class="bd-placeholder-img rounded-circle" width="200" height="200" src="img/main4.jpg" role="img" aria-label="Placeholder: Review" preserveAspectRatio="xMidYMid slice" focusable="false">
	    <br><br><h4 class="fw-normal"><b>입양 후기</b></h4>
	    <p>세이브 포스에서 맺어진<br>다양한 인연들의 소식을 접해보세요</p>
	    <p><a class="btn btn-dark" href="review/review.jsp">review &raquo;</a></p>
	  </div><!-- /.col-lg-4 -->
	  <div class="col-lg-4">
	    <!-- SVG 대신 이미지 사용 -->
	    <img class="bd-placeholder-img rounded-circle" width="200" height="200" src="img/main5.jpg" role="img" aria-label="Placeholder: Free Giveaway" preserveAspectRatio="xMidYMid slice" focusable="false">
	    <br><br><h4 class="fw-normal"><b>무료 나눔</b></h4>
	    <p>내 주변의 가까운 사람과<br>필요한 물건을 주고 받아요</p>
	    <p><a class="btn btn-dark" href="free/free.jsp">free &raquo;</a></p>
	  </div><!-- /.col-lg-4 -->
	  <div class="col-lg-4">
	    <!-- SVG 대신 이미지 사용 -->
	    <img class="bd-placeholder-img rounded-circle" width="200" height="200" src="img/main6.jpg" role="img" aria-label="Placeholder: Ask" preserveAspectRatio="xMidYMid slice" focusable="false">
	    <br><br><h4 class="fw-normal"><b>문의 하기</b></h4>
	    <p>문제 또는 궁금한 점이 있으시다면<br>언제든지 저희 세이브포스를 찾아주세요</p>
	    <p><a class="btn btn-dark" href="introduce/introduce.jsp">introduce &raquo;</a></p>
	  </div><!-- /.col-lg-4 -->
	</div><!-- /.row -->

  </div><!-- /.container -->


<%@ include file="bottom.jsp"%>