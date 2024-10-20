<%@page import="my.review.ReviewDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String num = request.getParameter("num");
	ReviewDao rdao = ReviewDao.getInstance();
	int cnt = rdao.deleteReview(num);
	String str;
	if(cnt>0){
		str = "리뷰 삭제 성공";
	} else{
		str = "리뷰 삭제 실패";
	}
%>
    <script>
    	alert("<%=str%>");
    	location.href = "review.jsp";
    </script>
    