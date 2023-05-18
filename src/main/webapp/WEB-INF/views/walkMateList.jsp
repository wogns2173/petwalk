<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>KaKaoMap Study : olrlobt</title>
<link rel="icon" href="../resources/img/favicon.ico">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>

<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<script src="../resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<!--  
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>    

-->
<link rel="stylesheet" href="../resources/css/common.css">
<link rel= "stylesheet" href="../resources/css/paging.css" type="text/css">

<style type="text/css">
	#list {
		border-top: 1px solid black;
		border-bottom: 1px solid black;
	}
	div#map {
		margin-top : 60px;
	}
	inner {
		postion : relative;
	}
	.inner2{
		display: flex;
		 justify-content: center;
	}
	button{
		background-color: #87d1bf;
        color: white;
        border:none;
	}
	#thead{
		 	color:#87d1bf;
		 	background-color: #E3EDEB;
		 }
</style>
</head>
<body>
	<div class="main">
			<div class = "topMenu">
				<div class="logo">
					<a href="../">
						<img src="../resources/img/logo.png" alt="logo">				
						<img src="../resources/img/logoaname.png" alt="logoname">
					</a>	
				</div>			
					<div class="link">																		
						<c:if test="${empty sessionScope.userID}">
							<a href="../login.go">로그인</a>
							<a href="../join.go">회원가입</a>
						</c:if>
						
						<c:if test="${not empty sessionScope.userID}">
							<a href="../myinformation.go">${sessionScope.userNickname} 님</a>
							<c:if test="${sessionScope.Role eq 'admin'}">
								<a href="../adminPage.go">관리자 페이지</a>
							</c:if>
							<a href="../logout">로그아웃</a>
							<a href="../profile.go">프로필</a>
							<a href="../memberdelete.go">회원탈퇴</a>
						</c:if>
						<br>				
						<a href="../routeshare/list?walkRouteType=공유">산책 경로 공유</a>
						<a href="../matefind/list">산책 메이트</a>
						<a href="../board">커뮤니티</a>
						<a href="../noticelist.go">공지사항</a>
						<hr>					
				</div>															
			</div>
	<p>ㅎㅇ요</p>
	<div class="inner">
		<div id="map" style="width: 720px; height: 500px;">
			
		</div> 
		<br/>
		<div class="inner2">
			<input type="text" id="text1">&nbsp
			<button onclick="search()">검색</button>&nbsp
			<button>목록</button>&nbsp
			<button onclick="location.href='./write.go'">작성하기</button>
		</div>
		
		<table class="table">
			<br/>
	 		<thead>
	    		<tr id="thead">
			      <th scope="col">제목</th>
			      <th scope="col">작성자</th>
			      <th scope="col">산쨲날짜</th>
			      <th scope="col">모집여부</th>
				</tr>
			</thead>
			<tbody id="tbody">
	   	
			</tbody>
		</table>
		</div>
	</div>
</body>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=800da6fe675dabf08c56a06d01b2cbf0&libraries=services"></script>
<script>
openPopup()

function openPopup() {
    var screenWidth = window.screen.availWidth;
    var screenHeight = window.screen.availHeight;
    var popupWidth = 500;
    var popupHeight = 850;
    var left = (screenWidth - popupWidth) / 2;
    var top = (screenHeight - popupHeight) / 2;    

    window.open('popup', 'popup', 'width=515, height=821,left=' + left + ',top=' + top);
}

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
	    				content += ('<td>'+list.userID+'</td>');
	    				var date = new Date(list.petWalkDate);
	    				content +='<td>'+date.toLocaleDateString('ko-KR')+'</td>';//en-US
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