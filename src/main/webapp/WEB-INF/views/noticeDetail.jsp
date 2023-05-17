<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>너나들이</title>

<link rel="icon" href="./resources/img/favicon.ico">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>    
<script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<link rel="stylesheet" href="resources/css/common.css" type="text/css">
<style>
   .notice_reply {
      border : 1px solid lightgray;
      border-radius: 5px;
      height: 30px;
      width : 720px;
      display: inline-flex;
   }
   
   input {
      margin : 0;
      
   }
   
   input[type="text"]{
       width : 621px;
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
        margin-left:10px;
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
     	border : none;
     	border-collapse: collapse;
     	padding : 10px 5px;
     }
     
     #noticereply_legnth{
     	margin-left: 10px;
     }
     
     #list {
     	margin-top: 10px;
     }
     
     .content{
     	width : 720px;
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
		<br>
		<br>
		<br>
		
	<div class="content">
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
	            <td>${notice.boardWriteDate} 조회수 : ${notice.boardbHit }</td>
	        </tr>      
	        <tr>
	            <td>${notice.boardDetail}</td>
	            <c:if test="${notice.serPhotoname ne null}">
				<tr>
					<td><img width="600" src="/photo/${notice.serPhotoname}" style="margin-left: 50px;"//></td>
				</tr>
				</c:if>
	    	 </tr>            
	   </table>
	     <div id="list">
			<!-- 공지사항 목록으로 돌아가기 -->
	        <input id="list" type="button" onclick='location.href="./noticelist.go"' value="목록">
	      </div>
	   <hr>
	   
	   <p>댓글</p>         
	   
		<!-- 문의글 댓글 리스트 가져오기 -->
	    <c:if test="${noticereplist.size() eq 0}">
			<tr><th colspan="10">등록된 답변이 없습니다.</th></tr>	
		</c:if>
		
		<c:if test="${userID ne null}">
			<c:forEach items="${noticereplist}" var="noticerep">
				<div class="inqrep">
					${noticerep.userID} / ${noticerep.commentWriteDate}
					<c:if test="${noticerep.userID eq sessionScope.userID}">
						<input type ="button" onclick='location.href="noticerepdel.do?replyNum=${noticerep.replyNum}&boardNum=${notice.boardNum}"' value="삭제"/>
						<input type ="button" onclick='location.href="noticerepupdate.go?replyNum=${noticerep.replyNum}&boardNum=${notice.boardNum}&commentDetail=${noticerep.commentDetail }"' value="수정"/>
					</c:if>
					<p>${noticerep.commentDetail }</p>
				</div>	
			</c:forEach>
		</c:if>
		
		<c:if test="${userID eq null}">
			<p>댓글을 작성하시거나 등록된 댓글을 확인하시려면 로그인 해주세요.</p>
		</c:if>
		
		<!-- 댓글 작성 -->
	    <form method="post" action="noticereplywrite.do">
	    	<input type="hidden" name="boardNum" value="${notice.boardNum}">
				    <c:if test="${userID ne null}">
					<div class="notice_reply">
				        <input name = "content" id="noticereply_text" type="text" maxlength="100" oninput="checkLength();" placeholder="${noticereply }">
				        <p id="noticereply_legnth">0/100</p>
				        <button type="submit">등록</button>
					</div>  
				</c:if>
	    </form>
    </div>
</div>
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