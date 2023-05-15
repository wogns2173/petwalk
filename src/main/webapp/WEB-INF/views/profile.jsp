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
						<c:if test="${sessionScope.Role eq 'admin'}">
							<a href="adminPage.go">관리자 페이지</a>
						</c:if>
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
	<button onclick="location.href='petprofileWrite.go'">반려견 정보 추가하기</button>
	</c:if>
	
	<c:if test="${pet.petSize != null}">
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
<!-- 				<input type="radio" name="petGender" value="남"<c:if test="${pet.petGender eq '남' }">checked</c:if>/>남아 &nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="petGender" value="여"<c:if test="${pet.petGender eq '여' }">checked</c:if>/>여아 -->
				</td>				
			</tr>
			<tr>					
				<th>중성화 여부</th>
				<td>
					<c:if test="${pet.petNeutered eq '1' }">O</c:if>
					<c:if test="${pet.petNeutered eq '0' }">X</c:if>
<!-- 				<input type="radio" name="petNeutered" value="1"<c:if test="${pet.petNeutered eq '1' }">checked</c:if>/>O &nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="petNeutered" value="0"<c:if test="${pet.petNeutered eq '0' }">checked</c:if>/>X -->
				</td>				
			</tr>
			<tr>					
				<th>반려견 소개</th>
				<td>
					${pet.petIntroduce}
				</td>				
			</tr>		
			<tr>		
		         <th colspan="2">
		            <!-- <button onclick="location.href='petprofileWrite.go'"<c:if test="${pet.petNeutered eq '1' }">hidden</c:if>>반려견 정보 추가하기</button> -->
		            <button onclick="location.href='petprofileUpdate.go'">수정하기</button>		            		            
		         </th>
	      	</tr>	      	
		</table>
		</c:if>
		
		<hr>
		
		<h3>작성한 산책 경로</h3>
		
		<button onclick="location.href='walkroute/routedraw'">산책 경로 작성</button>
		
		<c:if test="${empty routeDraw}">
		작성한 산책 경로가 없습니다.<br/>		
		</c:if>
		<c:if test="${!empty routeDraw}">
		<button onclick="location.href='routeshare/bring.go'">더 보기</button>		
			<table class="table">
				<colgroup>					
					<col width="70%">
					<col width="30%">
				</colgroup>
				<tbody id="tbody">					
		   			<tr>						
						<td>제목</td>
						<td>작성일자</td>
					</tr>					
					<c:forEach items="${routeDraw}" var="route" varStatus="loop">
						<c:if test="${loop.index < 5}">
					<tr>
						<td>${route.walkName}</td>
						<td>${route.walkDate}</td>						
					</tr>				
						</c:if>
					</c:forEach>
					
				</tbody>
			</table>
		</c:if>
		
		<hr>
		
		<h3>즐겨찾기한 산책 경로</h3>
		
		<c:if test="${empty bookmark}">
		즐겨찾기한 산책 경로가 없습니다.<br/>
		<button onclick="location.href='routeshare/list'">산책 경로 공유 게시판 가기</button>
		</c:if>
		<c:if test="${!empty bookmark}">
		<button>더 보기</button>
		<table  class="table">
			<colgroup>					
				<col width="70%">
				<col width="30%">
			</colgroup>
			<tr>						
				<td>제목</td>
				<td>작성일자</td>
			</tr>					
				<c:forEach items="${bookmark}" var="bookmark" varStatus="loop">
				<c:if test="${loop.index < 5}">
			<tr>
				<td>${bookmark.walkName}</td>
				<td>${bookmark.walkDate}</td>						
			</tr>				
				</c:if>
				</c:forEach>		
		</table>
		</c:if>
		
		<hr>
		
		<h3>산책 후기</h3>
		<c:if test="${empty review}">
		산책 후기가 없습니다.<br/>
		<button onclick="location.href='matefind/list'">산책 메이트 찾기</button>
		</c:if>
		<c:if test="${!empty review}">
		<button>더 보기</button>
		<table  class="table">
			<tr>		
		         <th colspan="2">
		            
		         </th>
	      	</tr>		
		</table>
		</c:if>
		
		<hr>
		
		<h3>문의 내역</h3>
		<button onclick="location.href='inquirywrite.go'">문의 하기</button>
		<c:if test="${empty inquiry}">
		문의 내역이 없습니다.<br/>		
		</c:if>
		<c:if test="${!empty inquiry }">
		<button>더 보기</button>
			<table class="table">
				<colgroup>					
					<col width="80%">
					<col width="20%">
				</colgroup>
				<tbody id="inquirytbody">					
		   			<tr>						
						<td>제목</td>
						<td>문의일자</td>
					</tr>					
					<c:forEach items="${inquiry}" var="inquiry">
					<tr>
						<td><a href="inquirydetail.do?boardNum=${inquiry.boardNum}">${inquiry.boardName}</a></td>						
						<td>${inquiry.boardWriteDate}</td>											
					</tr>				
					</c:forEach>
					
				</tbody>
			</table>
		</c:if>
		
		<hr>
		
		<h3>신고 내역</h3>
		<c:if test="${empty declaration}">
		신고 내역이 없습니다.		
		</c:if>
		<c:if test="${!empty declaration}">
		<button>더 보기</button>
		<table class="table">
			<tr>		
				<th colspan="2">		            		                       
					<button onclick="location.href='./'">돌아가기</button>
		        </th>
	      	</tr>		
		</table>
		</c:if>	
		</div>
</body>
<script>

</script>
</html>