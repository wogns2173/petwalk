<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
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
					<a href="noticelist.go">공지사항</a>
					<hr>					
				</div>															
		</div>
		<br/>
		<br/>
		<br/>
		<br/>
		<h3>반려견 갤러리</h3>
		<a href="boardList.go?categoryCode=B_01" class="right-align">더보기></a>
		<br>
		<br>
		<br>
		<br>
		<c:forEach items="${boardList}" var="bbs">
			<c:if test="${bbs.categoryCode=='B_01'}">
				<div class="board-item">
					<a href="boardDetail.do?boardNum=${bbs.boardNum}"><img alt="default"  src="/photo/${bbs.serPhotoname}" ></a></br>
					<a href="boardDetail.do?boardNum=${bbs.boardNum}">${bbs.boardName} [${bbs.replyCount }]</a></br>
					${bbs.boardWriteDate} 조회 ${bbs.boardbHit }</br>
				</div>
			</c:if>
		</c:forEach>
		<hr>
		<h3>반려견 지식 공유 게시판</h3>
		<a href="boardList.go?categoryCode=B_02" class="right-align">더보기></a>
		</br>
		</br>
		<c:forEach items="${boardList}" var="bbs">
			<c:if test="${bbs.categoryCode=='B_02'}">
				<ul>
					<li><a href="boardDetail.do?boardNum=${bbs.boardNum}">${bbs.boardName} [${bbs.replyCount}]</a> 조회수: ${bbs.boardbHit }</li>
				</ul>
			</c:if>
		</c:forEach>
		<hr>
		<h3>반려견 질문 게시판</h3>
		<input type="hidden" name="categoryCode" value="B_03"/>
		<a href="boardList.go?categoryCode=B_03" class="right-align">더보기></a>
		<br>
		<br>
		<c:forEach items="${boardList}" var="bbs">
			<c:if test="${bbs.categoryCode=='B_03'}">
				<ul>
					<li><a href="boardDetail.do?boardNum=${bbs.boardNum}">${bbs.boardName} [${bbs.replyCount }]</a> 조회수: ${bbs.boardbHit }</li>
				</ul>
			</c:if>
		</c:forEach>
		<hr>
		<h3>미아견 게시판</h3>
		<input type="hidden" name="categoryCode" value="B_04"/>
		<a href="boardList.go?categoryCode=B_04" class="right-align">더보기></a>
		<br>
		<br>
		<br>
		<c:forEach items="${boardList}" var="bbs">
			<c:if test="${bbs.categoryCode=='B_04'}">
				<ul>
					<li><a href="boardDetail.do?boardNum=${bbs.boardNum}">${bbs.boardName} [${bbs.replyCount }]</a> 조회수: ${bbs.boardbHit }</li>
				</ul>
			</c:if>
		</c:forEach>
	</div>
</body>
<script>
</script>

</script>
</html>