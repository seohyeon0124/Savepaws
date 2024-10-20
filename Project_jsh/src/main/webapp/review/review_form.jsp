<%@page import="my.animal.AnimalBean"%>
<%@page import="my.animal.AnimalDao"%>
<%@page import="my.animal.RequestBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.animal.RequestDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ include file="../top.jsp"%>
<br><br><br><br><br>

<%
	String no = String.valueOf(session.getAttribute("no"));
	MemberDao mdao = MemberDao.getInstance();
	String name = mdao.getMemberNameByNo(no);
%>

<div style="width:1300px; height:700px; margin:auto; padding:50px; border:1px solid black;">
<form method="post" action="reviewProc.jsp?mno=<%=no%>" enctype="multipart/form-data">
	<h3>Review 작성</h3> <br>
	<div class="input-group mb-3">
	  <span class="input-group-text" id="inputGroup-sizing-default">작성자</span>
	  <input type="text" value="<%=name%>" disabled class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
	</div>
	<div class="input-group mb-3">
	  <span class="input-group-text" id="inputGroup-sizing-default">동물</span>
	  <input type="text" name="aname" placeholder="동물의 이름을 작성해주세요" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
	  <select class="form-select" name="plus" aria-label="Default select example">
  		<option value="선택" selected>입양 또는 임시보호 중인 동물을 선택하세요</option>
	<% 
		RequestDao rdao = RequestDao.getInstance();
		ArrayList<RequestBean> list = rdao.getRequestByNo(no);
		for(RequestBean rb : list){
			AnimalDao adao = AnimalDao.getInstance();
			AnimalBean ab = adao.getAnimalByAnum(String.valueOf(rb.getAnino()));
	%>
		<option value="<%=ab.getKind()%>">[<%=rb.getAnino()%>] <%=ab.getKind()%></option>
	<%
		}
	%>
	  </select>
	</div>
	<div class="input-group mb-3">
	  <span class="input-group-text" id="inputGroup-sizing-default">제목</span>
	  <input type="text" name="title" class="form-control" placeholder="제목을 작성해주세요" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
	</div>
	<div class="input-group mb-3">
	  <input type="file" name="img" class="form-control" id="inputGroupFile02">
	  <label class="input-group-text" for="inputGroupFile02">이미지</label>
	</div>
	<div class="input-group">
		<span class="input-group-text"><b>내용</b></span>
		<textarea class="form-control" name="content" placeholder="내용을 작성해주세요" aria-label="With textarea" cols=100 rows=10></textarea>
	</div>
	<br>
	<div style="text-align: right;">
		<input type="reset" class="btn btn-dark" value="다시쓰기">
		<input type="submit" class="btn btn-dark" value="작성하기">
	</div>
</form>
</div>

<br><br>
<%@ include file="../bottom.jsp"%>
    