<%@page import="my.free.FreeBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.free.FreeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../top.jsp"%>
<%@ include file="free_top.jsp"%>

<%
	String city = request.getParameter("city");
	if(city==null){ 
		city = "전체";
	}
	String place = request.getParameter("place");
	if(place==null){
		place = "전체";
	}
%>

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
	function updatePlaces() {
	    var citySelect = document.getElementById("citySelect");
	    var placeSelect = document.getElementById("placeSelect");
	    var selectedCity = citySelect.value;
	    
	    var places = {
	        "서울": ["종로구","중구","용산구","성동구","광진구","동대문구","중랑구","성북구","강북구","도봉구","노원구","은평구","서대문구","마포구","양천구","강서구","구로구","금천구","영등포구","동작구","관악구","서초구","강남구","송파구","강동구"],
	        "부산": ["중구","서구","동구","영도구","부산진구","동래구","남구","북구","강서구","해운대구","사하구","금정구","연제구","수영구","사상구","기장군"],
	        "대구": ["중구","서구","동구","남구","북구","수성구","달서구","달성군"],
	        "인천": ["중구","동구","미추홀구","연수구","남동구","부평구","계양구","서구","강화군","옹진군"],
	        "광주": ["동구","서구","남구","북구","광산구"],
	        "대전": ["동구","중구","서구","유성구","대덕구"],
	        "울산": ["중구","남구","동구","북구","울주군"],
	        "세종": ["조치원읍","연기면","부강면","금남면","장군면","연서면","전의면","전동면","소정면","한솔동","새롬동","나성동","다정동","도담동","어진동","해밀동","아름동","종촌동","고운동","보람동","대평동","소담동","반곡동"],
	        "경기": ["수원","성남","의정부","안양","부천","광명","동두천","평택","안산","고양","과천","구리","남양주","오산","시흥","군포","의왕","하남","용인","파주","이천","안성","김포","화성","광주","양주","포천","여주","연천","가평","양평"],
	        "강원": ["춘천","원주","강릉","동해","태백","속초","삼척","홍천","횡성","영월","평창","정선","철원","화천","양구","인제","고성","양양"],
	        "충북": ["청주","충주","제천","보은","옥천","영동","증평","진천","괴산","음성","단양"],
	        "충남": ["천안","공주","보령","아산","서산","논산","계룡","당진","금산","부여","서천","청양","홍성","예산","태안"],
	        "전북": ["전주","군산","익산","정읍","남원","김제","완주","진안","무주","장수","임실","순창","고창","부안"],
	        "전남": ["목포","여수","순천","나주","광양","담양","곡성","구례","고흥","보성","화순","장흥","강진","해남","영암","무안","함평","영광","장성","완도","진도","신안"],
	        "경북": ["포항","경주","김천","안동","구미","영주","영천","상주","문경","경산","의성","청송","영양","영덕","청도","고령","성주","칠곡","예천","봉화","울진","울릉"],
	        "경남": ["창원","진주","통영","사천","김해","밀양","거제","양산","의령","함안","창녕","고성","남해","하동","산청","함양","거창","합천"],
	        "제주": ["제주","서귀포"]
	    };
	    
	    // 기존의 옵션 제거
	    placeSelect.innerHTML = '<option value="전체">전체</option>';
	    
	    // 선택된 도시에 따라 옵션 추가
	    if(places[selectedCity]) {
	        places[selectedCity].forEach(function(place) {
	            var option = new Option(place, place);
	            if(place === "<%=place%>") option.selected = true;
	            placeSelect.add(option);
	        });
	    }
	    
	}
</script>

<div class="container">
    <form method="post" action="free_place.jsp" id="searchForm"><br>
        <div class="d-flex align-items-center justify-content-start">
            <h3>지역별 검색</h3>&nbsp;&nbsp;&nbsp;
            <div class="d-flex align-items-center">
                <div>
                    <select name="city" class="form-select" aria-label="Default select example" id="citySelect" onchange="updatePlaces()">
                        <% 
                        String[] citys = {"전체","서울","부산","대구","인천","광주","대전","울산","세종","경기","강원","충북","충남","전북","전남","경북","경남","제주"};
                        for(String s : citys){
                        %>
                            <option value="<%=s%>"><%=s%></option>
                        <%
                        }
                        %>
                    </select>
                </div>
            </div>&nbsp;&nbsp;
            <div class="d-flex align-items-center" >
                <div>
                    <select name="place" class="form-select" aria-label="Default select example" id="placeSelect" onchange="document.getElementById('searchForm').submit();" style="width: 100px;">
                        <option value="전체">전체</option>
                        <!-- 자바스크립트를 통해 동적으로 옵션 추가 -->
                    </select>
                </div>
            </div>
        </div>
    </form>
  
  <br>
      <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-3">
      <%
      FreeDao fdao = FreeDao.getInstance();
      
      int pageSize = 12; // 한페이지에 보여줄 게시물 개수
    	
    	String pageNum = request.getParameter("pageNum"); // 현재 페이지번호
    	if(pageNum == null){
    		pageNum = "1"; // 처음엔 1페이지를 보여주도록 함
    	}
    	
    	int currentPage = Integer.parseInt(pageNum); // 현재 페이지번호 (데이터형식만 사용할수있게 바꿈)
    	int startRow = (currentPage-1)*pageSize+1; // 페이지 최소번호
    	int endRow = currentPage*pageSize; // 페이지 최대번호
    	
    	int count = 0; // 전체 게시물 개수
    	
    	if(city.equals("전체")){
    		count = fdao.getAllCount();  
    		System.out.println("count1:" + count);
    	}else{
    		if(place.equals("전체")){    			
		    	count = fdao.getCityCount(city); 
		    	System.out.println("count2:" + count);
    		}else{
    			count = fdao.getPlaceCount(place); 
    			System.out.println("count3:" + count);
    		}
    	}
    
    	ArrayList<FreeBean> list = fdao.getFree(city,place,startRow,endRow); 
		if(list.size()>0){
	      	for(FreeBean fb : list){ 
	      	boolean flag = fb.getState().equals("신청");
	  %>
	      	<div class="col">
	          <div class="card shadow-sm <%if(flag){%>dimmed<%}%>">
	          	<div class="bd-placeholder-img card-img-top" align=center>
	          	  <%if(!flag){%><a href="freeView.jsp?no=<%=fb.getNo()%>&city=<%=city%>&place=<%=place%>"><%}%>
	          		<img src="<%=request.getContextPath()%>/images/<%=fb.getImg()%>" height="200" role="img" aria-label="Placeholder: Thumbnail">
	              <%if(!flag){%></a><%}%> 
	            </div>
	            <div class="card-body">
	              <p class="card-text">
	              	[<%=fb.getCity()%>/<%=fb.getPlace()%>] <%=fb.getName()%>
	              </p>
	              <div class="d-flex justify-content-between align-items-center">
	                <div class="btn-group">             		
	                	<%if(!flag){%><button type="button" class="btn btn-sm btn-outline-secondary" onclick="location.href='free_want.jsp?no=<%=fb.getNo()%>'">교환신청</button><%}%>
	                </div>
	                <small class="text-body-secondary">(<%=fb.getState()%>) <%=fb.getDay()%></small>
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
				<font color=gray size=5>등록된 나눔 물품이 없습니다</font>
			</div>
	  <%
		}
      %>
<br><br>


</div>

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
		      <a class="page-link" href="free_place.jsp?pageNum=<%=startPage-pageBlock%>" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		      </a>
		    </li>
<%
		}
		for(int i=startPage; i<=endPage; i++){
%>
			<li class="page-item"><a class="page-link" href="free_place.jsp?pageNum=<%=i%>&city=<%=city%>&place=<%=place%>"><%=i%></a></li>
<%			
		}
		if(endPage < pageCount){
%> 
			<li class="page-item">
		      <a class="page-link" href="free_place.jsp?pageNum=<%=startPage+pageBlock%>" aria-label="Next">
		        <span aria-hidden="true">&raquo;</span>
		      </a>
		    </li>
<%			
		}
	}
%>
</ul>
</nav>
</div><br>
<script>
	document.getElementById('citySelect').value = "<%=city%>";
	document.getElementById('placeSelect').value = "<%=place%>";
	updatePlaces(); // 페이지 로딩 시
</script>

<%@ include file="../bottom.jsp"%>
