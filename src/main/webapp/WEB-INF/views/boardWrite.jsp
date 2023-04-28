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
	<form action="boardWrite.do" method="post">
		<select>
	      <option value="B_01">반려견 갤러리</option>
	      <option value="B_02">지식 공유 게시판</option>
	      <option value="B_03">반려견 질문 게시판</option>
	      <option value="B_04">미아견 게시판</option>
	   </select>
		제목: <input type="text" name="boardName"/>
		</br>
		<textarea name="boardDetail"></textarea>
		</br>
		</br>
		<input type="button" onclick="location.href='./boardB_02list.do'" value="취소"/>
		<input type="submit" value="등록"/>
	</form>
</body>
<script></script>
</html>