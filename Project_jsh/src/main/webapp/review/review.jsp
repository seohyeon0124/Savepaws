<%@page import="my.review.ReviewBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.review.ReviewDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../top.jsp"%>
	
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
	
<script>
	function delReview(num){
		if(confirm('리뷰를 삭제하시겠습니까?')){
			location.href = "review_delete.jsp?num="+num;
		} else{
			location.href = "review.jsp";
		}
	}
	function review(no){
		if(no!=null){
			location.href = "review_form.jsp";
		}else{
			alert("세이브포스 회원만 이용 가능합니다");
		}
	}
</script>

<%
	Object no = session.getAttribute("no");
%>

<section class="py-5 text-center container">
  <div class="row py-lg-5">
    <div class="col-lg-6 col-md-8 mx-auto" style="margin-bottom:-50px;">
      <br><h1 class="fw-light">Review</h1><br>
      <p class="lead text-body-secondary">세이브포스를 통해 이루어진 만남들을 확인하세요<br>나에게도 멋진 짝이 기다리고 있을 수 있습니다</p>
	      <p>
	      <a href="javascript:review(<%=no%>)" class="btn btn-dark my-2">리뷰 남기기</a>
	      <a href="../animal/animal.jsp" class="btn btn-secondary my-2">동물 보러가기</a>
      </p>
    </div>
  </div>
</section>

<div class="album py-5 bg-body-tertiary">
  <div class="container">

      
<%
	ReviewDao rdao = ReviewDao.getInstance();

	int pageSize = 9;
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage-1)*pageSize+1;
	int endRow = currentPage*pageSize;
	int count = rdao.getAllReviewCount(); 

	ArrayList<ReviewBean> list = rdao.getAllReview(startRow,endRow);
	if(list.size()>0){
%>
    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
<%
		for(ReviewBean rb : list){
			long day = rdao.getDay(rb.getNum());
			String content;
	        if (rb.getContent().length() > 59) {
	            content = rb.getContent().substring(0,60)+" ...";
	        } else {
	            content = rb.getContent();
	        }
%>
		<div class="col">
          <div class="card shadow-sm">
            <div class="bd-placeholder-img card-img-top" align=center>
	          	  <a href="review_view.jsp?num=<%=rb.getNum()%>">
	          		<img src="<%=request.getContextPath()%>/images/<%=rb.getImg()%>" height="200" role="img" aria-label="Placeholder: Thumbnail">
	              </a>
	            </div>
            <div class="card-body">
              <p class="card-text"><%=rb.getTitle()%></p>
              <p class="card-text"><font color=gray size=2><%=content%></font></p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <%
                  if(no!=null){
                  	if((int)no==rb.getMno()){%>
                  	<button type="button" onclick="location.href='review_update.jsp?num=<%=rb.getNum()%>'" class="btn btn-sm btn-outline-secondary">수정</button>
                  	<button type="button" onclick="delReview(<%=rb.getNum()%>)" class="btn btn-sm btn-outline-secondary">삭제</button>
                  <%}
                  }%>
                </div>
                <small class="text-body-secondary"><%if(day==0){%>오늘<%}else{%><%=day%>일 전<%}%></small>
              </div>
            </div>
          </div>
        </div>
<%	
		}
	} else{
%>
		<div style="text-align: center">
			<br><br>
			<font color=gray size=5>가장 먼저 리뷰를 작성해주세요!</font>
		</div>
<%
	}
%>
    </div>

<br><br>  
<div class="align-items-center" style="display: flex; justify-content: center;">
<nav aria-label="Page navigation example">
		<ul class="pagination" >
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
						<a class="page-link" href="review.jsp?pageNum=<%=startPage-pageBlock%>" aria-label="Previous">
							 <span aria-hidden="true">&laquo;</span>
						 </a>
					</li>
<%
				}
				for(int i=startPage; i<=endPage; i++){
%>
					<li class="page-item"><a class="page-link" href="review.jsp?pageNum=<%=i%>"><%=i%></a></li>
<%			
				}
				if(endPage < pageCount){
%> 
					<li class="page-item">
						<a class="page-link" href="review.jsp?pageNum=<%=startPage+pageBlock%>" aria-label="Next">
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
	
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>



<%@ include file="../bottom.jsp"%>