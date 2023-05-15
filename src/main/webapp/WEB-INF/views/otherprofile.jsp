<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
<meta charset="UTF-8">
<title>너나들이 프로필</title>
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
						<a href="logout">로그아웃</a>
						<a href="profile.go">프로필</a>
						<a href="memberdelete.go">회원탈퇴</a>
					</c:if>
					<br>				
					<a href="routeshare/list">산책 경로 공유</a>
					<a href="matefind/list">산책 메이트</a>
					<a href="board">커뮤니티</a>
					<hr>					
				</div>															
		</div>
		<br/>
		<br/>
		<br/>
		<br/>
	<c:if test="${pet.petSize == null}">
	등록된 반려견 정보가 없습니다.	
	</c:if>
	
	<c:if test="${pet.petSize != null }">
	<h3>반려견 프로필</h3>
		<table class="table">
			<tr>
				<th>사진</th>
				<td>
					<img width="100" src="/photo/${pet.serPhotoname}"/>					
				</td>				
			</tr>			
			<tr>
				<th>견종 사이즈</th>
				<td>
					${pet.petSize}										
				</td>				
			</tr>				
			<tr>
				<th>이름</th>
				<td>
					${pet.petName}					
				</td>				
			</tr>
			<tr>
				<th>나이</th>
				<td>
					${pet.petAge} 살										
				</td>
			</tr>
			<tr>					
				<th>성별</th>
				<td>
					<c:if test="${pet.petGender eq '남' }">남아</c:if>
					<c:if test="${pet.petGender eq '여' }">여아</c:if>
					<!-- <input type="radio" name="petGender" value="남"<c:if test="${pet.petGender eq '남' }">checked</c:if>/>남아 &nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="petGender" value="여"<c:if test="${pet.petGender eq '여' }">checked</c:if>/>여아 -->
				</td>				
			</tr>
			<tr>					
				<th>중성화 여부</th>
				<td>
					<c:if test="${pet.petNeutered eq '1' }">O</c:if>
					<c:if test="${pet.petNeutered eq '0' }">X</c:if>
					<!-- <input type="radio" name="petNeutered" value="1"<c:if test="${pet.petNeutered eq '1' }">checked</c:if>/>O &nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="petNeutered" value="0"<c:if test="${pet.petNeutered eq '0' }">checked</c:if>/>X -->
				</td>				
			</tr>
			<tr>					
				<th>반려견 소개</th>
				<td>
					${pet.petIntroduce}
				</td>				
			</tr>						      	
		</table>
		</c:if>
		
		<hr>
		
		<h3>공유한 산책 경로</h3>
		
		<c:if test="${empty routeShare}">
		공유한 산책 경로가 없습니다.<br/>		
		</c:if>
		<c:if test="${!empty routeShare}">		
			<table class="table">
				<colgroup>					
					<col width="40%">
					<col width="40%">
					<col width="20%">
				</colgroup>
				<tbody id="tbody">					
		   			<tr>						
						<td>제목</td>
						<td>작성일자</td>
						<td>조회수</td>
					</tr>					
					<c:forEach items="${routeShare}" var="routeShare">
					<tr>
						<td><a href="detail.do?idx=${routeShare.walkRouteNum}">${routeShare.walkRouteName}</a></td>
						<td>${routeShare.walkRouteWriteDate}</td>
						<td>${routeShare.walkRoutebHit}</td>							
					</tr>				
					</c:forEach>					
				</tbody>
			</table>
		</c:if>
		
		<hr>

		<h3>산책 후기</h3>
		<c:if test="${review == null}">
		산책 후기가 없습니다.<br/>
		</c:if>
		<c:if test="${review != null}">
		<table class="table">
			<tr>		
		         <th colspan="2">
		            
		         </th>
	      	</tr>		
		</table>
		</c:if>
		
		<hr>
	</div>	
	
</body>
<script>
console.log('${pet.serPhotoname}');
console.log('${pet.profileID}');
console.log('${pet.petSize}');
console.log('${pet.petName}');
console.log('${pet.petAge}');
console.log('${pet.petGender}');
console.log('${pet.petNeutered}');
console.log('${pet.petIntroduce}');
console.log('${inquiry}');
</script>
</html>