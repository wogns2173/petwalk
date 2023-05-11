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
		<input type="hidden" name="categoryCode">${dto.categoryName}</input>
		<input type="hidden" name="boardNum" value="${dto.boardNum}"/>
		</br>
		<h1>${dto.boardName}</h1>
		<div id="modal" style="display: none;">
    		<div id="modal-container">
    			<p>프로필 보기</p>
    			<p>신고하기</p>
    		</div>
		</div>
		<p>작성자: <a href="#" class="username" data-user-id="${dto.userID}">${dto.userNickname }</a></p>
		</br>
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
		<button>신고</button>
		<input type= "button" onclick="location.href='./boardDelete.do?boardNum=${dto.boardNum}&categoryCode=${dto.categoryCode}'" value="삭제"/>
		<input type= "button" onclick="location.href='./boardUpdate.go?boardNum=${dto.boardNum}&categoryCode=${dto.categoryCode}'" value="수정"/>
		<input type="button" onclick="location.href='./boardList.go?categoryCode=${dto.categoryCode}'" value="목록"/>
	<!--</c:forEach>-->
	
	<hr>
	<p>댓글</p>         
   
	<!--  댓글 리스트 가져오기 -->
    <c:if test="${boardRepList.size() eq 0}">
		<tr><th colspan="10">등록된 댓글이 없습니다.</th></tr>	
	</c:if>
	
	<c:forEach items="${boardRepList}" var="boardRep">
		<div class="boardRep">
			${boardRep.userNickname} / ${boardRep.commentWriteDate}
			<input type ="button" onclick='location.href="boardRepDel.do?replyNum=${boardRep.replyNum}&boardNum=${boardRep.boardNum}"' value="삭제"/>
			<input type ="button" onclick='location.href="boardRepUpdate.go?replyNum=${boardRep.replyNum}&boardNum=${boardRep.boardNum}"' value="수정"/>
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
    
</body>
<script>

	/* 댓글 작성 글자 수 표시 */
	function checkLength() {
	    var maxLength = 100;
	    var length = document.getElementById("boardReply_text").value.length;
	    var lengthElement = document.getElementById("boardReply_legnth");
	    lengthElement.innerHTML = length + "/" + maxLength;
	}
	
	// 사용자 닉네임 클릭시 창띄우기
	$(document).ready(function(){
	    // 사용자 닉네임을 클릭하면 모달창 띄우기
	    $('.username').click(function(){
	        // 클릭한 사용자의 ID 가져오기
	        var userID = $(this).attr('data-user-id');
	        
	        // 모달창을 띄웁니다.
	        $.ajax({
	            url: '/getUserProfile.do',
	            type: 'post',
	            data: { userID: userID },
	            success: function(result){
	                // 모달창 띄우기
	                $('#modal-container').html(result);
	                $('#modal').show();
	            },
	            error: function(){
	                alert('오류가 발생하였습니다.');
	            }
	        });
	    });
	    
	    // 모달창 닫기
	    $('#modal-close-btn').click(function(){
	        $('#modal').hide();
	    });
	});
	
</script>
</html>
</body>
<script>
	
</script>
</html>