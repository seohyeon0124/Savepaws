<%@page import="my.free.FreeBean"%>
<%@page import="my.free.FreeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../top.jsp"%>
<%@ include file="free_top.jsp"%>

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
	.btn-danger {
	    background-color: gold !important;
	    border-color: gold !important;
	}
</style>

  <% 
  		String no = request.getParameter("no");
  		String city = request.getParameter("city");
  		String place = request.getParameter("place");
  		
  		FreeDao fdao = FreeDao.getInstance();
  		FreeBean fb = fdao.getFreeByNo(no);
  		
  		boolean flag = fb.getState().equals("신청");
  %>

<table border=1 style="margin: auto; width: 1300px; min-height: 500px">
	<tr>
		<td style="padding: 50px;" align=center>

			<table class="table table-bordered">
			    <tr>
			    	<th class="table-dark" width=25%>번호</th>
			    	<td width=25%><%=fb.getNo()%></td>
			    	<th class="table-dark" width=25%>지역</th>
			    	<td width=25%><%=fb.getCity()%>/<%=fb.getPlace()%></td>
			    </tr>
			    <tr>
			    	<th class="table-dark">물건명</th>
			    	<td><%=fb.getName()%></td>
			    	<th class="table-dark">등록일</th>
			    	<td><%=fb.getDay()%> (<%=fb.getState()%>)</td>
			    </tr>
			    <tr>
			    	<th class="table-dark align-middle">이미지</th>
			    	<td colspan=3><img src="<%=request.getContextPath()%>/images/<%=fb.getImg()%>" width=200></td>
			    </tr>
			    <tr>
			    	<th class="table-dark align-middle">소개</th>
			    	<td class="align-middle" style="text-align:left" colspan=3 height="200px"><%=fb.getContent()%></td> 
			    </tr>
			</table>
			                	
				<%if(!flag){%><button type="button" class="btn btn-outline-dark" onclick="location.href='free_want.jsp?no=<%=fb.getNo()%>'">교환신청</button><%}%>
				<button type="button" class="btn btn-outline-dark" onclick="location.href='free_place.jsp'">목록보기</button>
		</td>
	</tr>
</table>   

<%@ include file="../bottom.jsp"%>