<%@page import="my.animal.RequestDao"%>
<%@page import="my.review.ReviewBean"%>
<%@page import="my.review.ReviewDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../top.jsp"%>
    
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

<script>
	function delReview(num){
		if(confirm('리뷰를 삭제하시겠습니까?')){
			location.href = "review_delete.jsp?num="+num;
		} else{
			location.href = "review_view.jsp?num="+num;
		}
	}
</script>

<%
	ReviewDao rdao = ReviewDao.getInstance();
	String num = request.getParameter("num");
	ReviewBean rb = rdao.getReviewByNum(num); 
	
	MemberDao mdao = MemberDao.getInstance();
	String no = String.valueOf(session.getAttribute("no"));
	String name = mdao.getMemberNameByNo(String.valueOf(rb.getMno()));
%>


<div style="border:1px solid black; padding:30px; width:1000px; height:800px; margin-left:auto; margin-right: auto; margin-top:100px;">
<section class="py-5 text-center container" style="margin-top: -100px;">
  <div class="row py-lg-5">
    <div class="col-lg-6 col-md-8 mx-auto">
      <br><h1 class="fw-light">* * * * *  Review  * * * * *</h1><br>
    </div>
  </div>
</section>
			<table class="table table-bordered" style="margin-top: -80px;">
			    <tr>
			    	<th class="table-dark" width=15%>작성자</th>
			    	<td style="text-align:left" width=35%><%=name%></td>
			    	<th class="table-dark" width=15%>조회수</th>
			    	<td style="text-align:left" width=35%><%=rb.getRead()%></td>
			    </tr>
			    <tr>
			    	<th class="table-dark">동물이름</th>
			    	<td style="text-align:left"><%=rb.getAname()%></td>
			    	<th class="table-dark">작성일</th>
			    	<td style="text-align:left"><%=rb.getDay()%></td>
			    </tr>
			    <tr>
			    	<th class="table-dark align-middle">제목</th>
					<td width=25% colspan=3 style="text-align:left"><%=rb.getTitle()%></td>
			    </tr>
			    <tr>
			    	<th class="table-dark align-middle">이미지</th>
			    	<td colspan=3><img src="<%=request.getContextPath()%>/images/<%=rb.getImg()%>" height=200></td>
			    </tr>
			    <tr>
			    	<th class="table-dark align-middle">내용</th>
			    	<td class="align-middle" style="text-align:left" colspan=3 height="200px"><%=rb.getContent()%></td> 
			    </tr>
			</table>
	<div style="text-align: right; margin-right:150px;">
	<%
	if(session.getAttribute("no")!=null){
		if((int)(session.getAttribute("no"))==rb.getMno()){
	%>
		<input type="button" class="btn btn-outline-dark" onclick="delReview(<%=rb.getNum()%>)" value="삭제하기">
		<input type="button" class="btn btn-outline-dark" onclick="location.href='review_update.jsp?num=<%=rb.getNum()%>'" value="수정하기">
	<%
		}
	}
	%>
		<input type="button" class="btn btn-dark" onclick="location.href='review.jsp'" value="목록보기">
	</div>
</div>
<br><br>

<%@ include file="../bottom.jsp"%>