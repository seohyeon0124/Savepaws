<%@page import="my.animal.AnicateDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String cate = request.getParameter("cate"); // 동물(1) or 상품(2) 카테고리
	String catename = request.getParameter("catename");
	String catecode = request.getParameter("catecode");
	
	String str,url;

	AnicateDao adao = AnicateDao.getInstance();
	int cnt = adao.insertCate(catename,catecode);
	
	if(cnt>0){
		str = "카테고리 등록 성공";
		url = "aniCate.jsp";
	} else{
		str = "카테고리 등록 실패";
		url = "inputCate.jsp";
	}
%>
	<script> 
		alert('<%=str%>');
		location.href = "<%=url%>";
	</script>
    