<%@page import="my.animal.RequestDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String reqno = request.getParameter("reqno");
	String state = request.getParameter("state");
	
	RequestDao rdao = RequestDao.getInstance();
	String str;
	int cnt = rdao.updateState(reqno,state);
	if(cnt>0){
		str = state+" 처리 성공";
	} else{
		str = state+" 처리 실패";
	}
%>   
 	<script type="text/javascript">
		alert("<%=str%>");
		location.href = "animalUser.jsp";
	</script> 