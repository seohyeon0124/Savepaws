<%@page import="my.member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../top.jsp"%>
<%@ include file="animal_top.jsp"%>


<%
	String cate = request.getParameter("cate");
	String state = request.getParameter("state");
	String search = request.getParameter("search");
	String place = request.getParameter("place");
	if(place==null){
		place = "basic"; 
	}
	

	String no = String.valueOf(session.getAttribute("no"));
	String anum = request.getParameter("anum");
	MemberDao mdao = MemberDao.getInstance();
	
	String anilike = mdao.getAni(no,anum); 
	int cnt = -1;
	String str,url;
	if(anilike!=null){ // 기존에 관심동물에 있었던것
		str = "관심동물 해제";
		cnt = mdao.deleteAni(no, anilike, anum);
	} else{
		str = "관심동물 선택";
		cnt = mdao.updateAni(no,anum); 
	}
	
	System.out.println("place : " + place);
	if(place.equals("basic")){
		url = "animal.jsp?cate="+cate+"&state="+state+"&search="+search;
	} else{
		url = "animalView.jsp?anum="+anum+"&cate="+cate+"&state="+state+"&search="+search;
	}
	
	if(cnt>0){
		str += " 성공";
	}else{
		str += " 실패";
	}
%>
    <script>
    	alert("<%=str%>");
    	location.href = "<%=url%>";
    </script>
