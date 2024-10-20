<%@page import="my.animal.AnicateDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String catenum = request.getParameter("catenum");
	
	String str;
	int cnt = -1;
	AnicateDao adao = AnicateDao.getInstance();
	cnt = adao.deleteCate(catenum);
	
	if(cnt>0){
		str = "카테고리 삭제 성공"; 
	} else{
		str = "카테고리 삭제 실패";
	}
%>
    <script>
		alert('<%=str%>');
		location.href = "aniCate.jsp";
	</script> 