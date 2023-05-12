<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src = "https://code.jquery.com/jquery-3.6.4.min.js"></script>
<style></style>
</head>
<body>
<jsp:include page="loginBox.jsp"></jsp:include>
<button onclick="location.href='inquirylist.go'">문의 관리</button>
<button onclick="location.href='reportList.go'">신고 관리</button>
<button onclick="location.href='memManageList.go'">회원 관리</button>
<button onclick="location.href=''">공지사항 관리</button>

</body>
<script>

</script>
</html>