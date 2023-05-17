<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="../resources/img/favicon.ico">
<script src = "https://code.jquery.com/jquery-3.6.4.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>

<script src="../resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<link rel="stylesheet" href="../resources/css/common.css">
<link rel= "stylesheet" href="../resources/css/paging.css" type="text/css">
<style>
	table tbody tr th {
		text-align: center;
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
	#title {
		color: #87d1bf;
		margin-top: 10px; /* 갤러리 제목 위쪽 간격 조절 */
	}
	#myroute{
		color: #87d1bf;
	}
	#subtitle{
		font-size: 18px;
		color: gray;
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
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
	<h1 id="title">&nbsp산책 경로 불러오기</h1>
	<h3 id="subtitle">&nbsp&nbsp&nbsp산책 경로 공유글에 올릴 경로를 불러와주세요.</h3>
	<table class="table">
		<colgroup>
			<col width="20%">
			<col width="60%">
			<col width="20%">
		</colgroup>
		<tbody id="tbody">
			<tr id="myroute">
				<th colspan="3">내 산책경로</th>
			</tr>
   			<tr id="thead">
				<td>a</td>
				<td>b</td>
				<td>c</td>
			</tr>
			
		</tbody>
	</table>
	</div>
</body>
<script>
	$.ajax({
		type:'get',
		url:'./routelist.ajax',
		data:{},
		dataType:'json',
		success:function(data){
			console.log(data);
			var content = '<tr>';
			var i = 1;
			data.forEach(function(data) {
				content += '<td>'+i+'</td>'+'<td>'+data.walkName+'</td><td>';
				content +='<button onclick="location.href=\'./write.go?walkNum='+data.walkNum+'\'">선택</button>'+'</td></tr>';
				i++;
			});
			$('#tbody').append(content);
		},
		error:function(e){
			console.log(e);
		}		
	});
</script>
</html>