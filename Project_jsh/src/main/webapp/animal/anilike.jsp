<%@page import="my.animal.AnimalBean"%>
<%@page import="my.animal.AnimalDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../top.jsp"%> 
<%@ include file="animal_top.jsp"%>

<style>
	.table{
		width: 70%;
		margin-left: auto;
		margin-right: auto;
	}
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

  <%
  	String no = String.valueOf(session.getAttribute("no"));
  	AnimalDao anidao = AnimalDao.getInstance();
  %>

<table border=1 style="margin: auto; width: 1300px; min-height: 500px;">
<tr>
  <td style="padding-top: 50px; padding-bottom: 50px;">
  	<h3><b>관심동물</b></h3><br>
	<table class="table table-bordered">
		<tr>
			<th class="table-dark" width=10%>동물번호</th>
			<th class="table-dark" width=15%>카테고리</th>
			<th class="table-dark" width=15%>동물종류</th>
			<th class="table-dark" width=15%>이미지</th>
			<th class="table-dark" width=10%>상태</th>
			<th class="table-dark" width=15%>구조일</th>
			<th class="table-dark" width=10%>신청</th>
			<th class="table-dark" width=10%>삭제</th>
		</tr>
		<%
			ArrayList<AnimalBean> list = anidao.getAllAnimalByMemno(no);
			if(list.size()>0){
				for(AnimalBean a : list){
		%>
				<tr>
					<td class="align-middle"><%=a.getAnum()%></td>
					<td class="align-middle"><%=a.getCate()%></td>
					<td class="align-middle"><%=a.getKind()%></td>
					<td class="align-middle"><a href="animalView.jsp?anum=<%=a.getAnum()%>&place=관심동물"><img src="<%=request.getContextPath()%>/images/<%=a.getImg()%>" height=50></a></td>
					<td class="align-middle"><%=a.getState()%></td>
					<td class="align-middle"><%=a.getDay()%></td>
					<td class="align-middle"><a id="blue" href="animalView.jsp?anum=<%=a.getAnum()%>&place=관심동물">신청</a></td>
					<td class="align-middle"><a id="red" href="delAnilike.jsp?no=<%=no%>&anum=<%=a.getAnum()%>">삭제</a></td>
				</tr>
		<%
				}
			} else{
		%>
				<tr>
					<td colspan=8 class="align-middle" height=100><b>관심 표시한 동물이 없습니다</b></td>
					
				</tr>
		<%
			}
		%>
	</table>
  </td>
</tr>
</table>

<%@ include file="../bottom.jsp"%>
    