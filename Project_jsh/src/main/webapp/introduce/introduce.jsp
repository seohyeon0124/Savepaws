<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../top.jsp"%>

<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=naf62c3lvh"></script>

  <!-- Marketing messaging and featurettes
  ================================================== -->
  <!-- Wrap the rest of the page in another container to center all the content. -->

  <div class="container marketing">

    <!-- START THE FEATURETTES -->

    <hr class="featurette-divider">

    <div class="row featurette">
      <div class="col-md-7">
        <h2 class="featurette-heading fw-normal lh-1" style="font-size: 50px;">세이브포스(SavePaws)는 <br>
        <span class="text-body-secondary" style="font-size: 40px;">유기동물의 보호와 입양을 <br>촉진하기 위해 만들어졌습니다</span></h2> <br>
        <p class="lead">사람과 동물 모두에게 더 나은 미래를 제공하기 위해 <br>유기동물에 대한 인식을 높이고, <br>동물 보호법의 개선을 위해 노력하며, <br>유기동물을 사랑하는 영원한 가족을 연결시켜주는 역할을 합니다</p>
      </div>
      <div class="col-md-5">
        <svg class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto" width="500" height="500" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 500x500" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="none"/>
        	<image href="<%=request.getContextPath()%>/img/introduce1.jpg"  x="0" y="0" height="500px" width="500px"/>
        </svg>
      </div>
    </div>

    <hr class="featurette-divider">

    <div class="row featurette">
      <div class="col-md-7 order-md-2">
        <h2 class="featurette-heading fw-normal lh-1" style="font-size: 40px;">다음과 같은 활동을 통해 <br>
        <span class="text-body-secondary" style="font-size: 40px;">목표를 실현합니다</span></h2><br>
        <p class="lead" style="font-size: 19px;">
        <b>- 인식 개선: </b> 유기동물에 대한 인식 개선을 위한 교육 프로그램과 캠페인<br><br>
        <b>- 입양 촉진: </b> 사랑과 보살핌이 필요한 동물들을 위해 안전하고 건강한 입양 환경 조성<br><br>
        <b>- 법적 지원: </b> 동물 보호 법령의 개선과 시행을 위한 법적 지원 및 옹호 활동 수행<br><br>
        <b>- 구조 및 치료: </b> 유기동물을 구조 및 건강과 안정을 위해 필요한 치료 제공
        </p>
      </div>
      <div class="col-md-5 order-md-1">
		<svg class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto" width="500" height="500" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 500x500" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="none"/>
        	<image href="<%=request.getContextPath()%>/img/introduce2.jpg"  x="0" y="0" height="500px" width="500px"/>
        </svg>
      </div>
    </div>

    <hr class="featurette-divider">

    <div class="row featurette">
      <div class="col-md-7">
        <h2 class="featurette-heading fw-normal lh-1">세이브포스, <span class="text-body-secondary">운영</span></h2> <br>
        <p class="lead">
        	세이브포스는 커뮤니티의 관심과 지원을 통해 운영됩니다 <br><br>
        	우리는 유기동물과 그들을 입양하고자 하는 가족들에게 <br>
        	희망의 메시지를 전달하고자 합니다 <br><br>
			세이브포스와 함께 동물들이 안전하고 <br>사랑받는 환경에서 살 수 있도록 지원해주세요 <br><br>
			우리는 모두가 함께 할 때 더 큰 변화를 만들 수 있다고 믿습니다
        </p>
      </div>
      <div class="col-md-5">
      	<svg class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto" width="500" height="500" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 500x500" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="none"/>
        	<image href="<%=request.getContextPath()%>/img/introduce3.jpg"  x="0" y="0" height="500px" width="500px"/>
        </svg>
      </div>
    </div>
    
    <hr class="featurette-divider"><br>

    <div class="row featurette">
      <div class="col-md-7 order-md-2">
        <h2 class="featurette-heading fw-normal lh-1" style="font-size: 45px;">찾아오시는 길 <br>
        <span class="text-body-secondary" style="font-size: 30px;">서울특별시 마포구 서교동 447-5 풍성빌딩 2,3,4층</span></h2><br>
        <p class="lead" style="font-size: 19px;">
        홍대입구역 1번출구로 나오셔서 도보로 약 7분정도 오시면 세이브포스가 있습니다<br><br>
        [ 운영시간 : 09:00~18:00 ]
        </p>
      </div>
      <div class="col-md-5 order-md-1">
		<div id="map" style="width:500px;height:400px;"></div>
		<script>
		var marker = new naver.maps.Marker({
		    position: new naver.maps.LatLng(37.5565426, 126.9195486), 
		    map: new naver.maps.Map('map', {
		        center: new naver.maps.LatLng(37.5565155, 126.9213951),
		        zoom: 17
		    })
		});
		</script>
      </div>
    </div>

    <!-- /END THE FEATURETTES -->

  </div><!-- /.container --> <br>

<%@ include file="../bottom.jsp"%>
    