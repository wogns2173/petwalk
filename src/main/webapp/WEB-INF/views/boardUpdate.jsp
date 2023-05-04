<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<style></style>
</head>
<body>
	<form action="boardUpdate.do" method="post" enctype="multipart/form-data">
	<div>
		<input type="hidden" name="boardNum" value="${dto.boardNum}"/>
		 <input type="hidden" name="categoryCode" value="${dto.categoryCode}"/>
        <h3>게시판 수정하기</h3>
    </div>
    <div>
    
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
    	<input type="file" name="photo"/>
    	<c:if test="${dto.serPhotoname ne null}">
    	${dto.serPhotoname}
    	<a href="photoDelete.do?serPhotoname=${dto.serPhotoname}&boardNum=${dto.boardNum}&categoryCode=${dto.categoryCode}">삭제</a> 
    	</c:if>
    </div>
    <input type="button" onclick="location.href='./boardB_02list.do'" value="취소"/>
    <button type="submit">저장</button>
	</form>
</body>
<script></script>
</html>