<%@page import="my.member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	MemberDao mdao = MemberDao.getInstance();

	String no = String.valueOf(session.getAttribute("no"));
	String anum = request.getParameter("anum");
	System.out.println(no);
	System.out.println(anum);
	
	String anilike = mdao.getAni(no,anum);
	System.out.println(anilike);
	
	int cnt = mdao.deleteAni(no, anilike, anum);
	
	String str;
	if(cnt>0){
			str = "관심동물 삭제 성공"; 
	}else{
			str = "관심동물 삭제 실패";
	}
%>
    <script>
    	alert("<%=str%>");
    	location.href = "anilike.jsp";
    </script>
    