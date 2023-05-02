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
	<button onclick="location.href='join.go'">회원가입</button>
	<button onclick="location.href='login.go'">로그인</button>
	<button onclick="location.href='memberdelete.go'">회원탈퇴</button>
	

</body>
</html>
