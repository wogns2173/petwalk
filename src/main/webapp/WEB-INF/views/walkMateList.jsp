<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>KaKaoMap Study : olrlobt</title>
<script src = "https://code.jquery.com/jquery-3.6.4.min.js"></script>

<style type="text/css">

</style>
</head>
<body>
	<p>ㅎㅇ요</p>
	<div id="map" style="width: 700px; height: 700px;">
		
	</div> 
	<div>
		<input type="text" id="text1">
		<button onclick="search()">검색</button>
	</div>
</body>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=800da6fe675dabf08c56a06d01b2cbf0&libraries=services"></script>
<script>
	var list = [];
	<c:forEach items="${list}" var="item">
	
		list.push({content : '${item.dongName}', latlng : new kakao.maps.LatLng(${item.lat},${item.lng})});
	
	</c:forEach>
	console.log(list);
	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	var options = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(37.5301933196157, 127.123792501252), //지도의 중심좌표.
		level: 6 //지도의 레벨(확대, 축소 정도)
	};
	
	var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
	
	var geocoder = new kakao.maps.services.Geocoder();
	
	var callback = function(result, status) {
	    if (status === kakao.maps.services.Status.OK) {
	        console.log(result[0].x + " / " + result[0].y);
	        var moveLatLon = new kakao.maps.LatLng(result[0].y, result[0].x);
		    
		    // 지도 중심을 부드럽게 이동시킵니다
		    // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
		    map.setCenter(moveLatLon);
	    }
		 
	};
	
	for (var i = 0; i < list.length; i ++) {
	    // 마커를 생성합니다
	    var marker = new kakao.maps.Marker({
	        map: map, // 마커를 표시할 지도
	        position: list[i].latlng // 마커의 위치
	    });

	    // 마커에 표시할 인포윈도우를 생성합니다 
	    var infowindow = new kakao.maps.InfoWindow({
	        content: list[i].content // 인포윈도우에 표시할 내용
	    });

	}
	function search() {
		console.log($('#text1').val());
		
		geocoder.addressSearch($('#text1').val(), callback);
	}   
	
</script>
</html>