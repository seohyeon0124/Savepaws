<%@page import="my.animal.AnicateBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.animal.AnicateDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../top.jsp"%> 
<%@ include file="admin_top.jsp"%>

<style>
	.table{ 
		width: 60%;
		margin-left: auto;
		margin-right: auto;
	}
	th, td {
		text-align: center;
	}
	td #red {
		text-decoration: none;
		color: red;
	}
</style>
<script>
	function deleteCate(catenum){
		var flag = confirm("정말로 삭제하시겠습니까?");
		if(flag){			
			location.href = "deleteCate.jsp?catenum="+catenum+"&cate=animal";
		} else{
			location.href = "aniCate.jsp";
		}
	}
</script>

<table class="table">
  <thead class="table-dark">
    <tr>
    	<th width=20%>카테고리번호</th>
    	<th width=30%>카테고리이름</th>
    	<th width=30%>카테고리코드</th>
    	<th width=20%>삭제</th>
    </tr>
  </thead>
  <tbody>
  <%
  	AnicateDao adao = AnicateDao.getInstance();
  	ArrayList<AnicateBean> list = adao.getAllAnicate();
  	for(AnicateBean ab : list){
  %>
   	<tr>
   		<td><%=ab.getCatenum()%></td>
   		<td><%=ab.getCatename()%></td>
   		<td><%=ab.getCatecode()%></td>
   		<td><a href="javascript:deleteCate('<%=ab.getCatenum()%>')" id="red">삭제</a></td>
   	</tr>
  <%
  	}
  %>
  </tbody>
</table>

<%@ include file="admin_bottom.jsp"%>
<%@ include file="../bottom.jsp"%>