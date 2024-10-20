<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../top.jsp"%>
<%@ include file="free_top.jsp"%>

<%
	String no = String.valueOf(session.getAttribute("no"));
	MemberDao mdao = MemberDao.getInstance();
	String name = mdao.getMemberNameByNo(no);
	String city = request.getParameter("city");
	if(city==null){ 
		city = "전체";
	}
	String place = request.getParameter("place");
	if(place==null){
		place = "전체";
	}
%>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7adba8baafcd667f93cfc4b9e153872e&libraries=services"></script>
<div id="map" style="margin:auto; width:0px;height:0px;"></div>
<div id="searchMap" style="width:0px;height:0px;margin-top:10px;display:none"></div>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="map.js"></script>

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

<br>
<div style="width:1300px; height:750px; margin:auto; padding:50px; border:1px solid black;">
<form id="myForm" method="post" action="free_inputProc.jsp?mno=<%=no%>" enctype="multipart/form-data">
	<h3>물건 등록</h3> <br>
	<div class="input-group mb-3">
	  <span class="input-group-text" id="inputGroup-sizing-default">작성자</span>
	  <input type="text" value="<%=name%>" disabled class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
	</div>
	<div class="input-group mb-3">
			<span class="input-group-text" id="inputGroup-sizing-default">지역</span> 
			<select name="city" class="form-select"	aria-label="Default select example" id="citySelect" onchange="updatePlaces()">
				<option value="전체">도시를 선택하세요</option>
				<%
				String[] citys = { "서울", "부산", "대구", "인천", "광주", "대전", "울산", "세종", "경기", "강원", "충북", "충남", "전북", "전남", "경북", "경남","제주" };
				for (String s : citys) {
				%>
					<option value="<%=s%>"><%=s%></option>
				<%
				}
				%>
			</select>
			<select name="place" class="form-select" aria-label="Default select example" id="placeSelect" onchange="document.getElementById('searchForm').submit();" style="width: 100px;">
                <option value="전체">지역을 선택하세요</option>
                <!-- 자바스크립트를 통해 동적으로 옵션 추가 -->
            </select>
		</div>
	<div class="input-group mb-3">
		<input style="width:300px;" class="form-control me-2" type="text" id="sample5_address" placeholder="교환장소로 사용될 수 있는 위치정보를 입력해주세요">
		<input class="btn btn-outline-secondary" type="button" onclick="sample5_execDaumPostcode()" value="주소 검색">
	</div>
	<div class="input-group mb-3">
	  <span class="input-group-text" id="inputGroup-sizing-default">물건명</span>
	  <input type="text" name="name" class="form-control" placeholder="물건명을 작성해주세요" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
	</div>
	<div class="input-group mb-3">
	  <input type="file" name="img" class="form-control" id="inputGroupFile02">
	  <label class="input-group-text" for="inputGroupFile02">이미지</label>
	</div>
	<div class="input-group">
		<span class="input-group-text"><b>설명</b></span>
		<textarea class="form-control" name="content" placeholder="내용을 작성해주세요" aria-label="With textarea" cols=100 rows=10></textarea>
	</div>
	<br>
	<div style="text-align: right;">
		<input type="reset" class="btn btn-dark" value="다시쓰기">
		<input type="submit" class="btn btn-dark" value="작성하기">
	</div>
	<input type="hidden" name="lat" id="lat" value="">
	<input type="hidden" name="lng" id="lng" value="">
</form>
</div>
<br>

<%@ include file="../bottom.jsp"%>