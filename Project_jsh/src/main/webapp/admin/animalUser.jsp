<%@page import="my.animal.RequestDao"%>
<%@page import="my.animal.AnimalBean"%>
<%@page import="my.animal.AnicateBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.animal.AnimalDao"%>
<%@page import="my.animal.AnicateDao"%>
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
	td #gray {
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

<script>
	function yes(reqno){
		if(confirm("승인처리 하시겠습니까?")){
			location.href = "requestProc.jsp?reqno="+reqno+"&state=승인";
		}
	}
	function no(reqno){
		if(confirm("거절처리 하시겠습니까?")){
			location.href = "requestProc.jsp?reqno="+reqno+"&state=거절";
		}
	}
</script>

<form method="post" action="animalUser.jsp">
    <div class="d-flex justify-content-center" style="width: 100%;">
        <div class="d-flex align-items-center justify-content-between" style="width: 80%;">
        <h3>동물 신청</h3>
            <div class="d-flex align-items-center">
                <div>
                    <select name="state" class="form-select" aria-label="Default select example">
                        <option value="상태" selected>전체</option>
                        <% 
                        String[] stateArr = {"신청", "승인", "거절"};
                        for(String s : stateArr){
                        %>
                            <option value="<%=s%>"><%=s%></option>
                        <%
                        }
                        %>
                    </select>
                </div>
                <div class="ms-3 d-flex" role="search">
                    <input name="search" class="form-control me-2" type="search" placeholder="회원번호 검색" aria-label="Search">
                    <button class="btn btn-outline-success" type="submit">Search</button>
                </div>
            </div>
        </div>
    </div>
</form>

	<table class="table table-bordered">
		<tr>
			<th class="table-dark" width=10%>신청번호</th>
			<th class="table-dark" width=10%>회원번호</th>
			<th class="table-dark" width=10%>동물번호</th>
			<th class="table-dark" width=25%>동물종류</th>
			<th class="table-dark" width=15%>이미지</th>
			<th class="table-dark" width=15%>신청상태</th>
			<th class="table-dark" width=15%>승인 | 거절</th>
		</tr>
		<%
			RequestDao rdao = RequestDao.getInstance();
			String state = request.getParameter("state");
			String search = request.getParameter("search");
			System.out.println("1:"+state+","+search);
			if(state==null){
				state = "상태";
			}
			if(search==null||search.equals("")){
				search = "없음";
			}
			System.out.println("2:"+state+","+search);
			int pageSize = 10; // 한페이지에 보여줄 게시물 개수
		  	
		  	String pageNum = request.getParameter("pageNum"); // 현재 페이지번호
		  	if(pageNum == null){
		  		pageNum = "1"; // 처음엔 1페이지를 보여주도록 함
		  	}
		  	
		  	int currentPage = Integer.parseInt(pageNum); // 현재 페이지번호 (데이터형식만 사용할수있게 바꿈)
		  	int startRow = (currentPage-1)*pageSize+1; // 페이지 최소번호
		  	int endRow = currentPage*pageSize; // 페이지 최대번호
		  	
		  	int count = 0; // 전체 게시물 개수
		  	count = rdao.getRequestCount(state,search); 
		  	
			System.out.println("count:" + count);
		
			
			ArrayList<AnimalBean> list = rdao.getAllRequest(state,search,startRow,endRow);
			MemberDao mdao = MemberDao.getInstance();
			String no = String.valueOf(session.getAttribute("no"));

			if(list.size()>0){
				for(AnimalBean ab : list){
					String name = mdao.getNameByNo(ab.getColor());
		%>
				<tr>
					<td class="align-middle"><%=ab.getAge()%></td> <!-- 잠깐만 reqno 담는 용도로 사용 -->
					<td class="align-middle"><a href="userList.jsp?search=<%=name%>" id="gray"><%=ab.getColor()%>[<%=name%>]</a></td> <!-- 잠깐만 memno 담는 용도로 사용 -->
					<td class="align-middle"><%=ab.getAnum()%></td>
					<td class="align-middle"><%=ab.getKind()%></td>
					<td class="align-middle">
						<a href="animalView.jsp?anum=<%=ab.getAnum()%>">
							<img src="<%=request.getContextPath()%>/images/<%=ab.getImg()%>" height=50>
						</a>
					</td>
					<td class="align-middle">
						<%if(ab.getState().equals("신청")){%><font color=green><b><%=ab.getState()%></b></font><%}%>
						<%if(ab.getState().equals("거절")){%><font color=red><b><%=ab.getState()%></b></font><%}%>
						<%if(ab.getState().equals("승인")){%><font color=blue><b><%=ab.getState()%></b></font><%}%>
					</td>
					<td class="align-middle">
						<a id="gray" href="javascript:yes(<%=ab.getAge()%>)">승인</a> | 
						<a id="gray" href="javascript:no(<%=ab.getAge()%>)">거절</a>					
					</td>
				</tr>
		<%
				}
			} else{
		%>
				<tr>
					<td colspan=8 class="align-middle" height=100><b>신청 동물이 없습니다</b></td>
					
				</tr>
		<%
			}
		%>
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
		      <a class="page-link" href="animalUser.jsp?pageNum=<%=startPage-pageBlock%>" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		      </a>
		    </li>
<%
		}
		for(int i=startPage; i<=endPage; i++){
%>
			<li class="page-item"><a class="page-link" href="animalUser.jsp?pageNum=<%=i%>"><%=i%></a></li>
<%			
		}
		if(endPage < pageCount){
%> 
			<li class="page-item">
		      <a class="page-link" href="animalUser.jsp?pageNum=<%=startPage+pageBlock%>" aria-label="Next">
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