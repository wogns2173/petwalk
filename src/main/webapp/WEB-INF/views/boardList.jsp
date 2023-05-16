<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
		margin-right: 0px;
		margin-bottom: 30px;
		margin-top: 34px;
		position: relative;
		left: 13%;
		transform: translateX(-50%);
	}
	.board-item img {
		width: 140px;
		height: 140px;
	  
	}
	.right-align {
		float: right;
		margin-top: -45px; /* 더보기 버튼과 갤러리 제목 사이의 간격 조절 */
		font-size: 12px;
		color: lightslategray;
	}
	
	#title {
		color: #87d1bf;
		margin-top: 10px; /* 갤러리 제목 위쪽 간격 조절 */
	}
	
	.container {
		overflow: hidden; /* 자식 요소들의 floating 영역이 부모 요소를 벗어나는 것을 방지 */
	}
	.hit {
		float: right;
		font-size: 14px;
		color: darkgray;
	}
	#photoBoardbHit{
		font-size: 14px;
		color: darkgray;
	}
	
	#boardLine{
		width: 94%;
		height: 1px;
		margin-left: 29px;
	}
		
	#boardName{
		font-weight: bold;
		white-space: nowrap;
	    overflow: hidden;
	    text-overflow: ellipsis;
	}
	#boardName:hover {
	    text-overflow: clip;
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
		<div>
			<h3 id="title">&nbsp &nbsp반려견 갤러리</h3>
			<a href="boardList.go?categoryCode=B_01" class="right-align">더보기></a>
			<hr id="boardLine"/>
			<div style="clear:both;"></div>
		</div>
		<c:forEach items="${boardList}" var="bbs">
			<c:if test="${bbs.categoryCode=='B_01'}">
				<div class="board-item">
					<a href="boardDetail.do?boardNum=${bbs.boardNum}"><img alt="default"  src="/photo/${bbs.serPhotoname}" ></a></br>
					<a href="boardDetail.do?boardNum=${bbs.boardNum}" id="boardName">${fn:substring(bbs.boardName, 0, 6)} ${fn:length(bbs.boardName) gt 6 ? '...' : ''} [${bbs.replyCount }]</a>
					<p id="photoBoardbHit">${bbs.boardWriteDate} 조회 ${bbs.boardbHit }</p>
				</div>
			</c:if>
		</c:forEach>

		<p><h3 id="title">&nbsp &nbsp반려견 지식 공유 게시판</h3>
		<a href="boardList.go?categoryCode=B_02" class="right-align">더보기></a></p>
		<hr id="boardLine"/>
		<c:forEach items="${boardList}" var="bbs">
			<c:if test="${bbs.categoryCode=='B_02'}">
				<ul>
					<li><a href="boardDetail.do?boardNum=${bbs.boardNum}"id="boardName">${bbs.boardName} [${bbs.replyCount}]</a><span class="hit"> ${bbs.boardbHit }&nbsp &nbsp&nbsp &nbsp</span></li>
				</ul>
			</c:if>
		</c:forEach>
		<br/>
		<br/>
		<h3 id="title">&nbsp &nbsp반려견 질문 게시판</h3>
		<input type="hidden" name="categoryCode" value="B_03"/>
		<a href="boardList.go?categoryCode=B_03" class="right-align">더보기></a>

		<hr id="boardLine"/>
<<<<<<< HEAD

=======
>>>>>>> origin/master
		<c:forEach items="${boardList}" var="bbs">
			<c:if test="${bbs.categoryCode=='B_03'}">
				<ul>
					<li><a href="boardDetail.do?boardNum=${bbs.boardNum}" id="boardName">${bbs.boardName} [${bbs.replyCount }]</a> <span class="hit">조회 ${bbs.boardbHit }&nbsp &nbsp&nbsp &nbsp</span></li>
				</ul>
			</c:if>
		</c:forEach>
		<br/>
		<br/>

		<h3 id="title">&nbsp &nbsp미아견 게시판</h3>
		<input type="hidden" name="categoryCode" value="B_04"/>
		<a href="boardList.go?categoryCode=B_04" class="right-align">더보기></a>

		<hr id="boardLine"/>

		<c:forEach items="${boardList}" var="bbs">
			<c:if test="${bbs.categoryCode=='B_04'}">
				<ul>
					<li><a href="boardDetail.do?boardNum=${bbs.boardNum}" id="boardName">${bbs.boardName} [${bbs.replyCount }]</a><span class="hit">조회 ${bbs.boardbHit }&nbsp &nbsp&nbsp &nbsp</span></li>
				</ul>
			</c:if>
		</c:forEach>
	</div>
</body>
<script>

</script>
</html>