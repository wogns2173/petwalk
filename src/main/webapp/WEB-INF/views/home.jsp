<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>너나들이</title>
<link rel="icon" href="./resources/img/favicon.ico">

<script src = "https://code.jquery.com/jquery-3.6.4.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<link rel="stylesheet" href="resources/css/common.css">
<style>
.board-item {
    display: inline-block;
    vertical-align: top;
    text-align: center;
    margin-right: 10px;
    margin-bottom: 10px;
  }
  .board-item img {
    width: 117px;
    height: 117px;
    
  }
  .right-align{
  	float: right;
}	
.image-wrapper,
.link-wrapper {
    display: flex;
    justify-content: center;
}
.image-wrapper {
	margin : 5px 34px;
}
	button{
    	background-color: #87d1bf;
    	border:none;
    	color: white;    	
    }
    #title {
		color: #87d1bf;
		margin-top: 10px;
	}
  

</style>
</head>
<body>	
<body>
<div class="main">
		<div class = "topMenu">
			<div class="logo">
				<a href="./">
					<img src="resources/img/logo.png" alt="logo">				
					<img src="resources/img/logoaname.png" alt="logoname">
				</a>	
			</div>			
				<div class="link">																		
					<c:if test="${empty sessionScope.userID}">
						<a href="login.go">로그인</a>
						<a href="join.go">회원가입</a>
					</c:if>
					
					<c:if test="${not empty sessionScope.userID}">
						<a href="myinformation.go">${sessionScope.userNickname} 님</a>
						<c:if test="${sessionScope.Role eq 'admin'}">
							<a href="adminPage.go">관리자 페이지</a>
						</c:if>
						<a href="logout">로그아웃</a>
						<a href="profile.go">프로필</a>
						<a href="memberdelete.go">회원탈퇴</a>
					</c:if>
					<br>				
					<a href="routeshare/list?walkRouteType=share">산책 경로 공유</a>
					<a href="matefind/list">산책 메이트</a>
					<a href="board">커뮤니티</a>
					<a href="noticelist.go">공지사항</a>
					<hr>					
				</div>															
		</div>		
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>

		

		<table style="margin-left: 20px; margin-right: 20px;">
		    <tr>						
		        <td>
		            <div class="image-wrapper">
		                <img alt="recommend" src="resources/img/recommend.png" width="100" height="100" onclick="location.href='routeshare/list?walkRouteType=recommend'">
		            </div>
		        </td>
		        <td>
		            <div class="image-wrapper">
		                <img alt="walkmate" src="resources/img/walkmate.png" width="100" height="100" onclick="location.href='matefind/list'">
		            </div>
		        </td>
		        <td>
		            <div class="image-wrapper">
		                <img alt="share" src="resources/img/share.png" width="100" height="100" onclick="location.href='routeshare/list?walkRouteType=share'">
		            </div>
		        </td>
		        <td>
		            <div class="image-wrapper">
		                <img alt="community" src="resources/img/community.png" width="100" height="100" onclick="location.href='board'">
		            </div>
		        </td>
		    </tr>
		    <tr>
		        <td>
		            <div class="link-wrapper">
		                <button onclick="location.href='routeshare/list?walkRouteType=recommend'">추천 경로</button>
		            </div>
		        </td>
		        <td>
		            <div class="link-wrapper">
		                <button onclick="location.href='matefind/list'">산책 메이트 찾기</button>
		            </div>
		        </td>
		        <td>
		            <div class="link-wrapper">

		            	<button onclick="location.href='routeshare/list?walkRouteType=share'">산책 경로 공유</button>            
		            </div>
		        </td>
		        <td>
		            <div class="link-wrapper">
		                <button onclick="location.href='board'">커뮤니티</button>
		            </div>
		        </td>
		    </tr>
		</table>

	
	
	
	

	<hr>
	<h4 id="title">이런곳은 어떠세요?</h4>	
	<div style="text-align: right;">
	<button onclick="location.href='routeshare/list?walkRouteType=recommend'">더 알아보기</button>
	</div>
	<img alt="main" src="resources/img/main.png" width="721" onclick="location.href='routeshare/list?walkRouteType=recommend'">
	</div>	
</body>
</html>
