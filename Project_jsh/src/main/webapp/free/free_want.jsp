<%@page import="my.member.MemberDao"%>
<%@page import="my.free.FreeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String no = request.getParameter("no");
	String mno = String.valueOf(session.getAttribute("no"));
	MemberDao mdao = MemberDao.getInstance();
	String email = mdao.getMemberEmailByNo(mno);
	FreeDao fdao = FreeDao.getInstance();
	int cnt = fdao.updateState(no,email);  
	String str;
	if(cnt>0){
		str = "신청 성공";
	}else{
		str = "신청 실패";
	}
%> 
   <script>
   	alert("<%=str%>");
   	location.href = "free_place.jsp";
   </script>