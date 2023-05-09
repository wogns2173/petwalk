<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
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
		<input type="hidden" name="categoryCode">${dto.categoryCode}</input>
		</br>
		<h1>${dto.boardName}</h1>
		</br>
		${dto.userNickname}
		</br>
		<h3>${dto.boardWriteDate} 조회수: ${dto.boardbHit }</h3>
		</br>
		<c:if test="${dto.serPhotoname ne null}">
			<tr>
				<td><img width="300" src="/photo/${dto.serPhotoname}"/></td>
			</tr>
			
		</c:if>
		<h2>${dto.boardDetail}</h2>
		<button>신고</button>
		<input type= "button" onclick="location.href='./boardDelete.do?boardNum=${dto.boardNum}'" value="삭제"/>
		<input type= "button" onclick="location.href='./boardUpdate.go?boardNum=${dto.boardNum}&categoryCode=${dto.categoryCode}'" value="수정"/>
		<button>목록</button>
	<!--</c:forEach>-->
	
	<hr>
	<p>댓글</p>         
   
	<!-- 문의글 댓글 리스트 가져오기 -->
    <c:if test="${boardRepList.size() eq 0}">
		<tr><th colspan="10">등록된 댓글이 없습니다.</th></tr>	
	</c:if>

	<c:forEach items="${boardRepList}" var="boardRep">
		<div class="boardRep">
			${boardRep.userNickname} / ${boardRep.commentWriteDate}
			<input type ="button" onclick='location.href="boardRepDel.do?replyNum=${boardRep.replyNum}&boardNum=${dto.boardNum}"' value="삭제"/>
			<input type ="button" onclick='location.href="boardRepUpdate.go?replyNum=${boardRep.replyNum}&boardNum=${dto.boardNum}"' value="수정"/>
			<p>${boardRep.commentDetail }</p>
		</div>	
	</c:forEach>
	
		<!-- 댓글 수정 -->
    <form method="get" action="boardRepUpdate.do">
	<div class="board_reply">
		<input type="hidden" name="boardNum" value="${dto.boardNum}">
		<input type="hidden" name="replyNum" value ="${replyNum}">
        <input name = "content" id="boardReply_text" type="text" maxlength="100" oninput="checkLength();" value="${boardRep.commentDetail}">
        <p id="boardReply_legnth">0/100</p>
        <button type="submit">수정</button>
	</div>  
    </form>
    
</body>
<script>
	function checkLength() {
		var maxLength = 100;
		var length = document.getElementById("boardReply_text").value.length;
		var lengthElement = document.getElementById("boardReply_legnth");
		lengthElement.innerHTML = length + "/" + maxLength;
	}
</script>
</html>