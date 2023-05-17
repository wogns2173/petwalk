<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
<meta charset="UTF-8">
<title>너나들이 회원정보</title>
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
    #title {
		color: #87d1bf;
		margin-top: 10px; /* 갤러리 제목 위쪽 간격 조절 */
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
	<h3 id="title" style="text-align: center;">내 정보</h3>
		<br/>
		<br/>
		<table class="table" style="margin-left: auto; margin-right: auto;">
			<tr style="text-align: center;">
				<th id="title">아이디</th>
				<td>
					${member.userID}									
				</td>
			</tr>
			<tr style="text-align: center;">
				<th id="title">이름</th>
				<td>
					${member.userName}				
				</td>				
			</tr>
			<tr style="text-align: center;">
				<th id="title">닉네임</th>
				<td>
					${member.userNickname}										
				</td>
			</tr>
			<tr style="text-align: center;">
				<th id="title">이메일</th>
				<td>
					${member.userEmail}
				</td>
			</tr>	
			<tr style="text-align: center;">
				<th id="title">연락처</th>
				<td>
					${member.userContact}
				</td>
			</tr>										
			<tr style="text-align: center;">
				<th id="title">나이</th>
				<td>
					${member.userAge}
				</td>
			</tr>
			<tr style="text-align: center;">
				<th id="title">생년월일</th>					
				<td>
					${member.userBirthdate}
				</td>
			</tr>	
			<tr style="text-align: center;">
				<th id="title">주소</th>
				<td>
					${member.siName} ${member.guName} ${member.dongName}
				</td>
			</tr>
			<tr style="text-align: center;">			
				<th id="title">성별</th>
				<td>
				<c:if test="${member.userGender eq '남' }">남자</c:if>
				<c:if test="${member.userGender eq '여' }">여자</c:if>				
										<!-- <input type="radio" name="userGender" value="남"
										<c:if test="${member.userGender eq '남' }">checked</c:if>
										/>남자 &nbsp;&nbsp;&nbsp;&nbsp;
										<input type="radio" name="userGender" value="여"
										<c:if test="${member.userGender eq '여' }">checked</c:if>
										/>여자 -->
				</td>				
			</tr>	
			<tr style="text-align: center;">		
		         <th colspan="2">
		            <button onclick="location.href='myinformationupdate.go'">회원정보 수정</button>
		            <button onclick="location.href='changememberpw.go'">비밀번호 변경</button>
		            <button onclick="location.href='./'">돌아가기</button>
		         </th>
	      	</tr>
		</table>
	</div>
</body>
<script>

</script>
</html>