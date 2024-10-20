<%@page import="java.text.DecimalFormat"%>
<%@page import="my.store.StoreBean"%>
<%@page import="my.store.StoreDao"%>
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

<table class="table table-bordered">
    <tr>
    	<th class="table-dark" width=25%>이름</th>
    	<td width=25%><%=sb.getName()%></td>
    	<th class="table-dark" width=25%>코드</th>
    	<td width=25%><%=sb.getCode()%></td>
    </tr>
    <tr>
    	<th class="table-dark">수량</th>
    	<td><%=sb.getQty()%></td>
    	<th class="table-dark">가격</th>
    	<td><%=df.format(sb.getPrice())%></td>
    </tr>
    <tr>
    	<th class="table-dark align-middle">이미지</th>
    	<td colspan=3><img src="<%=request.getContextPath()%>/images/<%=sb.getImg()%>" width=200></td>
    </tr>
    <tr>
    	<th class="table-dark">소개</th>
    	<td colspan=3><%=sb.getContent()%></td> 
    </tr>
</table>

<button type="button" class="btn btn-outline-dark" onclick="location.href='updateStore.jsp?snum=<%=snum%>'">수정</button>
<button type="button" class="btn btn-outline-dark" onclick="location.href='storeList.jsp'">목록</button>

<%@ include file="admin_bottom.jsp"%>
<%@ include file="../bottom.jsp"%>