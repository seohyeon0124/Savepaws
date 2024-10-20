<%@page import="my.member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="en" data-bs-theme="auto">
<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Hugo 0.122.0">
<title>세이브포스</title>

<link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/carousel/">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"> -->
<link href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="carousel.css" rel="stylesheet">
<link rel="stylesheet" href="main.css">
<script src="../assets/js/color-modes.js"></script>

<!-- Custom styles for this template -->
</head>


<body>
   
<header data-bs-theme="dark">
  <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
    <div class="container-fluid">
      <a class="navbar-brand" href="<%=request.getContextPath()%>/main.jsp">SAVEPAWS</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarCollapse">
        <ul class="navbar-nav me-auto mb-2 mb-md-0">
          <li class="nav-item">
            <a class="nav-link <%if(request.getRequestURI().equals("/Project_jsh/main.jsp")){%>active<%}%>" aria-current="page" href="<%=request.getContextPath()%>/main.jsp">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link <%if(request.getRequestURI().equals("/Project_jsh/introduce/introduce.jsp")){%>active<%}%>" href="<%=request.getContextPath()%>/introduce/introduce.jsp">Introduce</a>
          </li>
          <li class="nav-item">
            <a class="nav-link <%if(request.getRequestURI().equals("/Project_jsh/animal/animal.jsp")){%>active<%}%>" href="<%=request.getContextPath()%>/animal/animal.jsp">Animal</a>
          </li>
          <li class="nav-item">
            <a class="nav-link <%if(request.getRequestURI().equals("/Project_jsh/review/review.jsp")){%>active<%}%>" href="<%=request.getContextPath()%>/review/review.jsp">Review</a>
          </li>
          <li class="nav-item">
            <a class="nav-link <%if(request.getRequestURI().equals("/Project_jsh/free/free.jsp")){%>active<%}%>" href="<%=request.getContextPath()%>/free/free.jsp">Free</a>
          </li>
        <%
        	if(session.getAttribute("no")!=null){
        		if((Integer)session.getAttribute("no")==0){
       	%>
	          <li class="nav-item">
	            <a class="nav-link <%if(request.getRequestURI().equals("/Project_jsh/admin/admin.jsp")){%>active<%}%>" href="<%=request.getContextPath()%>/admin/admin.jsp">Admin</a>
	          </li>
       	<%
        		}
        	}
        %>
        </ul>
        <ul class="navbar-nav ms-auto">
          <%
	          request.setCharacterEncoding("UTF-8");
	          String email = (String) session.getAttribute("email");
	          
	          if(email!=null){
	        	MemberDao mdao = MemberDao.getInstance();
	        	String name = mdao.getMemberName(email);
	      %>
	      		<li class="nav-item">
            	<a class="nav-link disabled" aria-disabled="true"><%=name%>님</a>
          		</li>
	      		<li class="nav-item">
            	<a class="nav-link" href="<%=request.getContextPath()%>/member/logout.jsp">Logout</a>
          		</li>
	      <%
	        	  
	          } else{
	      %>
	      		<li class="nav-item">
           			<a class="nav-link disabled" aria-disabled="true">User</a>
          		</li>
          		<li class="nav-item">
            		<a class="nav-link" href="<%=request.getContextPath()%>/member/login.jsp">Login</a>
          		</li>
	      <%  
	          }
          %>
        </ul>
      </div>
    </div>
  </nav>
</header>
