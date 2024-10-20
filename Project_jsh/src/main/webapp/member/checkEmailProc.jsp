<%@page import="my.member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String userEmail = request.getParameter("userEmail");
	
	MemberDao mdao = MemberDao.getInstance();
	boolean flag = mdao.searchEmail(userEmail);
	if(flag){ 
		out.print("NO");
	} else{
		out.print("YES");
	}
%>
    