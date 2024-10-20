<%@page import="my.animal.AnimalBean"%>
<%@page import="my.animal.AnimalDao"%>
<%@page import="my.animal.RequestBean"%>
<%@page import="my.animal.RequestDao"%>
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
	td #red {
		text-decoration: none;
		color: red;
	}
	td #blue {
		text-decoration: none;
		color: blue;
	}
	#gray {
		text-decoration: none;
		color: gray;
	}
	#gray:hover {
		color: orange;
	}
</style>

<script>
	function delreq(num){
		if(confirm("신청을 취소하시겠습니까?")){
			location.href = "delRequest.jsp?num="+num;
		} else{
			location.href = "aniRequestAll.jsp";
		}
	}
</script>

  <%
  	String no = String.valueOf(session.getAttribute("no"));
	RequestDao rdao = RequestDao.getInstance();
  %>

<table border=1 style="margin: auto; width: 1300px; min-height: 500px">
<tr>
  <td style="padding-top: 50px; padding-bottom: 50px;">
  	<h3><b>신청내역</b></h3><br>
	<table class="table table-bordered">
		<tr>
			<th class="table-dark" width=10%>신청번호</th>
			<th class="table-dark" width=10%>동물번호</th>
			<th class="table-dark" width=35%>동물종류</th>
			<th class="table-dark" width=20%>이미지</th>
			<th class="table-dark" width=15%>신청상태</th>
			<th class="table-dark" width=10%>취소</th>
		</tr>
		<%
			ArrayList<AnimalBean> list = rdao.getAllRequestByNo(no);  
			System.out.println("신청회원번호 : " + no);
			if(list.size()>0){
				for(AnimalBean ab : list){
		%>
				<tr>
					<td class="align-middle"><%=ab.getAge()%></td> <!-- 잠깐만 reqno 담는 용도로 사용 -->
					<td class="align-middle"><%=ab.getAnum()%></td>
					<td class="align-middle"><%=ab.getKind()%></td>
					<td class="align-middle">
						<a href="animalView.jsp?anum=<%=ab.getAnum()%>&place=신청내역">
							<img src="<%=request.getContextPath()%>/images/<%=ab.getImg()%>" height=50>
						</a>
					</td>
					<td class="align-middle">
						<%if(ab.getState().equals("승인")){%><font color=blue><b><%=ab.getState()%></b></font><%}
						else if(ab.getState().equals("거절")){%><font color=red><b><%=ab.getState()%></b></font><%}
						else {%><%=ab.getState()%><%}%>
					</td>
					<td class="align-middle">
						<%if(ab.getState().equals("승인")||ab.getState().equals("거절")){%>-<%}
						else{%><a id="gray" href="javascript:delreq(<%=ab.getAge()%>)">취소</a><%}%>
					</td>
				</tr>
		<%
				}
			} else{ 
		%>
				<tr>
					<td colspan=8 class="align-middle" height=100><b>신청 동물이 없습니다</b></td>
					
				</tr>
		<%
			}
		%>
	</table>
  </td>
<tr>
</table>

<%@ include file="../bottom.jsp"%>
    