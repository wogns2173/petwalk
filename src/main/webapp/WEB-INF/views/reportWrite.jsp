<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="./resources/img/favicon.ico">
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>    
<script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<link rel="stylesheet" href="resources/css/common.css">
<style>
	#boardAll{
        margin-left: 25px;
     }
     #categoryCode{
        width: 150px;
        height: 30px;
     }
     #boardName{
        width: 488px;
        height: 30px;
     }
     
     input[type="button"],button[type="submit"]{
        float: right;
        background-color: #87d1bf;
        color: white;
        border:none;
        width: 70px;
        height: 32px;
        margin-right: 18px;
        margin-top: 60px;
     }
     
     #title{
	 	color:#87d1bf;
	 	margin-left: 20px;
	 	margin-bottom: 30px;
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
      <br/>
      <br/>
      <br/>
      	<h3 id="title"> 신고 글 작성하기 </h3>
		<form method="post" action="reportwrite.do"  enctype="multipart/form-data">
			
			<input type="hidden" name="boardNum" value="${boardNum}">
		    <input type="hidden" name="reportID" value="${reportID}">
		    <div id="boardAll">
			<p> 신고 글 번호 : ${boardNum} / 신고 아이디 : ${reportID} <p>
			
			<div>
		        <select id="categoryCode" name="categoryCode">
		            <option value="B_12">프로필 신고</option>
		            <option value="B_13">게시물 신고</option>
		        </select>
		        <label for="reportName">제목:</label>
		        <input type="text" name="reportName">
		    </div>
		    <div>
		        <label for="reportDetail"></label>
		        <textarea name="boardDetail" id="boardDetail" style="width : 675px; height: 347px;"></textarea>
		    </div>
		    <div>
		    	첨부파일
		    	<input type="file" name="photo"/>
		    </div>
		    <input type="button" onclick="location.href='./reportwrite.do'" value="취소"/>
		    <button type="submit">등록</button>
		    </div>
		</form>
</div>
</body>
<script>

</script>
</html>