<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>너나들이</title>
</head>
<body>
	<jsp:include page="loginBox.jsp"></jsp:include>
	${msg}	
	<jsp:include page="loginBox.jsp"></jsp:include>
	<button onclick="location.href=''">추천 경로</button>
	<button onclick="location.href=''">산책 경로 공유</button>
	<button onclick="location.href=''">산책 메이트 찾기</button>
	<button onclick="location.href=''">커뮤니티</button>
	<hr>
	<h3>이런곳은 어떠세요?</h3>	
	<button onclick="location.href=''">더 알아보기</button>	
</body>
</html>
