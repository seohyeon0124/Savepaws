<%@page import="java.text.DecimalFormat"%>
<%@page import="my.member.MemberBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../top.jsp"%> 
<%@ include file="admin_top.jsp"%>

<style>
	.table{
		width: 80%;
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
	#gray {
		text-decoration: none;
		color: gray; 
	}
	#gray:hover{
		color: black;
	}
	/* 페이지네이션 링크 기본 스타일 */
	.pagination .page-link {
	    color: black; /* 텍스트 색상을 검정으로 변경 */
	    background-color: #fff; /* 배경 색상을 흰색으로 변경 */
	    border: 1px solid #dee2e6; /* 테두리 색상 유지 */
	}
	
	/* 페이지네이션 링크 호버 상태 스타일 */
	.pagination .page-link:hover {
	    color: white; /* 호버 시 텍스트 색상을 흰색으로 변경 */
	    background-color: black; /* 호버 시 배경 색상을 검정으로 변경 */
	    border-color: black; /* 호버 시 테두리 색상을 검정으로 변경 */
	}
	
	/* 활성 페이지 링크 스타일 */
	.pagination .page-item.active .page-link {
	    color: red; /* 텍스트 색상을 흰색으로 변경 */
	    background-color: #000; /* 배경 색상을 검정색으로 변경 */
	    border-color: #000; /* 테두리 색상을 검정색으로 변경 */
	}
</style>

<%
	request.setCharacterEncoding("UTF-8");
	String search = request.getParameter("search");
	
	System.out.println("search1 : " + search);
	
	if(search==null){
		search = "없음";
	}
	
	System.out.println("search2 : " + search);
	
	MemberDao mdao = MemberDao.getInstance();
%>
<form method="post" action="userList.jsp">
    <div class="d-flex justify-content-center" style="width: 100%;">
        <div class="d-flex align-items-center justify-content-between" style="width: 80%;">
            <h3>회원 확인</h3>
            <div class="d-flex align-items-center">
                <div class="ms-3 d-flex" role="search">
                    <input name="search" class="form-control me-2" type="search" placeholder="회원이름 검색" aria-label="Search">
                    <button class="btn btn-outline-success" type="submit">Search</button>
                </div>
            </div>
        </div>
    </div>
</form>
<br>
<table class="table ">
  <thead class="table-dark">
    <tr>
    	<th>회원번호</th>
    	<th>회원이름</th>
    	<th>아이디</th>
    	<th>성별</th>
    	<th>전화번호</th>
    	<th>신청내역</th>
    </tr>
  </thead>
  <tbody>
  <%
  	int pageSize = 10; // 한페이지에 보여줄 게시물 개수
  	
  	String pageNum = request.getParameter("pageNum"); // 현재 페이지번호
  	if(pageNum == null){
  		pageNum = "1"; // 처음엔 1페이지를 보여주도록 함
  	}
  	
  	int currentPage = Integer.parseInt(pageNum); // 현재 페이지번호 (데이터형식만 사용할수있게 바꿈)
  	int startRow = (currentPage-1)*pageSize+1; // 페이지 최소번호
  	int endRow = currentPage*pageSize; // 페이지 최대번호
  	
  	int count = 0; // 전체 게시물 개수
  	
  	if(search.equals("없음")){
		count = mdao.getMemberCount();   
	}else{
    	count = mdao.getMemberCountByName(search);   
	}
	System.out.println("count:" + count);
  
  	ArrayList<MemberBean> list = mdao.getMember(search,startRow,endRow);  
  	if(list.size()>0){
	  	for(MemberBean mb : list){
  %>
	   	<tr>
	   		<td class="align-middle"><%=mb.getNo()%></td>
	   		<td class="align-middle"><%=mb.getName()%></td>
	   		<td class="align-middle"><%=mb.getEmail()%></td>
	   		<td class="align-middle"><%=mb.getGender()%></td>
	   		<td class="align-middle"><%=mb.getPhone()%></td>
	   		<td class="align-middle"><a href="animalUser.jsp?search=<%=mb.getNo()%>" id="gray">보기</a></td>
	   	</tr>
  <%
  		}
  	}else{
  %>
  	<script type="text/javascript">
  		alert("일치하는 회원정보가 없습니다");
  		location.href="userList.jsp";
  	</script>
  <%
  	}
  %>
  </tbody>
</table>

<div class="align-items-center" style="display: flex; justify-content: center;">
<nav aria-label="Page navigation example">
  <ul class="pagination">
<%
	if(count>0){
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		int pageBlock = 5;
		int startPage = ((currentPage-1) / pageBlock * pageBlock) + 1;
		int endPage = startPage + pageBlock - 1;
		if(endPage > pageCount){
			endPage = pageCount;
		}
		
		if(startPage > pageBlock){
%> 
			<li class="page-item">
		      <a class="page-link" href="userList.jsp?pageNum=<%=startPage-pageBlock%>" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		      </a>
		    </li>
<%
		}
		for(int i=startPage; i<=endPage; i++){
%>
			<li class="page-item"><a class="page-link" href="userList.jsp?pageNum=<%=i%>"><%=i%></a></li>
<%			
		}
		if(endPage < pageCount){
%> 
			<li class="page-item">
		      <a class="page-link" href="userList.jsp?pageNum=<%=startPage+pageBlock%>" aria-label="Next">
		        <span aria-hidden="true">&raquo;</span>
		      </a>
		    </li>
<%			
		}
	}
%>
</ul>
</nav>
		</div>

<%@ include file="admin_bottom.jsp"%>
<%@ include file="../bottom.jsp"%>    
    
    