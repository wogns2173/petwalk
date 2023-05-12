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
<form method="post" action="noticewrite.do"  enctype="multipart/form-data">
	
    <div>
        <label for="noticeName">제목:</label>
        <input type="text" name="boardName">
    </div>
    <div>
        <label for="noticeDetail">Content:</label>
        <textarea name="boardDetail" ></textarea>
    </div>
    <div>
    	첨부파일
    	<input type="file" name="photo"/>
    </div>
    <input type="button" onclick="location.href='./noticewrite.do'" value="취소"/>
    <button type="submit">등록</button>
</form>
</body>
<script>

</script>
</html>