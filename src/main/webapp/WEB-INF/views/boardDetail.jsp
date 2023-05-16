<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<style>
	.board_reply {
      border : 1px solid lightgray;
      border-radius: 5px;
      height: 30px;
      width : 800px;
      display: inline-flex;
   }
   input[type="text"]{
       width : 500px;
       border : none;
    }
     #boardReply_legnth {
       float: right;
        border:none;
        font-size: 14px;
        color : lightgray;
        
     }
     
     .boardRep {
     	border : 1px solid lightgray;
     	border-collapse: collapse;
     	padding : 10px 5px;
     }
</style>
</head>
<body>
	<!-- <c:forEach items="dto">-->
		<input type="hidden" name="categoryCode">${dto.categoryName}</input>
		<input type="hidden" name="boardNum" value="${dto.boardNum}"/>
		<br>
		<h1>${dto.boardName}</h1>
		<c:if test="${userID != null}">
			<div id="ex1" class="modal">
			  <p><a href="otherprofile.go?userID=${dto.userID}">프로필 보기</a></p>
			  <p><a href="reportwrite.go?categoryCode=${dto.categoryCode}&userID=${dto.userID}&boardNum=${dto.boardNum}">프로필 신고하기</a></p>
			  <!-- <a href="#" rel="modal:close">닫기</a>-->
			</div>
			<p><a href="#ex1" rel="modal:open">
			${dto.userNickname }
			</a></p>
		</c:if>

		
		<c:if test="${userID == null }">
			<p>${dto.userNickname }</p>
		</c:if>

		<h3>${dto.boardWriteDate} 조회수: ${dto.boardbHit }</h3>
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
		<h2>${dto.boardDetail}</h2>
		<c:if test="${dto.userID ne userID && userID ne null}">
			<input type="button"  id= "reportButton" onclick="location.href='./reportwrite.go?categoryCode=${dto.categoryCode}&userID=${dto.userID}&boardNum=${dto.boardNum}'" value="신고"/>
		</c:if> 
		
			<input id="updateButton" type= "button" onclick="location.href='./boardDelete.do?boardNum=${dto.boardNum}&categoryCode=${dto.categoryCode}'" value="삭제"/>
			<input id="deleteButton"type= "button" onclick="location.href='./boardUpdate.go?boardNum=${dto.boardNum}&categoryCode=${dto.categoryCode}'" value="수정"/>

			<input type="button" onclick="location.href='./boardList.go?categoryCode=${dto.categoryCode}'" value="목록"/>
	<!--</c:forEach>-->
	
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
				<p><a href="#ex2" rel="modal:open">
				${boardRep.replyUser} </a>/ ${boardRep.commentWriteDate}
				<c:if test="${boardRep.userID == userID}">
					<input type ="button" id="repUpdateButton" onclick='location.href="boardRepDel.do?replyNum=${boardRep.replyNum}&boardNum=${boardRep.boardNum}"' value="삭제"/>
					<input type ="button" id="repReportButton" onclick='location.href="boardRepUpdate.go?replyNum=${boardRep.replyNum}&boardNum=${boardRep.boardNum}"' value="수정"/>
				</c:if></p>
				<p>${boardRep.commentDetail }</p>
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
    
</body>
<script>

	var loginID = "${sessionScope.userID}";
	var Role = "${sessionScope.Role}";
	if(loginID == "${dto.userID}" || Role == "admin") {
		 $('#updateButton').attr('type', 'button');
		    $('#deleteButton').attr('type', 'button');
	} else {
	    // 버튼을 숨기도록 설정
	    $('#updateButton').attr('type', 'hidden');
	    $('#deleteButton').attr('type', 'hidden');
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