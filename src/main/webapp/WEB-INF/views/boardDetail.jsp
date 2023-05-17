<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>    
	<script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
	<link rel="stylesheet" href="resources/css/common.css">
	<link rel= "stylesheet" href="resources/css/paging.css" type="text/css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
	
<style>
	.board_reply {
      border : 1px solid lightgray;
      border-radius: 5px;
      height: 30px;
      width : 673px;
      display: inline-flex;
   }
   input[type="text"]{
       width : 500px;
       border : none;
    }
    button[type="submit"]{
    	background-color: #87d1bf;
    	border:none;
    	margin-left: 94px;
    }
     #boardReply_legnth {
       float: right;
        border:none;
        font-size: 14px;
        color : lightgray;
        
     }
     #reportButton,#updateButton,#deleteButton,#listButton{
        float: right;
        background-color: #87d1bf;
        color: white;
        border:none;
        width: 70px;
        height: 32px;
        margin-right: 18px;
     }
     .boardRep {
     	border : none;
     	border-collapse: collapse;
     	padding : 10px 5px;
     }
     
     .text-right{
     	float: right;
     	margin-right: 25px;
     	color: darkgray;
     	font-size: 14px;
     }
     .main .topMenu {
     	padding: 0px;
     }
     
     .boardbuttonAll{
     	display: block;
     	float: right;
     	margin-right: 10px;
     	margin-top: 25px;
     }
     
     #boardAll{
     	margin-left: 25px;
     }
     
     #repUpdateButton,#deleteButton{
     	
     }
     
     #boardPro{
     	margin-left: -19px;
     }
     
     #writeDate{
     	font-size: 14px;
     	color: darkgray;
     	margin-top: 0px;
     }
     .modal {
     	position : relative;
     	z-index: 100;
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
	<!-- <c:forEach items="dto">-->
		<input type="hidden" name="boardNum" value="${dto.boardNum}"/>
		<br/>
		<br/>
		<br/>
		<br/>
		
		<div id="boardAll">
		<input type="hidden" name="categoryCode" id="categoryCode"/>
		<p class="text-right">${dto.categoryName}</p>
		<h1 id="boardName">${dto.boardName}</h1>
		<c:if test="${userID != null}">
			<div id="ex1" class="modal">
			  <p><a href="otherprofile.go?userID=${dto.userID}">프로필 보기</a></p>
			  <p><a href="reportwrite.go?categoryCode=${dto.categoryCode}&userID=${dto.userID}&boardNum=${dto.boardNum}">프로필 신고하기</a></p>
			  <!-- <a href="#" rel="modal:close">닫기</a>-->
			</div>
			<a href="#ex1" rel="modal:open" id="boardPro">
			${dto.userNickname }
			</a>
		</c:if>

		<c:if test="${userID == null }">
			<p>${dto.userNickname }</p>
		</c:if>

		<p id="writeDate">${dto.boardWriteDate} 조회수 ${dto.boardbHit }</p>
		</br>
		<c:if test="${dto.photoBlindWhether eq false }">
			<c:if test="${dto.serPhotoname ne null}">
				<tr>
					<td><img width="300" src="/photo/${dto.serPhotoname}"/></td>
				</tr>
			</c:if>
		</c:if>
		<c:if test="${dto.photoBlindWhether eq true }">		
		</c:if>
		<p>${dto.boardDetail}</p>
		<div class="boardbuttonAll">
			<c:if test="${dto.userID ne userID && userID ne null}">
				<input type="button"  id= "reportButton" onclick="location.href='./reportwrite.go?categoryCode=${dto.categoryCode}&userID=${dto.userID}&boardNum=${dto.boardNum}'" value="신고"/>
			</c:if> 
			
			<input id="updateButton" type= "button" onclick="location.href='./boardDelete.do?boardNum=${dto.boardNum}&categoryCode=${dto.categoryCode}'" value="삭제"/>
			<input id="deleteButton"type= "button" onclick="location.href='./boardUpdate.go?boardNum=${dto.boardNum}&categoryCode=${dto.categoryCode}'" value="수정"/>

			<input type="button" id="listButton" onclick="location.href='./boardList.go?categoryCode=${dto.categoryCode}'" value="목록"/>
		</div>
	<!--</c:forEach>-->
	<br/>
	<br/>
	<br/>
	<hr>
	<p>댓글</p>         
   
	<!--  댓글 리스트 가져오기 -->
	<c:if test="${userID == null }">
		<p>댓글을 작성하시거나 등록된 댓글을 확인하시려면 로그인 해주세요.</p>
	</c:if>
	<c:if test="${userID != null }">
	    <c:if test="${boardRepList.size() eq 0}">
			<tr><th colspan="10">등록된 댓글이 없습니다.</th></tr>	
		</c:if>
		
		<c:forEach items="${boardRepList}" var="boardRep">
			<div class="boardRep">
				<div id="ex2" class="modal">
					<p><a href="otherprofile.go?userID=${dto.userID}">프로필 보기</a></p>
					<p><a href="reportwrite.go?categoryCode=${dto.categoryCode}&userID=${dto.userID}">프로필 신고하기</a></p>
					<!-- <a href="#" rel="modal:close">닫기</a>-->
				</div>
				<p><a href="#ex2" rel="modal:open">${boardRep.replyUser}</a>
				<time id="writeDate" datetime="${boardRep.commentWriteDate}">${boardRep.commentWriteDate}</time>
				
					<input type ="button" id="repUpdateButton" onclick='location.href="boardRepDel.do?replyNum=${boardRep.replyNum}&boardNum=${boardRep.boardNum}"' value="삭제"/>
					<input type ="button" id="repReportButton" onclick='location.href="boardRepUpdate.go?replyNum=${boardRep.replyNum}&boardNum=${boardRep.boardNum}"' value="수정"/>
				</p>
				<p>&nbsp&nbsp&nbsp ${boardRep.commentDetail }</p>
			</div>	
		</c:forEach>
		
		<!-- 댓글 작성 -->
	    <form method="post" action="boardRepWrite.do">
		    <input type="hidden" name="boardNum" value="${dto.boardNum}">
		    
			<div class="board_reply">
		        <input name = "content" id="boardReply_text" type="text" maxlength="100" oninput="checkLength();" placeholder="내용을 입력 해 주세요.">
		        <p id="boardReply_legnth">0/100</p>
		        <button type="submit">등록</button>
			</div>
	    </form>
    </c:if>
    </div>
    </div>
    
</body>
<script>

	var loginID = "${sessionScope.userID}";
	var Role = "${sessionScope.Role}";
	if(loginID == "${dto.userID}" || Role == "admin") {
		 $('#updateButton').attr('type', 'button');
		 $('#deleteButton').attr('type', 'button');
		 $('#repUpdateButton').attr('type', 'button');
		 $('#repReportButton').attr('type', 'button');
	} else {
	    // 버튼을 숨기도록 설정
	    $('#updateButton').attr('type', 'hidden');
	    $('#deleteButton').attr('type', 'hidden');
	    $('#repUpdateButton').attr('type', 'hidden');
	    $('#repReportButton').attr('type', 'hidden');
	}
	
	/* 댓글 작성 글자 수 표시 */
	function checkLength() {
	    var maxLength = 100;
	    var length = document.getElementById("boardReply_text").value.length;
	    var lengthElement = document.getElementById("boardReply_legnth");
	    lengthElement.innerHTML = length + "/" + maxLength;
	}
	
	
	/*
	var mag = "${msg}";
	if(msg != null){
		alert(msg);
	}
	*/
	
</script>
</html>