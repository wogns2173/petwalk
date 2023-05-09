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
<style>
</style>
</head>
<body>
	<form action="boardUpdate.do" method="post" enctype="multipart/form-data">
	<div>
		<input type="hidden" name="boardNum" value="${dto.boardNum}"/>
		 <input type="hidden" name="categoryCode" value="${dto.categoryCode}"/>
        <h3>게시판 수정하기</h3>
    </div>
    
    <div>
        <label for="boardName">제목:</label>
        <input type="text" name="boardName" value="${dto.boardName}">
    </div>
    <div>
        <label for="boardDetail">내용:</label>
        <textarea name="boardDetail">${dto.boardDetail}</textarea>
    </div>
    
    <div>
    	첨부파일
    	<input type="file" name="photo" id = "fileInput" onchange="checkExtension()"/>
    	<c:if test="${dto.serPhotoname ne null}">
    		<c:if test="${dto.photoBlindWhether eq false }">
	        	<div>
		            <p>현재 등록된 이미지: <span id="filename">${dto.serPhotoname}</span>
		            <!-- <a href="photoDelete.do?serPhotoname=${dto.serPhotoname}&boardNum=${dto.boardNum}&categoryCode=${dto.categoryCode}">삭제</a></p> -->
		             <a href="javascript:void(0)" id="deleteButton">삭제</a></p>
	        	</div>
	        </c:if>
        	<input type="hidden" name="deletePhoto" value="false" id="deletePhotoInput">
        	<input type="hidden" name="serPhotoname" value="${dto.serPhotoname}">
    	</c:if>
    </div>
    <input type="button" value="취소" onclick="history.back()"/>
    <button type="submit">저장</button>
	</form>
</body>
<script>
		document.getElementById("deleteButton").addEventListener("click", function(){
		    document.getElementById("filename").remove();
		    document.getElementById("deleteButton").remove();
		    document.getElementById("deletePhotoInput").value = "true";
		});
		
		function checkExtension() {
			  var file = document.getElementById("fileInput");
			  var fileName = file.value;
			  var idx = fileName.lastIndexOf(".");
			
			  // 확장자명 추출
			  var ext = fileName.slice(idx + 1).toLowerCase();
			
			  // 확장자명이 jsp인 경우 경고창 출력
			  if (ext != "jsp" && ext != "png") {
			    alert("확장자가 .jsp인 파일만 선택할 수 있습니다.");
			    file.value = "";
			    return false;
			  }
			}
	//$(document).ready(function() {
		//$('input[type="file"]').change(function(e) {
			//var fileName = e.target.files[0].name;
			// $('#filename').text(fileName);
		//});
	//});
	
	/*
	// 이미지 파일 삭제 버튼 클릭 시 이벤트 핸들러 등록
	$('#deleteButton').click(function(event) {
		event.preventDefault(); // 버튼 기본 동작 중단
		$.ajax({
			url: 'photoDelete.ajax',
			type: 'POST',
			dataType: 'json',
			data: {
				'serPhotoname': '${dto.serPhotoname}',
				'boardNum': '${dto.boardNum}',
				'categoryCode': '${dto.categoryCode}'
			},
			success: function(data) {
				if (data.success) { // 삭제 성공 시
					$('#filename').text('이미지가 삭제되었습니다.');
				} else { // 삭제 실패 시
					alert('이미지 삭제에 실패하였습니다.');
				}
			},
			error: function(xhr, status, error) {
				alert('이미지 삭제 중 오류가 발생하였습니다.');
			}
		});
	});
	
	// 이미지 파일 선택 시 파일명 출력
	$('#fileInput').change(function(e) {
		var fileName = e.target.files[0].name;
		$('#filename').text(fileName);
	});
	
	// 취소 버튼 클릭 시 이벤트 핸들러 등록
	$('input[type="reset"]').click(function() {
		$('#filename').text('${dto.serPhotoname}');
	});
	*/
</script>
</html>