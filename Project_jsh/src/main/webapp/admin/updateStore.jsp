<%@page import="my.store.StoreBean"%>
<%@page import="my.store.StoreDao"%>
<%@page import="java.text.DecimalFormat"%>
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
    DecimalFormat df = new DecimalFormat();
  	String snum = request.getParameter("snum");
  	StoreDao sdao = StoreDao.getInstance();
  	StoreBean sb = sdao.getStoreBySnum(snum); 
  %>

<form method="post" action="updateStoreProc.jsp?snum=<%=snum%>&orimg=<%=sb.getImg()%>" enctype="multipart/form-data">
<table class="table table-bordered">
    <tr>
    	<th class="table-dark align-middle" width=25%>이름</th>
    	<td width=25%>
    		<input value="<%=sb.getName()%>" name="name" type="text" class="form-control custom-width" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
    	</td>
    	<th class="table-dark" width=25%>코드</th>
    	<td width=25%>
    		<input value="<%=sb.getCode()%>" name="code" type="text" class="form-control custom-width" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
    	</td>
    </tr>
    <tr>
    	<th class="table-dark">수량</th>
    	<td>
    		<input value="<%=sb.getQty()%>" name="qty" type="text" class="form-control custom-width" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
    	</td>
    	<th class="table-dark">가격</th>
    	<td>
			<input value="<%=sb.getPrice()%>" name="price" type="text" class="form-control custom-width" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
    	</td>
    </tr>
    <tr>
    	<th class="table-dark align-middle">이미지</th>
    	<td colspan=3>
    		<img src="<%=request.getContextPath()%>/images/<%=sb.getImg()%>" width=200>
    		<input name="img" type="file" class="form-control" id="inputGroupFile01">
    	</td>
    </tr>
    <tr>
    	<th class="table-dark">소개</th>
    	<td colspan=3>
    		<input value="<%=sb.getContent()%>" name="content" type="text" class="form-control custom-width" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
    	</td> 
    </tr>
</table>
<button type="submit" class="btn btn-outline-dark">완료</button>
</form>


<%@ include file="admin_bottom.jsp"%>
<%@ include file="../bottom.jsp"%>