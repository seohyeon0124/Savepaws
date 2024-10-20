 <%@page import="my.animal.RequestDao"%>
<%@page import="my.animal.AnimalBean"%>
<%@page import="my.animal.AnimalDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../top.jsp"%>
<%@ include file="animal_top.jsp"%> 

<style>
  .dimmed {
    opacity: 0.5; /* 어둡게 처리 */
  }
.btn-danger {
    background-color: gold !important;
    border-color: gold !important;
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
    color: white; /* 활성 링크 텍스트 색상을 흰색으로 변경 */
    background-color: black; /* 활성 링크 배경 색상을 검정으로 변경 */
    border-color: black; /* 활성 링크 테두리 색상을 검정으로 변경 */
}

</style>
<%
	String no = String.valueOf(session.getAttribute("no"));
	if(no==null){
%>
	<script>
	alert("세이브포스 회원만 이용 가능합니다");
	location.href = "../main.jsp";
	</script>
<%
	}

	request.setCharacterEncoding("UTF-8");
	String cate = request.getParameter("cate");
	AnimalDao anidao = AnimalDao.getInstance();
	
	String state = request.getParameter("state");
	String search = request.getParameter("search");
	if(cate==null){
		cate = "전체";
	}
	if(state==null){
		state = "상태";
	}
	if(search==null){
		search = "없음";
	} 
%>
<form method="post" action="animal.jsp?cate=<%=cate%>">
<div class="album py-5 bg-body-tertiary">
    <div class="container">
        <div class="d-flex align-items-center justify-content-between">
            <h3><%if(cate.equals("전체")){%>ALL<%}else{%><%=cate.toUpperCase()%><%}%></h3>
            <div class="d-flex align-items-center">
                <div>
                    <select name="state" class="form-select" aria-label="Default select example">
                        <option value="상태" <%if(state.equals("상태")){%>selected<%}%>>전체</option>
                        <% 
                        String[] stateArr = {"구조", "임시보호", "입양", "안락사", "자연사"};
                        for(String s : stateArr){
                        %>
                            <option value="<%=s%>" <%if(state.equals(s)){%>selected<%}%>><%=s%></option>
                        <%
                        }
                        %>
                    </select>
                </div>
                <div class="ms-3 d-flex" role="search">
                    <input name="search" <%if(!search.equals("없음")){%>value="<%=search%>"<%}%> class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                    <button class="btn btn-outline-success" type="submit">Search</button>
                </div>
            </div>
      </div>
	  <br>
      <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-3">
      <%
      int pageSize = 12; // 한페이지에 보여줄 게시물 개수
    	
    	String pageNum = request.getParameter("pageNum"); // 현재 페이지번호
    	if(pageNum == null){
    		pageNum = "1"; // 처음엔 1페이지를 보여주도록 함
    	}
    	
    	int currentPage = Integer.parseInt(pageNum); // 현재 페이지번호 (데이터형식만 사용할수있게 바꿈)
    	int startRow = (currentPage-1)*pageSize+1; // 페이지 최소번호
    	int endRow = currentPage*pageSize; // 페이지 최대번호
    	
    	int count = 0; // 전체 게시물 개수
    	
    	if(cate.equals("전체")){
    		count = anidao.getAnimalCount();   
    	}else{
	    	count = anidao.getAnimalCountByCate(cate,state,search);   
    	}
    	System.out.println("count:" + count);
    
    	ArrayList<AnimalBean> list = anidao.getAnimal(cate,state,search,startRow,endRow); 
		if(list.size()>0){
	      	for(AnimalBean ab : list){
	      	boolean flag = ab.getState().equals("입양")||ab.getState().equals("안락사")||ab.getState().equals("자연사");
	  %>
	      	<div class="col">
	          <div class="card shadow-sm <%if(flag){%>dimmed<%}%>">
	          	<div class="bd-placeholder-img card-img-top" align=center>
	          	  <%if(!flag){%><a href="animalView.jsp?anum=<%=ab.getAnum()%>&cate=<%=cate%>&state=<%=state%>&search=<%=search%>"><%}%>
	          		<img src="<%=request.getContextPath()%>/images/<%=ab.getImg()%>" height="200" role="img" aria-label="Placeholder: Thumbnail">
	              <%if(!flag){%></a><%}%>
	            </div>
	            <div class="card-body">
	              <p class="card-text">
	              	[ <%=ab.getCate()%> ] <%=ab.getKind()%> - <%=ab.getState()%>
	              </p>
	              <div class="d-flex justify-content-between align-items-center">
	                <div class="btn-group">
	                <%
	                	
	                	MemberDao mdao = MemberDao.getInstance();
	                	String anilike = mdao.getAni(no,String.valueOf(ab.getAnum()));
	                	
	                	if(anilike!=null){
	                %>
	                	<button type="button" class="btn btn-sm btn-danger" <%if(flag){%>disabled<%}%> onclick="location.href='anilikeBtn.jsp?anum=<%=ab.getAnum()%>&cate=<%=cate%>&state=<%=state%>&search=<%=search%>'">&nbsp;♥&nbsp;</button>
	                <%
	                	} else{
					%>	                		
	                	<button type="button" class="btn btn-sm btn-outline-secondary" <%if(flag){%>disabled<%}%> onclick="location.href='anilikeBtn.jsp?anum=<%=ab.getAnum()%>&cate=<%=cate%>&state=<%=state%>&search=<%=search%>'">관심</button>
	                <%
	                	}
	                	
	                	RequestDao rdao = RequestDao.getInstance();
	                	String reqState = rdao.getRequestByNo(no,String.valueOf(ab.getAnum()));
	                	if(reqState!=null){
	                %>	                	
	                  <button type="button" class="btn btn-sm btn-success" <%if(flag){%>disabled<%}%> onclick="location.href='animalView.jsp?anum=<%=ab.getAnum()%>&cate=<%=cate%>&state=<%=state%>&search=<%=search%>'"><%=reqState%></button>	                	
	                <%
	                	} else{
	                %>
	                  <button type="button" class="btn btn-sm btn-outline-secondary" <%if(flag){%>disabled<%}%> onclick="location.href='animalView.jsp?anum=<%=ab.getAnum()%>&cate=<%=cate%>&state=<%=state%>&search=<%=search%>'">신청</button>	                	
	                <%
	                	}
	                %>
	                </div>
	                <small class="text-body-secondary">구조일 <%=ab.getDay()%></small>
	              </div>
	            </div>
	          </div>
	        </div>
	  <%
      	    }
		} else{
	  %>
      </div> <br><br>
	  		<div style="text-align: center">
				<font color=gray size=5>등록된 동물들이 없습니다</font>
			</div>
	  <%
		}
      %>
    </div>
  </div>
</form>
<br><br>
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
		      <a class="page-link" href="animal.jsp?pageNum=<%=startPage-pageBlock%>" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		      </a>
		    </li>
<%
		}
		for(int i=startPage; i<=endPage; i++){
%>
			<li class="page-item"><a class="page-link" href="animal.jsp?pageNum=<%=i%>&cate=<%=cate%>&state=<%=state%>&search=<%=search%>"><%=i%></a></li>
<%			
		}
		if(endPage < pageCount){
%> 
			<li class="page-item">
		      <a class="page-link" href="animal.jsp?pageNum=<%=startPage+pageBlock%>" aria-label="Next">
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
  
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    

<%@ include file="../bottom.jsp"%>
    