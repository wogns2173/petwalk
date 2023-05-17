<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="../resources/img/favicon.ico">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script src = "https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="../resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<!--  
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>    

-->
<link rel="stylesheet" href="../resources/css/common.css">
<link rel= "stylesheet" href="../resources/css/paging.css" type="text/css">
<style>
	body {
		height : 1000px;
	}
	.select {
		width : 200px;
		/*float : left;*/
		display : inline;
	}
	.dot {overflow:hidden;float:left;width:12px;height:12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/mini_circle.png');}    
	.dotOverlay {position:relative;bottom:10px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;font-size:12px;padding:5px;background:#fff;}
	.dotOverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}    
	.number {font-weight:bold;color:#ee6152;}
	.dotOverlay:after {content:'';position:absolute;margin-left:-6px;left:50%;bottom:-8px;width:11px;height:8px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white_small.png')}
	.distanceInfo {position:relative;top:5px;left:5px;list-style:none;margin:0;}
	.distanceInfo .label {display:inline-block;width:50px;}
	.distanceInfo:after {content:none;}
	.selectDiv {
		margin-left: 50px;
	}
	
	inner {
		postion : relative;
	}
	.mineOrBookmark{
		width: 245px;
	}
	#minOrBookmarkButtom{
		margin-left: 20px;
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
	<form action="./write.do">
			<div id="map" style="width:100%;height:600px;"></div>
			<input type="hidden" value="" name="walkNum" id="walkNum"/>
			<br/>
			<div style="display: flex; margin-left: 346px;">
				<select class="form-select mineOrBookmark" aria-label="Default select example" name="mineOrBookmark">
					<option value="1">내가 등록한 산책경로</option>
					<option value="2">즐겨찾기한 경로</option>
				</select>
				<button type="button" onclick="bringIn()" id="minOrBookmarkButtom">불러오기</button>
			</div>
			<div class="mb-3">
				<label for="exampleFormControlInput1" class="form-label">제목</label>
				<input type="text" class="form-control" id="exampleFormControlInput1" name="mateName">
			</div>
			<div class="mb-3">
		 		<label for="exampleFormControlTextarea1" class="form-label">내용</label>
		 		<textarea class="form-control" id="exampleFormControlTextarea1" rows="3" name="mateDetail" style="height: 160px;"></textarea>
			</div>
			<div class="selectDiv">
				<select class="form-select select siList" aria-label="Default select example" name="siID"></select>
			
				<select class="form-select select guList" aria-label="Default select example" name="guID"></select>
				
				<select class="form-select select dongList" aria-label="Default select example" name="dongID"></select>
			</div>
			<div>
			<br/>
				<div style="display: inline; margin-left: 175px;">
					<label for="date">날짜를 선택하세요:
			  		<input type="date"
				         id="date"
				         max="2077-06-20"
				         min="2077-06-05"
				         value="2077-06-15"
				         name="petWalkDate">
					</label>
				</div>
				<button id="walkMateListButton">작성하기</button>
			</div>
		</form>
		<br/>
		<table class="table">
	 		<thead>
	    		<tr id="thead">
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
		
	</div>
</body>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=800da6fe675dabf08c56a06d01b2cbf0&libraries=services"></script>
<script>
	var dots = [];
	var distanceOverlay;
	var position;
	var line;
	var path;
	var geocoder = new kakao.maps.services.Geocoder();

	if('${sessionScope.userID}' == '') {
		alert('로그인하셈 ㅋ');
		location.href='/main';
	}
	$.ajax({
		type:'get',
		url:'./silist.ajax',
		data:{},
		dataType:'json',
		success:function(data){
			var content='';
			$('.siList').show();
		    $('.siList').empty();
			data.forEach((list, index) =>  {
				console.log(list);
				content += ('<option value="'+list.siID+'">'+list.siName+'</option>');
			});
			console.log(content);
			$('.siList').append(content);
			$('.dongList').show();
		    $('.dongList').empty();
		},
		error:function(e){
			console.log(e);
		}		
	});
	$.ajax({
		type:'get',
		url:'./gulist.ajax',
		data:{siID : 1},
		dataType:'json',
		success:function(data){
			console.log(data);
			var content='';
			data.forEach((list, index) =>  {
				content += ('<option value='+list.guID+'>'+list.guName+'</option>');
			});
			console.log(content);
			$('.guList').append(content);
			
		},
		error:function(e){
			console.log(e);
		}		
	});
	$.ajax({
		type:'get',
		url:'./donglist.ajax',
		data:{guID : 1},
		dataType:'json',
		success:function(data){
			console.log(data);
			var content='';
			data.forEach((list, index) =>  {
				content += ('<option value='+list.dongID+'>'+list.dongName+'</option>');
			});
			console.log(content);
			$('.dongList').append(content);
		},
		error:function(e){
			console.log(e);
		}		
	});
	$('.siList').change(function(){
	    $('.guList').show();
	    $('.guList').empty();
	    console.log($('option:selected', this).val());
	    $.ajax({
			type:'get',
			url:'./gulist.ajax',
			data:{siID : $('option:selected', this).val()},
			dataType:'json',
			success:function(data){
				console.log(data);
				var content='';
				data.forEach((list, index) =>  {
					content += ('<option value='+list.guID+'>'+list.guName+'</option>');
				});
				console.log(content);
				$('.guList').append(content);
				
			},
			error:function(e){
				console.log(e);
			}		
		});
	});
	
	$('.guList').change(function(){
    	$('.dongList').show();
	    $('.dongList').empty();
	    
	    console.log($('option:selected', this).val());
	    $.ajax({
			type:'get',
			url:'./donglist.ajax',
			data:{guID : $('option:selected', this).val()},
			dataType:'json',
			success:function(data){
				console.log(data);
				var content='';
				data.forEach((list, index) =>  {
					content += ('<option value='+list.dongID+'>'+list.dongName+'</option>');
				});
				console.log(content);
				$('.dongList').append(content);
				
			},
			error:function(e){
				console.log(e);
			}		
		});
    });
	
	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	var options = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(37.5301933196157, 127.123792501252), //지도의 중심좌표.
		level: 6 //지도의 레벨(확대, 축소 정도)
	};
	
	var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
	
	$('.siList').on('change', function() {
		console.log($(this).val());
	});
	
	function bringIn() {
		console.log($('.mineOrBookmark option:selected').val());
		var mineOrBookmark = $('.mineOrBookmark option:selected').val();
		
		$.ajax({
			type:'get',
			url:'../walkroute/routelist.ajax',
			data:{mineOrBookmark},
			dataType:'json',
			success:function(data){
				console.log(data);
				var content='<tr>';
				data.forEach(function(data) {
					$('#walkNum').val(data.walkNum);
					console.log(data);
					content += ('<td>'+data.walkName+'</td>');
    				content += ('<td>'+data.walkDetail+'</td>');
    				content += ('<td>'+data.userID+'</td>');
    				content += ('<td>'+data.walkDate+'</td>');
    				content += ('<td><button onclick="bringRoute(\''+data.walkNum+'\')">불러오기</button></td></tr>');
				});
				$('#tbody').html(content);
			},
			error:function(e){
				console.log(e);
			}		
		});
	}
	function bringRoute(walkNum){
		console.log(walkNum);
		$.ajax({
			type:'get',
			url:'../walkroute/bringRoute.ajax',
			data:{walkNum},
			dataType:'json',
			success:function(data){
				console.log(data);
				
				// 클릭한 위치를 기준으로 선을 생성하고 지도위에 표시합니다
			    line = new kakao.maps.Polyline({
			        map: map, // 선을 표시할 지도입니다 
			        path: [], // 선을 구성하는 좌표 배열입니다 클릭한 위치를 넣어줍니다
			        strokeWeight: 3, // 선의 두께입니다 
			        strokeColor: '#db4040', // 선의 색깔입니다
			        strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
			        strokeStyle: 'solid' // 선의 스타일입니다
			    });
				data.forEach(function(data){
					path = line.getPath();
					var latlng = new kakao.maps.LatLng(data.lat, data.lng);
					
					path.push(latlng)
					line.setPath(path);
					
					var distance = Math.round(line.getLength());
			        console.log(distance);
			        displayCircleDot(latlng, distance);
				});
				if (dots[dots.length-1].distance) {
			        dots[dots.length-1].distance.setMap(null);
			        dots[dots.length-1].distance = null;    
			    }
				
			    var distance = Math.round(line.getLength()), // 선의 총 거리를 계산합니다
			        content = getTimeHTML(distance); // 커스텀오버레이에 추가될 내용입니다
			        
			    // 그려진 선의 거리정보를 지도에 표시합니다
			    showDistance(content, path[path.length-1]);
				// 이동할 위도 경도 위치를 생성합니다 
			    var moveLatLon = new kakao.maps.LatLng(data[0].lat, data[0].lng);
			    
			    map.setLevel(4);
			    // 지도 중심을 이동 시킵니다
			    map.setCenter(moveLatLon);
			    
			},
			error:function(e){
				console.log(e);
			}		
		});
	}
	
	// 선이 그려지고 있는 상태일 때 지도를 클릭하면 호출하여 
	// 클릭 지점에 대한 정보 (동그라미와 클릭 지점까지의 총거리)를 표출하는 함수입니다
	function displayCircleDot(position, distance) {
	
	    // 클릭 지점을 표시할 빨간 동그라미 커스텀오버레이를 생성합니다
	    var circleOverlay = new kakao.maps.CustomOverlay({
	        content: '<span class="dot"></span>',
	        position: position,
	        zIndex: 1
	    });
	
	    // 지도에 표시합니다
	    circleOverlay.setMap(map);
	
	    if (distance > 0) {
	        // 클릭한 지점까지의 그려진 선의 총 거리를 표시할 커스텀 오버레이를 생성합니다
	        var distanceOverlay = new kakao.maps.CustomOverlay({
	            content: '<div class="dotOverlay">거리 <span class="number">' + distance + '</span>m</div>',
	            position: position,
	            yAnchor: 1,
	            zIndex: 2
	        });
	
	        // 지도에 표시합니다
	        distanceOverlay.setMap(map);
	    }
	
	    // 배열에 추가합니다
	    dots.push({circle:circleOverlay, distance: distanceOverlay});
	}
	// 마우스 우클릭 하여 선 그리기가 종료됐을 때 호출하여 
	// 그려진 선의 총거리 정보와 거리에 대한 도보, 자전거 시간을 계산하여
	// HTML Content를 만들어 리턴하는 함수입니다
	function getTimeHTML(distance) {

	    // 도보의 시속은 평균 4km/h 이고 도보의 분속은 67m/min입니다
	    var walkkTime = distance / 67 | 0;
	    var walkHour = '', walkMin = '';

	    // 계산한 도보 시간이 60분 보다 크면 시간으로 표시합니다
	    if (walkkTime > 60) {
	        walkHour = '<span class="number">' + Math.floor(walkkTime / 60) + '</span>시간 '
	    }
	    walkMin = '<span class="number">' + walkkTime % 60 + '</span>분'

	    // 자전거의 평균 시속은 16km/h 이고 이것을 기준으로 자전거의 분속은 267m/min입니다
	    var bycicleTime = distance / 227 | 0;
	    var bycicleHour = '', bycicleMin = '';

	    // 계산한 자전거 시간이 60분 보다 크면 시간으로 표출합니다
	    if (bycicleTime > 60) {
	        bycicleHour = '<span class="number">' + Math.floor(bycicleTime / 60) + '</span>시간 '
	    }
	    bycicleMin = '<span class="number">' + bycicleTime % 60 + '</span>분'

	    // 거리와 도보 시간, 자전거 시간을 가지고 HTML Content를 만들어 리턴합니다
	    var content = '<ul class="dotOverlay distanceInfo">';
	    content += '    <li>';
	    content += '        <span class="label">총거리</span><span class="number">' + distance + '</span>m';
	    content += '    </li>';
	    content += '    <li>';
	    content += '        <span class="label">도보</span>' + walkHour + walkMin;
	    content += '    </li>';
	    content += '    <li>';
	    content += '        <span class="label">자전거</span>' + bycicleHour + bycicleMin;
	    content += '    </li>';
	    content += '</ul>'

	    return content;
	}
	 
	// 마우스 드래그로 그려지고 있는 선의 총거리 정보를 표시하거
	// 마우스 오른쪽 클릭으로 선 그리가 종료됐을 때 선의 정보를 표시하는 커스텀 오버레이를 생성하고 지도에 표시하는 함수입니다
	function showDistance(content, position) {
	    
	    if (distanceOverlay) { // 커스텀오버레이가 생성된 상태이면
	        
	        // 커스텀 오버레이의 위치와 표시할 내용을 설정합니다
	        distanceOverlay.setPosition(position);
	        distanceOverlay.setContent(content);
	        
	    } else { // 커스텀 오버레이가 생성되지 않은 상태이면
	        
	        // 커스텀 오버레이를 생성하고 지도에 표시합니다
	        distanceOverlay = new kakao.maps.CustomOverlay({
	            map: map, // 커스텀오버레이를 표시할 지도입니다
	            content: content,  // 커스텀오버레이에 표시할 내용입니다
	            position: position, // 커스텀오버레이를 표시할 위치입니다.
	            xAnchor: 0,
	            yAnchor: 0,
	            zIndex: 3  
	        });      
	    }
	}
</script>
</html>