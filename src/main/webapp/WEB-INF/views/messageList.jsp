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
</head>
<style>
	#list {
		border : 1px solid black;
		text-align: center;
	}
	span {
		border : 1px solid blue;
	}
	.receiver {
		padding : 5px 10px;
	}
</style>
<body>
	<input type="text" value="${sessionScope.userID}"/>
	<div id="list">메시지 리스트</div>
	<span id="room">메시지 방</span>
	<span id="history">메시지 내역</span>
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
					content += '<div>'+list.sendID+': '+list.messageDetail+'</div>';
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