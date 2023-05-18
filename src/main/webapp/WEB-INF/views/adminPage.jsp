<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
  	button{
    	background-color: #87d1bf;
    	border:none;
    	color: white;    	
    }
    .image-wrapper,
.link-wrapper {
    display: flex;
    justify-content: center;
}
.image-wrapper {
	margin : 5px 34px;
}
</style>
</head>
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
					<a href="routeshare/list?walkRouteType=공유">산책 경로 공유</a>
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
		
		<table>
		    <tr>						
		        <td>
		            <div class="image-wrapper">
		                <img alt="recommend" src="resources/img/inquiry.png" width="110" height="110" onclick="location.href='inquirylist.go'">
		            </div>
		        </td>
		        <td>
		            <div class="image-wrapper">
		                <img alt="walkmate" src="resources/img/report.png" width="110" height="110" onclick="location.href='reportList.go'">
		            </div>
		        </td>
		        <td>
		            <div class="image-wrapper">
		                <img alt="share" src="resources/img/member.png" width="110" height="110" onclick="location.href='memManageList.go'">
		            </div>
		        </td>
		        <td>
		            <div class="image-wrapper">
		                <img alt="community" src="resources/img/notice.png" width="110" height="110" onclick="location.href='noticelist.go'">
		            </div>
		        </td>
		    </tr>
		    <tr>
		        <td>
		            <div class="link-wrapper">
		                <button onclick="location.href='inquirylist.go'">문의 관리</button>
		            </div>
		        </td>
		        <td>
		            <div class="link-wrapper">
		               <button onclick="location.href='reportList.go'">신고 관리</button>
		            </div>
		        </td>
		        <td>
		            <div class="link-wrapper">
		            	<button onclick="location.href='memManageList.go'">회원 관리</button>            
		            </div>
		        </td>
		        <td>
		            <div class="link-wrapper">
		                <button onclick="location.href='noticelist.go'">공지사항 관리</button>
		            </div>
		        </td>
		    </tr>
		</table>
</div>
</body>
<script>

</script>
</html>