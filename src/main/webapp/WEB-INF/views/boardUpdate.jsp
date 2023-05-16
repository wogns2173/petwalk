<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="./resources/img/favicon.ico">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>    
	<script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
	<link rel="stylesheet" href="resources/css/common.css">
	<link rel= "stylesheet" href="resources/css/paging.css" type="text/css">
<style>
	#boardAll{
     	margin-left: 25px;
     }
     #categoryCode{
     	width: 150px;
     	height: 30px;
     }
     #boardName{
     	width: 614px;
	    height: 30px;
	    margin-bottom: 9px;
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
     #updatetitle{
     	color:#87d1bf;
     	font-size:30px;
     }
     #curPhoto{
     	
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
	<form action="boardUpdate.do" method="post" enctype="multipart/form-data" onsubmit="return submitHandler()">
		<div id="boardAll">
		<div>
			<input type="hidden" name="boardNum" value="${dto.boardNum}"/>
			 <input type="hidden" id="categoryCode" name="categoryCode" value="${dto.categoryCode}"/>
	        <h3 id ="updatetitle">작성 글 수정하기</h3>
	    </div>
	    
	    
	    <div>
	        <label for="boardName">제목:</label>
	        <input type="text" name="boardName" value="${dto.boardName}" id="boardName">
	    </div>
	    <div>
	        <label for="boardDetail"></label>
	        <textarea name="boardDetail" id="boardDetail" style="width : 658px; height: 337px;">${dto.boardDetail}</textarea>
	    </div>
	    <br/>
	    <div>
	    	<input type="file" name="photo" id = "fileInput" onchange="checkExtension()"/>
	    	<c:if test="${dto.serPhotoname ne null}">
	    		<c:if test="${dto.photoBlindWhether eq false }">
		        	<div id="curPhoto">
			            <p>현재 등록된 이미지: <span id="filename">${dto.serPhotoname}</span>
			             <a href="javascript:void(0)" id="deleteButton">삭제</a></p>
		        	</div>
		        </c:if>
	        	<input type="hidden" name="deletePhoto" value="false" id="deletePhotoInput">
	        	<input type="hidden" name="serPhotoname" value="${dto.serPhotoname}">
	    	</c:if>
	    </div>

    	<input type="button" value="취소" onclick="history.back()"/>
    	<button type="submit">저장</button>
    	 </div>
	</form>
	</div>
</body>
<script>

	
	function submitHandler() {
		var categoryCode = document.getElementById("categoryCode").value;
		var file = document.getElementById("fileInput");
		var fileName = file.value;
		var deletePhotoInput = document.getElementById("deletePhotoInput").value;
		console.log("file : " + file);
		console.log("fileName : " + fileName);
		console.log("deletePhotoInput : " + deletePhotoInput);
		if (deletePhotoInput == "true" && categoryCode == "B_01" && fileName == "") {
		  alert('반려견 갤러리는 사진 첨부가 필수입니다!');
		  return false;
		}
		
		if (deletePhotoInput == "false" && categoryCode == "B_01" && fileName == "") {
		  alert('반려견 갤러리는 사진 첨부 성공');
		  return false;
		}
		var boardName = document.getElementById('boardName').value;
		var boardDetail = document.getElementById('boardDetail').value;
	
		if (!boardName || !boardDetail){
			alert('제목, 내용을 입력해 주세요.');
			return false;
		}
	  }
	
	document.getElementById("deleteButton").addEventListener("click", function(){
	    document.getElementById("filename").remove();
	    document.getElementById("deleteButton").remove();
	    document.getElementById("deletePhotoInput").value = "true";
	    
	});
	
	//var categoryCode = document.getElementById("categoryCode").value;
	
	function checkExtension() {
		  var file = document.getElementById("fileInput");
		  var fileName = file.value;
		  var idx = fileName.lastIndexOf(".");
		
		  // 확장자명 추출
		  var ext = fileName.slice(idx + 1).toLowerCase();
		
		  // 확장자명이 jsp인 경우 경고창 출력
		  if (ext != "jpg" && ext != "png") {
		    alert("확장자가 .jpg, .png인 파일만 선택할 수 있습니다.");
		    file.value = "";
		    return false;
		  		}
		  if(document.getElementById("filename")) {
	             alert("이미 등록된 이미지가 있습니다. 새로운 이미지를 등록하려면 삭제 버튼을 눌러주세요.");
	             file.value = "";
	             return false;
	      		}
		  if(categoryCode == "B_01" && fileName == ""){
			    alert('반려견 갤러리는 사진 첨부가 필수입니다!');
			    return false;
			  }
	}
</script>
</html>