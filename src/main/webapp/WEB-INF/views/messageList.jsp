<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Want 사진자랑하기</title>
<link rel="icon" href="./resources/img/favicon.ico">
<script src = "https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="../resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<link rel="stylesheet" href="../resources/css/common.css">
<link rel= "stylesheet" href="../resources/css/paging.css" type="text/css">
</head>
<style>
	#list {
		border : 1px solid black;
		text-align: center;
		color:#87d1bf;
		font-size: 40px;
	}
	span {
		border : 1px solid blue;
	}
	.receiver {
		padding : 5px 10px;
	}
	#userID,#list{
		border: none;
	}
	#history{
		border: none;
	}
	#userID{
		color: gray;
		margin-left: 100px;
	}
	#messageListAll{
		margin-left: 46px;
	}
	.receiver{
		color:#87d1bf;
	}
	#sendBtn{
		background-color: #87d1bf;
        color: white;
        border:none;
	}
	#MLsendID{
		color: glay;
	}
	
</style>
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
						<a onclick="location.href='/main/routeshare/list?walkRouteType=공유'">산책 경로 공유</a>
						<a onclick="location.href='/main/matefind/list'">산책 메이트</a>
						<a href="../board">커뮤니티</a>
						<a href="../noticelist.go">공지사항</a>
						<hr>					
				</div>															
			</div>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
	<input type="hidden" value="${sessionScope.userID}" id="userID"/>
	<div id="messageListAll">
		<div id="list">메시지 리스트</div>
		
		<span id="room">메시지 방</span>
		<span id="history">메시지 내역</span>
	</div>
	</div>
</body>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<script>
	var isWriter = false;
	if('${sessionScope.userID}' == '${receiveID}'){
		console.log('작성자 맞음');
		isWriter = true;
	}
	if(isWriter) {
		
	}
	var websocket;
	var sendID='';
	//입장 버튼을 눌렀을 때 호출되는 함수
	
    // 웹소켓 주소
    var wsUri = "ws://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/websocket/echo.do";
    // 소켓 객체 생성
    websocket = new WebSocket(wsUri);
    //웹 소켓에 이벤트가 발생했을 때 호출될 함수 등록
    websocket.onopen = onOpen;
    websocket.onmessage = onMessage;
	
    console.log(websocket.send);
	//웹 소켓에 연결되었을 때 호출될 함수
	function onOpen() {
		console.log('웹 소켓 연결 완료');
	}
	
	// * 1 메시지 전송
	function sendMessage(){
		console.log('메시지 전송');
		websocket.send('${sessionScope.userID} : ' + $('#content').val());
	}
	
	// * 2 메세지 수신
	function onMessage(msg) {
		console.log('메시지 수신');
		var data = msg.data;
		var content = '<div>'+data+'</div>';
		$('#content').before(content);
	}
	
	$(document).ready(function() {
		// 메세지 리스트 리로드
		messageList();
	});
	
	function messageList() {
		if(!isWriter){
			$.ajax({
				type:'post',
				url:'./messageListSender.ajax',
				data: {
					sendID : '${sessionScope.userID}'
				},
				dataType:'json',
				success:function(data){
					console.log(data);
					console.log(data.length);
					var content = '';
					data.forEach(function(list) {
						console.log(list.receiveID);
						console.log(list.mateWalkNum);
						content += '<div class="receiver"><a onclick="bringMessage(\''+list.mateWalkNum+'\')">'+list.receiveID+'님과의 메시지</a></div>';
					});
					$('#room').html(content);
					
				},
				error:function(e){
					console.log(e);
				}		
			});
		} else {
			$.ajax({
				type:'post',
				url:'./messageListReceiver.ajax',
				data: {
					receiveID : '${receiveID}'
				},
				dataType:'json',
				success:function(data){
					console.log(data);
					console.log(data.length);
					
					var content = '';
					data.forEach(function(list) {
						console.log(list.receiveID);
						console.log(list.mateWalkNum);
						content += '<div class="receiver"><a onclick="bringMessage(\''+list.mateWalkNum+'\')">'+list.sendID+'님과의 메시지</a></div>';
					});
					$('#room').html(content);
				},
				error:function(e){
					console.log(e);
				}		
			});
			$('#content').val('');
		}
	}
	function bringMessage(mateWalkNum, sendID) {
		console.log('bringMessage 호출');
		console.log(mateWalkNum);
		console.log(sendID);
		$.ajax({
			type:'post',
			url:'./messageHistory.ajax',
			data: {
				mateWalkNum : mateWalkNum
			},
			dataType:'json',
			success:function(data){
				console.log(data);
				var content = '';
				data.forEach(function(list){
					content += '<div id="'+list.sendID+'">'+list.sendID+': '+list.messageDetail+'</div>';
				});
				content += '<input type="text" id="content"/>';
				content += '<button onclick="send()" id="sendBtn">보내기</button>';
				$('#history').html(content);
			},
			error:function(e){
				console.log(e);
			}		
		});
		
	}
	
	function send(sendID) {
		sendMessage();
		console.log('${mateWalkNum}');
		console.log('${receiveID}');
		console.log('send');
		var sendID = '${sessionScope.userID}';
		console.log('메시지 저장');
		$.ajax({
			type:'post',
			url:'./messageSend.ajax',
			data: {
				mateWalkNum : '${mateWalkNum}',
				receiveID : '${receiveID}',
				sendID : '${sessionScope.userID}',
				messageDetail : $('#content').val()
			},
			dataType:'json',
			success:function(data){},
			error:function(e){
				console.log(e);
			}		
		});
	}
</script>
</html>