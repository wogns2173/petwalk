<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>너나들이</title>

<link rel="icon" href="./resources/img/favicon.ico">
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>    
<script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<link rel="stylesheet" href="resources/css/common.css" type="text/css">
<style>
	
	 #title{
	 	color:#87d1bf;
	 	margin-left: 20px;
	 	margin-bottom: 70px;
	 }
	 
     table, th, td{
        border-collapse: collapse;
        padding : 10px 5px;
        text-align: center;
     }
     
     th {
     	color:#87d1bf;
     }
     
     input[type="submit"]{
        background-color: #87d1bf;
        color: white;
        border:none;
    }
    
    input[type="button"]{
    	background-color: #87d1bf;
        color: white;
        border:none;
       	width:110px;
       	height: 35px;
       	font-weight: bold;
       	margin-left: 130px;
       	margin-top: 30px;
    	}
    	
    #content{
    	margin-left: 130px;
    }
    
    #list{
    	margin-left: 335px;
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
		
		<br>
		<br>
		<br>
		<br>

<h3 id="title">회원 상세보기</h3>

<hr>
	<!-- 글 번호 -->
	<input type="hidden" name="memDetail" value="${mem.userID}">
	<div id="content">
		<!-- 회원 정보 디테일 가져오기 -->
		<table>
			<tr>
	        	<th>아이디</th>
	        	<td>${mem.userID}</td>
	        </tr>   
	        <tr>
	            <th>이름</th>
	            <td>${mem.userName}</td>
	        </tr>
	        <tr>         
	            <th>닉네임</th>
	            <td>${mem.userNickname}</td>
	        </tr>      
	        <tr>
	        	<th>이메일</th>
	        	<td>${mem.userEmail}</td>
	  		</tr>
	  		<tr>
	        	<th>연락처</th>
	        	<td>${mem.userContact}</td>
	  		</tr>
	  		<tr>
	        	<th>생년월일</th>
	        	<td>${mem.userBirthdate}</td>
	  		</tr>
	  		<tr>
	        	<th>주소</th>
	        	<td>${mem.siName} ${mem.guName} ${mem.dongName}</td>
	  		</tr>
	  		<tr>
	        	<th>성별</th>
	        	<td>${mem.userGender}</td>
	  		</tr>
	  		<tr>
	        	<th>회원가입 날짜</th>
	        	<td>${mem.userSignup}</td>
	  		</tr>
	  		<tr>
	        	<th>블라인드 처리 여부</th>
	        	<td>
	        		<form id="memManageProcess" action="memManageProcess.go" method="POST">
			   			<div>
			   				<input type="hidden" name="userID" value="${mem.userID}">
							<select name="selectedValue" id="${mem.userID}">
						    	<option value="false">블라인드 미처리 상태</option>
						    	<option value="true">블라인드 처리 완료 상태</option>
						   </select>
						   <input type="submit" value="상태 변경">
			  		 	</div>
		   			</form>
	   			</td>
	  		</tr>
		</table>
	</div>
	<!-- 회원 리스트로 돌아가기 -->
    <input id="list" type="button" onclick='location.href="./memManageList.go"' value="회원 리스트">
					   
	
	 
</body>
</html>
