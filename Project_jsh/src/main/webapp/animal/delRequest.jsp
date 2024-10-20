<%@page import="my.animal.RequestDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String num = request.getParameter("num");
	String no = String.valueOf(session.getAttribute("no"));
	
	RequestDao rdao = RequestDao.getInstance();
	int cnt = rdao.delRequest(num, no);
	
	String str;
	if(cnt>0){
		str = "신청 취소 성공"; 
	} else{
		str = "신청 취소 실패";
	} 
%>
    <script>
    	alert("<%=str%>");
    	location.href = "aniRequestAll.jsp";
    </script>