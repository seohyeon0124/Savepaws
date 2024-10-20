 <%@page import="my.animal.AnicateBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.animal.AnicateDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head><script src="../assets/js/color-modes.js"></script> 

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.122.0">

    <link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/blog/">

    

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
        <h3><a class="blog-header-logo text-body-emphasis text-decoration-none" href="animal.jsp">Animal</a></h3>
      </div>
      <div class="col-4 d-flex justify-content-end align-items-center">
        <!-- <a class="link-secondary" href="#" aria-label="Search">
          <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" class="mx-3" role="img" viewBox="0 0 24 24"><title>Search</title><circle cx="10.5" cy="10.5" r="7.5"/><path d="M21 21l-5.2-5.2"/></svg>
        </a> -->
        <a class="btn btn-sm btn-outline-secondary" href="anilike.jsp">관심동물</a> &nbsp;&nbsp;
        <a class="btn btn-sm btn-outline-secondary" href="aniRequestAll.jsp">신청내역</a>
      </div>
    </div>
  </header>

  <div class="nav-scroller py-1 mb-3 border-bottom">
    <nav class="nav nav-underline">
	  <%
	  	AnicateDao adao = AnicateDao.getInstance();
	  	ArrayList<AnicateBean> kind = adao.getAllAnicate();
	  	String currentCate = request.getParameter("cate");
	  %>
	    <a class="nav-item nav-link link-body-emphasis <%if(currentCate==null||currentCate.equals("전체")){%>active<%}%>" href="animal.jsp">&nbsp;&nbsp;전체&nbsp;&nbsp;</a>
	  <%
	  	for(AnicateBean ab : kind){
	  %>
	  	<a class="nav-item nav-link link-body-emphasis <%if(currentCate!=null&&currentCate.equals(ab.getCatecode())){%>active<%}%>" href="animal.jsp?cate=<%=ab.getCatecode()%>">&nbsp;&nbsp;<%=ab.getCatename()%>&nbsp;&nbsp;</a>
	  <%
	  	}
	  %>
        <a class="nav-item nav-link link-body-emphasis text-muted" href="../review/review.jsp">&nbsp;&nbsp;동물소식&nbsp;&nbsp;</a>
    </nav>
  </div>
</div>