<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<<<<<<< HEAD
<title>너나들이</title>
<link rel="icon" href="./resources/img/favicon.ico">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
=======
<title>Insert title here</title>
<link rel="icon" href="./resources/img/favicon.ico">
>>>>>>> origin/master
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>    
<script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<link rel="stylesheet" href="resources/css/common.css" type="text/css">
<style>
   .report_reply {
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
    
    input[type="submit"]{
  		
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
     
     #reportreply_legnth {
       float: right;
        border:none;
        font-size: 14px;
        color : lightgray;
        
     }
     
     .inqrep {
     	border : 1px solid lightgray;
     	border-collapse: collapse;
     	padding : 10px 5px;
     }
     
     table, th, td{
     	border : none;
     	border-collapse: collapse;
     	padding : 10px 5px;
     }
     
     #reportreply_legnth{
     	margin-left: 22px;
     }
     
     #list {
     	margin-top: 20px;
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
					<a href="routeshare/list">산책 경로 공유</a>
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
	<input type="hidden" name="inquiry" value="${rep.reportNum}">
	
	<!-- 신고 글 디테일 가져오기  -->
	<table>
		<tr>
        	<th>${rep.reportName }</th>
        </tr>   
        <tr>
            <td>${rep.userID} </td>
        </tr>
        <tr>         
            <td>${rep.reportDate}</td>
        </tr>      
        <tr>
            <td>${rep.reportDetail}</td>
            <c:if test="${rep.serPhotoname ne null}">
			<tr>
				<td><img width="600" src="/photo/${rep.serPhotoname}" style="margin-left: 50px;"/></td>
			</tr>
			</c:if>
    	 </tr>            
   </table>
   
   <c:if test="${Role eq 'admin'}">
   <form id="reportprocess" action="reportprocess.go" method="POST">
	   <div>
		   <select name="selectedValue" id="${rep.reportNum}">
		      <option value="false">미처리</option>
		      <option value="true">처리완료</option>
		   </select>
		   <input type="hidden" name="reportNum" value="${rep.reportNum}">
		   <input type="submit" value="저장">
	   	</div>
   	</form>
   	</c:if>
		<div id="list">
		   	<c:if test="${Role eq 'admin'}">
				<!-- 관리자 신고글 목록으로 돌아가기 -->
		        <input type="button" onclick='location.href="./reportList.go"' value="목록">
			</c:if>        
		      <c:if test="${Role eq 'user'}">
		    	<!-- 내 프로필 돌아가기 -->
		        <input type="button" onclick='location.href="./profile.go"' value="뒤로가기">
		   </c:if>
		 </div>
   <hr>
   
   <p>답변</p>         
   
	<!-- 신고글 댓글 리스트 가져오기 -->
    <c:if test="${repreplist.size() eq 0}">
		<tr><th colspan="10">등록된 답변이 없습니다.</th></tr>	
	</c:if>
	
	<c:forEach items="${repreplist}" var="report">
		<div class="report">
			${report.userID}
			<c:if test="${Role eq 'admin'}">
				<c:if test="${report.userID eq sessionScope.userID}">
					<input type ="button" onclick='location.href="reprepdel.do?repReplyNum=${report.repReplyNum}&reportNum=${rep.reportNum}"' value="삭제"/>
					<input type ="button" onclick='location.href="reprepupdate.go?repReplyNum=${report.repReplyNum}&reportNum=${rep.reportNum}&reportProcess=${report.reportProcess }"' value="수정"/>
					<p>${report.reportProcess }</p>
				</c:if>
			</c:if>
		</div>	
	</c:forEach>
	<c:if test="${Role eq 'admin'}">
	<!-- 댓글 수정 -->
    <form method="post" action="reportreplyupdate.do">
		<div class="report_reply">
		    <input type="hidden" name="reportNum" value="${rep.reportNum}">
		    <input type="hidden" name="repReplyNum" value ="${repreplist2.repReplyNum}">
	        <input name = "reportProcess" id="reportreply_text" type="text" maxlength="100" oninput="checkLength();" placeholder= "${reportreply}">
	        <p id="reportreply_legnth">0/100</p>
	        <button type="submit">수정</button>
		</div>  
    </form>
    </c:if>
</div>
</div>
</body>
<script>

	/* 댓글 작성 글자 수 표시 */
	function checkLength() {
	    var maxLength = 100;
	    var length = document.getElementById("reportreply_text").value.length;
	    var lengthElement = document.getElementById("reportreply_legnth");
	    lengthElement.innerHTML = length + "/" + maxLength;
	  }
  	
</script>
</html>