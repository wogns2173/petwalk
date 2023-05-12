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
<form method="post" action="reportwrite.do"  enctype="multipart/form-data">
	<div>
        <select id="categoryCode" name="categoryCode">
            <option value="B_12">프로필 신고</option>
            <option value="B_13">게시물 신고</option>
        </select>
    </div>
    <div>
        <label for="reportName">제목:</label>
        <input type="text" name="reportName">
    </div>
    <div>
        <label for="reportDetail">Content:</label>
        <textarea name="reportDetail" ></textarea>
    </div>
    <div>
    	첨부파일
    	<input type="file" name="photo"/>
    </div>
    <input type="button" onclick="location.href='./reportwrite.do'" value="취소"/>
    <button type="submit">등록</button>
</form>
</body>
<script>

</script>
</html>