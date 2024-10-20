<%@page import="my.store.StorecateBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.store.StorecateDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../top.jsp"%> 
<%@ include file="admin_top.jsp"%>

<style>
	.table {
		width: 60%;
		margin-left: auto;
		margin-right: auto;
	}
	
	.table th, .table td {
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
			location.href = "deleteCate.jsp?catenum="+catenum+"&cate=store";
		} else{
			location.href = "storeCate.jsp";
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
  	StorecateDao sdao = StorecateDao.getInstance();
  	ArrayList<StorecateBean> list = sdao.getAllStorecate();
  	for(StorecateBean sb : list){
  %>
   	<tr>
   		<td><%=sb.getCatenum()%></td>
   		<td><%=sb.getCatename()%></td>
   		<td><%=sb.getCatecode()%></td>
   		<td><a href="javascript:deleteCate('<%=sb.getCatenum()%>')" id="red">삭제</a></td>
   	</tr>
  <%
  	}
  %>
  </tbody>
</table>

<%@ include file="admin_bottom.jsp"%>
<%@ include file="../bottom.jsp"%>