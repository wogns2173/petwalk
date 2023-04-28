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

	<table>
		<tr>
			<th>${inq.boardName }</th>
		</tr>	
		<tr>
			<td>${inq.userID}</td>
		</tr>
		<tr>			
			<td>${inq.boardWriteDate}</td>
		</tr>		
		<tr>
			<td>${inq.boardbHit}</td>
		</tr>				
	</table>
	<select>
		<option selected>미처리</option>
		<option>처리완료</option>
	</select>
			
		<p><a href="./inquiry">목록</a><p>
				
	
				
		
		
	

</body>
<script></script>
</html>