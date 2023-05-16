<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="./resources/img/favicon.ico">
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<style>
   .notice_reply {
      border : 1px solid lightgray;
      border-radius: 5px;
      height: 30px;
      width : 800px;
      display: inline-flex;
   }
   
   input {
      margin : 0;
      
   }
   
    input[type="text"]{
       width : 500px;
       border : none;
    }
    
    input[type="button"]{
    	float: right;
        background-color: #87d1bf;
        color: white;
        border:none;
    
    }
    
    button{
        float: right;
        background-color: #87d1bf;
        color: white;
        border:none;
        
     }
     
     #noticereply_legnth {
       float: right;
        border:none;
        font-size: 14px;
        color : lightgray;
        
     }
     
     .noticerep {
     	border : 1px solid lightgray;
     	border-collapse: collapse;
     	padding : 10px 5px;
     }
     
     table, th, td{
     	border : 1px solid lightgray;
     	border-collapse: collapse;
     	padding : 10px 5px;
     }
</style>
</head>

	<!-- 글 번호 -->
	<input type="hidden" name="notice" value="${notice.boardNum}">
	
	<!-- 공지 사항 디테일 가져오기  -->
	<table>
		<tr>
        	<th>${notice.boardName }</th>
        </tr>   
        <tr>
            <td>${notice.userID} </td>
        </tr>
        <tr>         
            <td>${notice.boardWriteDate}</td>
        </tr>      
        <tr>
            <td>${notice.boardDetail}</td>
            <c:if test="${notice.serPhotoname ne null}">
			<tr>
				<td><img width="300" src="/photo/${notice.serPhotoname}"/></td>
			</tr>
			</c:if>
    	 </tr>            
   </table>
     	
		<!-- 공지사항 목록으로 돌아가기 -->
        <input type="button" onclick='location.href="./noticelist.go"' value="목록">
      
   <hr>
   
   <p>답변</p>         
   
	<!-- 문의글 댓글 리스트 가져오기 -->
    <c:if test="${noticelist.size() eq 0}">
		<tr><th colspan="10">등록된 답변이 없습니다.</th></tr>	
	</c:if>
	
	<c:forEach items="${noticereplist}" var="noticerep">
		<div class="inqrep">
			${noticerep.userID} / ${noticerep.commentWriteDate}
			<p>${noticerep.commentDetail }</p>
		</div>	
	</c:forEach>
	
	<!-- 댓글 수정 -->
    <form method="get" action="reportreplyupdate.do">
	    <input type="hidden" name="boardNum" value="${notice.boardNum}">
	    <input type="hidden" name="replyNum" value ="${replyNum}">
		<div class="notice_reply">
	        <input name = "content" id="noticereply_text" type="text" maxlength="100" oninput="checkLength();" placeholder="${noticerep }">
	        <p id="noticereply_legnth">0/100</p>
	        <button type="submit">수정</button>
		</div>  
    </form>
    
</body>
<script>

	/* 댓글 작성 글자 수 표시 */
	function checkLength() {
	    var maxLength = 100;
	    var length = document.getElementById("noticereply_text").value.length;
	    var lengthElement = document.getElementById("noticereply_legnth");
	    lengthElement.innerHTML = length + "/" + maxLength;
	  }
  	
</script>
</html>