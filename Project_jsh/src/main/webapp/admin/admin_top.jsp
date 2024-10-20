<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head><script src="../assets/js/color-modes.js"></script>

    <meta charset="utf-8"> 
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.122.0">

    <link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/blog/">

    
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }

      .b-example-divider {
        width: 100%;
        height: 3rem;
        background-color: rgba(0, 0, 0, .1);
        border: solid rgba(0, 0, 0, .15);
        border-width: 1px 0;
        box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
      }

      .b-example-vr {
        flex-shrink: 0;
        width: 1.5rem;
        height: 100vh;
      }

      .bi {
        vertical-align: -.125em;
        fill: currentColor;
      }

      .nav-scroller {
        position: relative;
        z-index: 2;
        height: 2.75rem;
        overflow-y: hidden;
      }

      .nav-scroller .nav {
        display: flex;
        flex-wrap: nowrap;
        padding-bottom: 1rem;
        margin-top: -1px;
        overflow-x: auto;
        text-align: center;
        white-space: nowrap;
        -webkit-overflow-scrolling: touch;
      }

      .btn-bd-primary {
        --bd-violet-bg: #712cf9;
        --bd-violet-rgb: 112.520718, 44.062154, 249.437846;

        --bs-btn-font-weight: 600;
        --bs-btn-color: var(--bs-white);
        --bs-btn-bg: var(--bd-violet-bg);
        --bs-btn-border-color: var(--bd-violet-bg);
        --bs-btn-hover-color: var(--bs-white);
        --bs-btn-hover-bg: #6528e0;
        --bs-btn-hover-border-color: #6528e0;
        --bs-btn-focus-shadow-rgb: var(--bd-violet-rgb);
        --bs-btn-active-color: var(--bs-btn-hover-color);
        --bs-btn-active-bg: #5a23c8;
        --bs-btn-active-border-color: #5a23c8;
      }

      .bd-mode-toggle {
        z-index: 1500;
      }

      .bd-mode-toggle .dropdown-menu .active .bi {
        display: block !important;
      }
    </style>

    
    <!-- Custom styles for this template -->
    <link href="https://fonts.googleapis.com/css?family=Playfair&#43;Display:700,900&amp;display=swap" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="blog.css" rel="stylesheet">
  </head>
  
  
<br><br><br>

    

<div class="container">
  <header class="border-bottom lh-1 py-3">
    <div class="row flex-nowrap justify-content-between align-items-center">
      <div class="col-4 pt-1">
        <!-- <a class="link-secondary" href="#">Subscribe</a> -->
      </div>
      <div class="col-4 text-center">
        <h3><a class="blog-header-logo text-body-emphasis text-decoration-none" href="admin.jsp">Admin</a></h3>
      </div>
      <div class="col-4 d-flex justify-content-end align-items-center">
        <!-- <a class="link-secondary" href="#" aria-label="Search">
          <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" class="mx-3" role="img" viewBox="0 0 24 24"><title>Search</title><circle cx="10.5" cy="10.5" r="7.5"/><path d="M21 21l-5.2-5.2"/></svg>
        </a>
        <a class="btn btn-sm btn-outline-secondary" href="#">Sign up</a> -->
      </div>
    </div>
  </header>

  <div class="nav-scroller py-1 mb-3 border-bottom">
    <nav class="nav nav-underline justify-content-between">
    &nbsp;&nbsp;&nbsp;
      <a class="nav-item nav-link link-body-emphasis <%if(request.getRequestURI().equals("/Project_jsh/admin/inputCate.jsp")){%>active<%}%>" href="inputCate.jsp">카테고리 등록</a>
      <a class="nav-item nav-link link-body-emphasis <%if(request.getRequestURI().equals("/Project_jsh/admin/aniCate.jsp")){%>active<%}%>" href="aniCate.jsp">동물 카테고리</a>
      <a class="nav-item nav-link link-body-emphasis <%if(request.getRequestURI().equals("/Project_jsh/admin/inputAnimal.jsp")){%>active<%}%>" href="inputAnimal.jsp">동물 등록</a>
      <a class="nav-item nav-link link-body-emphasis <%if(request.getRequestURI().equals("/Project_jsh/admin/animalList.jsp")||request.getRequestURI().equals("/Project_jsh/admin/animalView.jsp")){%>active<%}%>" href="animalList.jsp">동물 확인</a>
      <a class="nav-item nav-link link-body-emphasis <%if(request.getRequestURI().equals("/Project_jsh/admin/animalUser.jsp")){%>active<%}%>" href="animalUser.jsp">신청 내역</a>
      <a class="nav-item nav-link link-body-emphasis <%if(request.getRequestURI().equals("/Project_jsh/admin/userList.jsp")){%>active<%}%>" href="userList.jsp">회원 정보</a>
    &nbsp;&nbsp;&nbsp;
    </nav>
  </div>
</div>

<br>
<table border=1 style="margin: auto; width: 1300px; min-height: 500px">
	<tr>
		<td style="padding: 50px;" align=center>