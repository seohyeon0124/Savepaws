<%@page import="java.text.DecimalFormat"%>
<%@page import="my.store.StoreBean"%>
<%@page import="java.util.ArrayList"%>
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
	#red {
		text-decoration: none;
		color: red;
	}
</style>
<script>
	function deleteStore(snum,img){
		var flag = confirm("정말로 삭제하시겠습니까?");
		if(flag){			
			location.href = "deleteStore.jsp?snum="+snum+"&img="+img;
		} else{
			location.href = "storeList.jsp";
		}
	}
</script>

<table class="table ">
  <thead class="table-dark">
    <tr>
    	<th width=10%>번호</th>
    	<th>상품코드</th>
    	<th>상품명</th>
    	<th>이미지</th>
    	<th>가격</th>
    	<th width=10%>수량</th>
    	<th>삭제</th>
    </tr>
  </thead>
  <tbody>
  <%
  	DecimalFormat df = new DecimalFormat();
  	StoreDao adao = StoreDao.getInstance();
  	ArrayList<StoreBean> list = adao.getAllStore();
  	for(StoreBean sb : list){
  %>
   	<tr>
   		<td class="align-middle"><%=sb.getSnum()%></td>
   		<td class="align-middle"><%=sb.getCode()%></td>
   		<td class="align-middle"><%=sb.getName()%></td>
   		<td class="align-middle">
   			<a href="storeView.jsp?snum=<%=sb.getSnum()%>">
   				<img src="<%=request.getContextPath()%>/images/<%=sb.getImg()%>" width=50 height=50>
			</a>
   		</td>
   		<td class="align-middle"><%=df.format(sb.getPrice())%></td>
   		<td class="align-middle"><%=sb.getQty()%></td>
   		<td class="align-middle">   			
   			<a href="javascript:deleteStore('<%=sb.getSnum()%>','<%=sb.getImg()%>')" id="red">삭제</a>
   		</td>
   	</tr>
  <%
  	}
  %>
  </tbody>
</table>
	
<%@ include file="admin_bottom.jsp"%>
<%@ include file="../bottom.jsp"%>
    