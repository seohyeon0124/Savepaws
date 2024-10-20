<%@page import="my.animal.AnicateBean"%>
<%@page import="my.animal.AnicateDao"%>
<%@page import="my.animal.AnimalBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.animal.AnimalDao"%>
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
	#black {
		text-decoration: none;
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
	function deleteAnimal(anum,img){
		var flag = confirm("정말로 삭제하시겠습니까?");
		if(flag){			
			location.href = "deleteAnimal.jsp?anum="+anum+"&img="+img;
		} else{
			location.href = "animalList.jsp";
		}
	}
</script>

<%
	request.setCharacterEncoding("UTF-8");
	String cate = request.getParameter("cate");
	String state = request.getParameter("state");
	String search = request.getParameter("search");
	
	System.out.println("cate1 : " + cate);
	System.out.println("state1 : " + state);
	System.out.println("search1 : " + search);
	
	if(cate==null){
		cate = "전체";
	}
	if(state==null){
		state = "상태";
	}
	if(search==null){
		search = "없음";
	}
	
	System.out.println("cate2 : " + cate);
	System.out.println("state2 : " + state);
	System.out.println("search2 : " + search);
	
	AnicateDao catedao = AnicateDao.getInstance();
	AnimalDao adao = AnimalDao.getInstance();
%>
<form method="post" action="animalList.jsp">
    <div class="d-flex justify-content-center" style="width: 100%;">
        <div class="d-flex align-items-center justify-content-between" style="width: 80%;">
            <h3>동물 확인</h3>
            <div class="d-flex align-items-center">
                <div>
                    <select name="cate" class="form-select" aria-label="Default select example">
                        <option value="전체" selected>카테고리</option>
                        <% 
                        ArrayList<AnicateBean> cateList = catedao.getAllAnicate();
                        for(AnicateBean ab : cateList){
                        %>
                            <option value="<%=ab.getCatecode()%>"><%=ab.getCatename()%></option>
                        <%
                        }
                        %>
                    </select>
                </div>&nbsp;&nbsp;
                <div>
                    <select name="state" class="form-select" aria-label="Default select example">
                        <option value="상태" selected>상태</option>
                        <% 
                        String[] stateArr = {"구조", "임시보호", "입양", "안락사", "자연사"};
                        for(String s : stateArr){
                        %>
                            <option value="<%=s%>"><%=s%></option>
                        <%
                        }
                        %>
                    </select>
                </div>
                <div class="ms-3 d-flex" role="search">
                    <input name="search" class="form-control me-2" type="search" placeholder="종류 검색" aria-label="Search">
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
    	<th>번호</th>
    	<th>카테고리</th>
    	<th>종류</th>
    	<th>이미지</th>
    	<th>상태</th>
    	<th>삭제</th>
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
  	
  	if(cate.equals("전체")){
		count = adao.getAnimalCount();   
	}else{
    	count = adao.getAnimalCountByCate(cate,state,search);  
	}
	System.out.println("count:" + count);
  
  	ArrayList<AnimalBean> list = adao.getAnimal(cate,state,search,startRow,endRow); 
  	for(AnimalBean ab : list){
  %>
   	<tr>
   		<td class="align-middle"><%=ab.getAnum()%></td>
   		<td class="align-middle"><%=ab.getCate()%></td>
   		<td class="align-middle"><%=ab.getKind()%></td>
   		<td class="align-middle">
   			<a href="animalView.jsp?anum=<%=ab.getAnum()%>">
   				<img src="<%=request.getContextPath()%>/images/<%=ab.getImg()%>" width=50 height=50>
			</a>
   		</td>
   		<td class="align-middle"><%=ab.getState()%></td>
   		<td class="align-middle"><a href="javascript:deleteAnimal('<%=ab.getAnum()%>','<%=ab.getImg()%>')" id="red">삭제</a></td>
   	</tr>
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
		      <a class="page-link" href="animalList.jsp?pageNum=<%=startPage-pageBlock%>" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		      </a>
		    </li>
<%
		}
		for(int i=startPage; i<=endPage; i++){
%>
			<li class="page-item"><a class="page-link" href="animalList.jsp?pageNum=<%=i%>&cate=<%=cate%>&state=<%=state%>&search=<%=search%>"><%=i%></a></li>
<%			
		}
		if(endPage < pageCount){
%> 
			<li class="page-item">
		      <a class="page-link" href="animalList.jsp?pageNum=<%=startPage+pageBlock%>" aria-label="Next">
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
    