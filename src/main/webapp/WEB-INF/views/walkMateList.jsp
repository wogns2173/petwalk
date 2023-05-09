<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>KaKaoMap Study : olrlobt</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<script src = "https://code.jquery.com/jquery-3.6.4.min.js"></script>

<style type="text/css">
	#list {
		border-top: 1px solid black;
		border-bottom: 1px solid black;
	}
</style>
</head>
<body>
	<p>ㅎㅇ요</p>
	<div id="map" style="width: 700px; height: 700px;">
		
	</div> 
	<div>
		<input type="text" id="text1">
		<button onclick="search()">검색</button>
		<button>목록</button>
		<button onclick="location.href='./write.go'">작성하기</button>
	</div>
	
	<table class="table">
  <thead>
    <tr>
      <th scope="col">제목</th>
      <th scope="col">내용</th>
      <th scope="col">작성자</th>
      <th scope="col">작성일자</th>
      <th scope="col">모집여부</th>
    </tr>
  </thead>
  <tbody id="tbody">
   	
  </tbody>
</table>
	
</body>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=800da6fe675dabf08c56a06d01b2cbf0&libraries=services"></script>
<script>
	var list = [];
	<c:forEach items="${list}" var="item">
	
		list.push({content : '${item.dongName}', latlng : new kakao.maps.LatLng(${item.lat},${item.lng})});
	
	</c:forEach>
	console.log(list[0].content);
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
	
	for (var i = 0; i < list.length; i++) {
	    // 마커를 생성합니다
	    var marker = new kakao.maps.Marker({
	        map: map, // 마커를 표시할 지도
	        position: list[i].latlng, // 마커의 위치
	        title : list[i].content
	    });

	    // 마커에 표시할 인포윈도우를 생성합니다 
	    var infowindow = new kakao.maps.InfoWindow({
	        content: list[i].content // 인포윈도우에 표시할 내용
	    });
	    
	    kakao.maps.event.addListener(marker, 'click', function() {
	        console.log(this.getTitle());
	        
	        $.ajax({
	    		type:'get',
	    		url:'./markerlist.ajax',
	    		data:{'dong' : this.getTitle()},
	    		dataType:'json',
	    		success:function(data){
	    			console.log(data);
	    			var content='<tr>';
	    			data.forEach((list, index) =>  {
	    				content += ('<td><a href="./listDetail.do?mateWalkNum='+list.mateWalkNum+'">'+list.mateName+'</a></td>');
	    				/*location.href=  */
	    				content += ('<td>'+list.mateDetail+'</td>');
	    				content += ('<td>'+list.userID+'</td>');
	    				content += ('<td>'+list.petWalkDate+'</td>');
	    				content += ('<td>'+list.state+'</td></tr>');
	    			});
	    			console.log(content);
	    			$('#tbody').html(content);
	    		},
	    		error:function(e){
	    			console.log(e);
	    		}		
	    	});
	    });
	}
	function search() {
		console.log($('#text1').val());
		
		geocoder.addressSearch($('#text1').val(), callback);
	}   
	
</script>
</html>