<%@page import="my.member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="my.member.MemberDao"%>

<%
	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	if(gender!=null){
		if(gender.equals("female")){
			gender = "F";
		} else if(gender.equals("male")){
			gender = "M";
		}
	}
	String age = request.getParameter("age");
	String phone = request.getParameter("phone");
	if(phone!=null){
		if(phone.contains("+82")){
			phone = phone.replace("+82", "0");
		}
		if(phone.contains("-") || phone.contains(" ")){
			phone = phone.replaceAll("[ -]", "");
		}
	}
	String email = request.getParameter("email");
	String pw = request.getParameter("pw");
	
	System.out.println("name : " + name);
	System.out.println("gender : " + gender);
	System.out.println("age : " + age);
	System.out.println("phone : " + phone);
	System.out.println("email : " + email);
	System.out.println("pw : " + pw);
	
	MemberDao mdao = MemberDao.getInstance();
	MemberBean member = mdao.getMemberByEmail(email,pw);
	String str, url;
	if(member!=null){
		str = mdao.getMemberName(email) + "님 환영합니다!";
		url = "../main.jsp";
		session.setAttribute("email",email);
		session.setAttribute("no",member.getNo());
	} else{
		str = "로그인 실패";
		url = "login.jsp";
		
		if(gender==null){
		%>
			<script>
		    	alert("일치하는 회원정보가 없습니다");
		    	location.href = "login.jsp";
		    </script>
		<%
		}
		
		MemberBean mb = new MemberBean();
		mb.setName(name);
		mb.setGender(gender);
		mb.setAge(age);
		mb.setPhone(phone);
		mb.setEmail(email);
		mb.setPw(pw);
		
		int cnt = mdao.insertMember(mb); 
		if(cnt>0){
			str = "가입 성공! 다시 로그인하세요!";
			url = "login.jsp";
		} else{
			str = "가입 실패";
			url = "login.jsp";
		}
	}
%>
    <script>
    	alert("<%=str%>");
    	location.href = "<%=url%>";
    </script>
    