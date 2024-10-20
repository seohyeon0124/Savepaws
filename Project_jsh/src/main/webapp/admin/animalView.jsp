<%@page import="my.animal.AnimalBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.animal.AnimalDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../top.jsp"%> 
<%@ include file="admin_top.jsp"%>

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
</style> 

  <%
  	String anum = request.getParameter("anum");
  	AnimalDao adao = AnimalDao.getInstance();
  	AnimalBean ab = adao.getAnimalByAnum(anum);
  %>

<table class="table table-bordered">
    <tr>
    	<th class="table-dark" width=25%>번호</th>
    	<td width=25%><%=ab.getAnum()%></td>
    	<th class="table-dark" width=25%>카테고리</th>
    	<td width=25%><%=ab.getCate()%></td>
    </tr>
    <tr>
    	<th class="table-dark">종류</th>
    	<td><%=ab.getKind()%></td>
    	<th class="table-dark">나이</th>
    	<td><%=ab.getAge()%></td>
    </tr>
    <tr>
    	<th class="table-dark">색상</th>
    	<td>
    		<%
    			if(ab.getColor()!=null){
		    		if(ab.getColor().contains("white")){%>○<%}
			    	if(ab.getColor().contains("gray")){%><font color="gray">●</font><%}
			    	if(ab.getColor().contains("black")){%>●<%}
			    	if(ab.getColor().contains("brown")){%><font color="#CC723D">●</font><%}
			    	if(ab.getColor().contains("etc.")){%>+<%} 
    			} else{
    		%>
    			등록X
    		<%
    			}
    		%>
    	</td>
    	<th class="table-dark">상태</th>
    	<td><%=ab.getState()%></td>
    </tr>
    <tr>
    	<th class="table-dark align-middle">이미지</th>
    	<td colspan=3><img src="<%=request.getContextPath()%>/images/<%=ab.getImg()%>" width=200></td>
    </tr>
    <tr>
    	<th class="table-dark">발견장소</th>
    	<td><%=ab.getPlace()%></td>
    	<th class="table-dark align-middle" >구조일</th>
    	<td class="align-middle"><%=ab.getDay()%></td>
    </tr>
    <tr>
    	<th class="table-dark">소개</th>
    	<td colspan=3><%=ab.getContent()%></td> 
    </tr>
</table>

<button type="button" class="btn btn-outline-dark" onclick="location.href='updateAnimal.jsp?anum=<%=anum%>'">수정</button>
<button type="button" class="btn btn-outline-dark" onclick="location.href='animalList.jsp'">목록</button>

<%@ include file="admin_bottom.jsp"%>
<%@ include file="../bottom.jsp"%>