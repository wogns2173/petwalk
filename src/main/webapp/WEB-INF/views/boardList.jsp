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
	<h3>반려견 갤러리</h3>
	<h3>지식 공유 게시판</h3>
	<a href="boardB_02list.do">더보기></a>
	<c:forEach items="${B_02list}" var="bbs">
	<ul>
		<li>${bbs.boardName} ${bbs.boardbHit }</li>
	</ul>
	</c:forEach>
	<h3>반려견 질문 게시판</h3>
	<h3>미아견 게시판</h3>
	
</body>
<script></script>
</html>