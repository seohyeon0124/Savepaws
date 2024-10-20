<%@page import="my.review.ReviewBean"%>
<%@page import="my.review.ReviewDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../top.jsp"%>
<br><br><br><br><br>

<%
	String no = String.valueOf(session.getAttribute("no"));
	MemberDao mdao = MemberDao.getInstance();
	String name = mdao.getMemberNameByNo(no);

	String num = request.getParameter("num");
	
	ReviewDao rdao = ReviewDao.getInstance();
	ReviewBean rb = rdao.getReview(num);
	String title = rdao.getTitle(num);
	String kind = rb.getTitle().replace(title,"");
	kind = kind.replace("[","");
	kind = kind.replace("]","");
%>

<div style="width:1000px; height:700px; margin:auto; padding:50px; border:1px solid black;">
<form method="post" action="review_updateProc.jsp?mno=<%=no%>&num=<%=rb.getNum()%>" enctype="multipart/form-data">
	<h3>Review 수정</h3> <br>
	<div class="input-group mb-3">
	  <span class="input-group-text" id="inputGroup-sizing-default">작성자</span>
	  <input type="text" value="<%=name%>" disabled class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
	</div>
	<div class="input-group mb-3">
	  <span class="input-group-text" id="inputGroup-sizing-default">동물</span>
	  <input type="text" disabled value="<%=rb.getAname()%>" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
	  <input type="text" disabled name="aname" value="<%=kind%>" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
	  <input type="hidden" name="aname" value="<%=kind%>" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
	</div>
	<div class="input-group mb-3">
	  <span class="input-group-text" id="inputGroup-sizing-default">제목</span>
	  <input type="text" name="title" value="<%=title%>" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
	</div>
	<div class="input-group mb-3">
	  <input type="hidden" name="orimg" value="<%=rb.getImg()%>" class="form-control" id="inputGroupFile02">
	  <input type="file" name="img" class="form-control" id="inputGroupFile02">
	  <label class="input-group-text" for="inputGroupFile02">이미지</label>
	</div>
	<div class="input-group">
		<span class="input-group-text"><b>내용</b></span>
		<textarea class="form-control" name="content" aria-label="With textarea" rows=10><%=rb.getContent()%></textarea>
	</div>
	<br>
	<div style="text-align: right;">
		<input type="submit" class="btn btn-outline-dark" value="수정하기">
		<input type="button" class="btn btn-dark" value="돌아가기" onclick="location.href='review_view.jsp?num=<%=rb.getNum()%>'">
	</div>
</form>
</div>


<br><br>
<%@ include file="../bottom.jsp"%>
    