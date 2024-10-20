//console.log("1:" + positions);
var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new kakao.maps.LatLng(37.5565426,126.9195486), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
        };

    //지도를 미리 생성
    var map = new kakao.maps.Map(mapContainer, mapOption);
    //주소-좌표 변환 객체를 생성
    var geocoder = new kakao.maps.services.Geocoder();
 	// 위도와 경도를 저장할 변수 선언
    var lat, lng;
//console.log("2:" + positions);
    function sample5_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = data.address; // 최종 주소 변수

                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("sample5_address").value = addr;
                // 주소로 상세 정보를 검색
                geocoder.addressSearch(data.address, function(results, status) {
                    // 정상적으로 검색이 완료됐으면
                    if (status === kakao.maps.services.Status.OK) {

                        var result = results[0]; //첫번째 결과의 값을 활용

                        // 해당 주소에 대한 좌표를 받아서
                        var coords = new kakao.maps.LatLng(result.y, result.x);
                        // 여기에서 위도와 경도 값을 저장합니다.
                        lat = result.y; // 위도 값 저장
                        lng = result.x; // 경도 값 저장
                        
                        // 지도를 보여준다.
                        mapContainer.style.display = "block";
                        map.relayout();
                        // 지도 중심을 변경한다.
                        map.setCenter(coords);
                        // 마커를 결과값으로 받은 위치로 옮긴다.
                        marker.setPosition(coords);
                        
                        // 위도와 경도 값을 사용하는 함수를 여기서 호출할 수 있습니다.
                        someFunctionUsingLatLng(lat, lng);
                    }
                });
            }
        }).open();
    }
    
 
    // 위도와 경도 값을 사용하는 예시 함수
    function someFunctionUsingLatLng(latitude, longitude) {
        console.log("Latitude: " + latitude + ", Longitude: " + longitude);
        document.getElementById("lat").value = latitude;
		document.getElementById("lng").value = longitude;
    }
var currentInfowindow = null; // 현재 열려있는 인포윈도우를 추적하기 위한 전역 변수
    // positions 배열을 사용하여 마커 생성
    for (var i = 0; i < positions.length; i++) {
        var marker = new kakao.maps.Marker({
            map: map,
            position: new kakao.maps.LatLng(positions[i].lat, positions[i].lng)
        });
        var title;
		if (positions[i].name.length >4) {
		    title = positions[i].name.slice(0, 5) + "... ";
		} else {
		    title = positions[i].name;
		}
        var content;
		if (positions[i].content.length >4) {
		    content = positions[i].content.slice(0, 5) + "...    ";
		} else {
		    content = positions[i].content;
		}
        var infowindow = new kakao.maps.InfoWindow({
	        content: '<div style="padding:5px;">물건명: <a href="freeView.jsp?no=' + positions[i].no + '">' + title + '</a><br>설명: ' + content + '</div>' // 인포윈도우에 표시할 내용
	    });
	
	    (function(marker, infowindow) {
        kakao.maps.event.addListener(marker, 'click', function() {
            // 기존에 열려있는 인포윈도우가 있다면 닫기
            if (currentInfowindow) {
                currentInfowindow.close();
            }
            // 새 인포윈도우 열기
            infowindow.open(map, marker);
            // 현재 열려있는 인포윈도우로 설정
            currentInfowindow = infowindow;
        });
    })(marker, infowindow);
   }

    console.log("3:" + positions);
    
    