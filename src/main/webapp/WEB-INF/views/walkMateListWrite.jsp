<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script src = "https://code.jquery.com/jquery-3.6.4.min.js"></script>
<style>
	body {
		height : 1000px;
	}
	.select {
		width : 400px;
	}
</style>
</head>
<body>
	<div id="map" style="width:100%;height:350px;"></div>
	<select class="form-select mineOrBookmark" aria-label="Default select example">
		<option value="1">내가 등록한 산책경로</option>
		<option value="2">즐겨찾기한 경로</option>
	</select>
	<button onclick="bringIn()">불러오기</button>
	<div class="mb-3">
		<label for="exampleFormControlInput1" class="form-label">제목</label>
		<input type="email" class="form-control" id="exampleFormControlInput1">
	</div>
	<div class="mb-3">
 		<label for="exampleFormControlTextarea1" class="form-label">내용</label>
 		<textarea class="form-control" id="exampleFormControlTextarea1" rows="3"></textarea>
	</div>
	<div class="selectDiv">
		<select class="form-select select siList" aria-label="Default select example">
			<option value="">선택</option>
		</select>
	
		<select class="form-select select guList" aria-label="Default select example">
			<option value="">선택</option>
		</select>
		
		<select class="form-select select dongList" aria-label="Default select example">
			<option value="">선택</option>
		</select>
	</div>
	<button>작성하기</button>
</body>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=800da6fe675dabf08c56a06d01b2cbf0&libraries=services"></script>
<script>
	if(sessionStorage.getItem("loginID") == null) {
		alert('로그인하셈 ㅋ');
		location.href='/';
	}
	
	$.ajax({
		type:'get',
		url:'./silist.ajax',
		data:{},
		dataType:'json',
		success:function(data){
			var content='';
			data.forEach((list, index) =>  {
				console.log(list);
				content += ('<option value="'+list.siID+'">'+list.siName+'</option>');
			});
			console.log(content);
			$('.siList').append(content);
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
		if($('.mineOrBookmark option:selected').val() == 1) {
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
		}
		else {
			
		}
	}
</script>
</html>