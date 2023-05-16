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
	<form method="post" action="boardWrite.do"  enctype="multipart/form-data" onsubmit="return checkPhoto()">
	<input type="hidden" name="userID" value="${userID}"/>
	<div id="boardAll">
	<div>
        <select id="categoryCode" name="categoryCode" onchange="checkPhoto()">
            <option value="B_01">반려견 갤러리</option>
            <option value="B_02">지식 공유 게시판</option>
            <option value="B_03">반려견 질문 게시판</option>
            <option value="B_04">미아견 게시판</option>
        </select>
        <label for="boardName">제목:</label>
        <input type="text" name="boardName" id="boardName" >
    </div>
    <hr/>
    <div>
        <label for="boardDetail"></label>
        <textarea name="boardDetail" id="boardDetail" style="width : 675px; height: 347px;"></textarea>
    </div>
    <div>
    	<input type="file" name="photo" id="photo" onchange="checkExtension()"/>
    </div>
    <div id="selectedFiles"></div>
    
    <input type="button" onclick="location.href='./boardList.go'" value="취소"/>
    <button type="submit">등록</button>
    </div>
</form>
</div>
</body>
<script>
	function checkExtension() {
	  var file = document.getElementById("photo");
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
	  const output = document.getElementById('selectedFiles');
	  output.innerHTML = '';

	  var uploadFiles = document.getElementById("photo")
	    for (var i = 0; i < uploadFiles.files.length; i++) {
	        var file = uploadFiles.files[i];
	        // 비동기 파일 업로드를 시작한다.
	        var uploader = new Uploader(file);
	        uploader.startUpload();
	    }
	    // 폼을 리셋해서 uploadFiles에 출력된 선택 파일을 초기화시킨다.
	    document.getElementById("uploadForm").reset();
	  
	}
	
	function checkPhoto(){
		  const categoryCode = document.getElementById('categoryCode').value;
		  const photoInput = document.getElementById('photo');
		    
		  if (categoryCode == 'B_01' && photoInput.value == '') {
		    alert('반려견 갤러리는 사진 첨부가 필수입니다.');
		    return false;
		  }
		  
		  const boardName = document.getElementById('boardName').value;
		  const boardDetail = document.getElementById('boardDetail').value;
		  
		  if (!boardName || !boardDetail){
		    alert('제목, 내용을 입력해 주세요.');
		    return false;
		  }
		  

		  
		}
	
	var categoryCode = '${param.categoryCode}';
	var categoryCodeSelect = document.getElementById('categoryCode');
	//console.log(${param.categoryCode});
	if(categoryCode == 'B_01'){
		categoryCodeSelect.value='B_01';
	}else if(categoryCode == 'B_02'){
		categoryCodeSelect.value='B_02';
	}else if(categoryCode == 'B_03'){
		categoryCodeSelect.value='B_03';
	}else{
		categoryCodeSelect.value='B_04';
	}
	
</script>
</html>