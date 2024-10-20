<%@page import="my.free.FreeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String no = request.getParameter("no");
	FreeDao fdao = FreeDao.getInstance();
	int cnt = fdao.delFree(no);
	String str;
	if(cnt>0){
		str = "삭제 성공";
	}else{
		str = "삭제 실패";
	}
%>
<script type="text/javascript">
	alert("<%=str%>");
	location.href = "free_my.jsp";
</script>