<%@page import="my.member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	String phone = request.getParameter("phone");
	String rrn = request.getParameter("rrn");
	
	System.out.println("name : " + name);
	System.out.println("phone : " + phone);
	
	MemberDao mdao = MemberDao.getInstance();
	String email = mdao.findid(name,phone,rrn);
	
	String str;
	if(email!=null){
		str = name + "님의 ID는 [ " + email + " ] 입니다!";
	} else{
		str = "일치하는 정보가 없습니다";
	}
%>
	<script>
	   	alert("<%=str%>");
	   	location.href = "../member/login.jsp";
	</script>
   