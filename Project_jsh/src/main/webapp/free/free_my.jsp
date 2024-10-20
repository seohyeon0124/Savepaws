<%@page import="my.free.FreeBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.free.FreeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	.table th, td {
		text-align: center;
	}
	td #red, td #blue {
		text-decoration: none;
		color: gray;
	}
	td #red:hover {
		color: red;
	}
	td #blue:hover {
		color: blue;
	}
</style>

<%@ include file="../top.jsp"%>
<%@ include file="free_top.jsp"%>

<table border=1 style="margin: auto; width: 1300px; min-height: 500px;">
<tr>
  <td style="padding-top: 50px; padding-bottom: 50px;">
  	<h3><b>내 게시물</b></h3><br>
	<table class="table table-bordered" style="width: 80%;margin-left: auto;margin-right: auto;">
		<tr>
			<th class="table-dark" width=5%>번호</th>
			<th class="table-dark" width=20%>상품명</th>
			<th class="table-dark" width=20%>지역</th>
			<th class="table-dark" width=10%>이미지</th>
			<th class="table-dark" width=15%>등록일</th>
			<th class="table-dark" width=20%>신청</th>
			<th class="table-dark" width=10%>삭제</th>
		</tr>

<%
	String mno = String.valueOf(session.getAttribute("no"));

	FreeDao fdao = FreeDao.getInstance();
	ArrayList<FreeBean> list = fdao.getFreeByMno(mno);
	if(list.size()>0){
		for(FreeBean fb : list){
	%>
				<tr>
					<td class="align-middle"><%=fb.getNo()%></td>
					<td class="align-middle"><%=fb.getName()%></td>
					<td class="align-middle"><%=fb.getCity()%>/<%=fb.getPlace()%></td>
					<td class="align-middle"><a href="freeView.jsp?no=<%=fb.getNo()%>"><img src="<%=request.getContextPath()%>/images/<%=fb.getImg()%>" height=50></a></td>
					<td class="align-middle"><%=fb.getDay()%></td>
					<td class="align-middle"><%=fb.getWant()%></td>
					<td class="align-middle"><a id="red" href="delFree.jsp?no=<%=fb.getNo()%>">삭제</a></td>
				</tr>
	<%
		}
	}else{
	%>
				<tr>
					<td colspan=8 class="align-middle" height=100><b>등록한 무료나눔 물건이 없습니다</b></td>
					
				</tr>
	<%
	}
%>
	</table>
</td>
</tr>
</table>

<%@ include file="../bottom.jsp"%>
    