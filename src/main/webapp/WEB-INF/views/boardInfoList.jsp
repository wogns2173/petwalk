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
	<h3> 지식 공유 게시판 리스트 </h3>
	
	<select name="categoryCode">
      <option value="B_01">반려견 갤러리</option>
      <option value="B_02">지식 공유 게시판</option>
      <option value="B_03">질문 게시판</option>
      <option value="B_04">미아견 게시판</option>
   </select>
	<table>
		<colgroup>
			<col width=10%/>
			<col width=40%/>
			<col width=20%/>
			<col width=20%/>
			<col width=10%/>
		</colgroup>
		<thead>
			<tr>
				<th>글번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${B_02list}" var="bbs">
			<tr>
				<td>${bbs.boardNum }</td>
				<td>${bbs.boardName }</td>
				<td>${bbs.userID }</td>
				<td>${bbs.boardWriteDate }</td>
				<td>${bbs.boardbHit }</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<button onclick="location.href='boardWrite.go'">글쓰기</button>
</body>
<script></script>
</html>