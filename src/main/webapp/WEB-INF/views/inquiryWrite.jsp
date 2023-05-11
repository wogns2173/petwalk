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
<form method="post" action="inquirywrite.do"  enctype="multipart/form-data">
	<div>
        <select id="categoryCode" name="categoryCode">
            <option value="B_06">산책 경로 문의</option>
            <option value="B_07">게시글 문의</option>
            <option value="B_08">계정 문의</option>
            <option value="B_09">광고 문의</option>
            <option value="B_10">채팅 문의</option>
            <option value="B_11">기타 문의</option>
        </select>
    </div>
    <div>
        <label for="boardName">제목:</label>
        <input type="text" name="boardName">
    </div>
    <div>
        <label for="boardDetail">Content:</label>
        <textarea name="boardDetail" ></textarea>
    </div>
    <div>
    	첨부파일
    	<input type="file" name="photo"/>
    </div>
    <input type="button" onclick="location.href='./inquirywrite.do'" value="취소"/>
    <button type="submit">등록</button>
</form>
</body>
<script>

</script>
</html>