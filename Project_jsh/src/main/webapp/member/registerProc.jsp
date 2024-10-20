<%@page import="my.member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="mb" class="my.member.MemberBean">
	<jsp:setProperty name="mb" property="*"/>
</jsp:useBean>

<%
	System.out.println("회원가입 이름 : " + mb.getName());	
	System.out.println(mb.getEmail());	
	System.out.println(mb.getPw());	
	System.out.println(mb.getRrn());	
	System.out.println(mb.getPhone());	
	System.out.println(mb.getGender());	
	System.out.println(mb.getAge());	

	MemberDao mdao = MemberDao.getInstance();
	int cnt = mdao.insertMember(mb);
	String str, url;
	if(cnt>0){
		str = "회원가입 성공!";
		url = "login.jsp";
	} else{
		str = "회원가입 실패";
		url = "register.jsp";
	}
%>
	<script type="text/javascript">
		alert("<%=str%>");
		location.href = "<%=url%>";
	</script>
    