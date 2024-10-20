<%@page import="my.animal.RequestDao"%>
<%@page import="my.animal.AnimalBean"%>
<%@page import="my.animal.AnimalDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String no = String.valueOf(session.getAttribute("no"));
	String anum = request.getParameter("anum");
	String cate = request.getParameter("cate");
  	String state = request.getParameter("state");
  	String search = request.getParameter("search");
	
	RequestDao rdao = RequestDao.getInstance(); 
	String reqState = rdao.getRequestByNo(no,anum);
	
	String str;
	if(reqState!=null){
		if(reqState.equals("신청")){
			int cnt = rdao.delRequest2(anum,no);
			if(cnt>0){
				str = "취소 성공";
			} else{
				str = "취소 실패";
			}
		}else{
			str = "이미 " + reqState + "된 내역입니다";
		}
	}else{
		int cnt = rdao.insertRequest(no,anum);
		if(cnt>0){
			str = "신청 성공";
		} else{
			str = "신청 실패";
		}
	}
%>
	<script>
		alert("<%=str%>");
		location.href = "animalView.jsp?anum=<%=anum%>&cate=<%=cate%>&state=<%=state%>&search=<%=search%>";
	</script>