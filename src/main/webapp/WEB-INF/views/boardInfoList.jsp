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
	
	<select id="category" name="category" required>
            <option value="">검색 조건</option>
            <option value="boardName">제목</option>
            <option value="userNickname">닉네임</option>
            <option value="userID">ID</option>
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
				<td><a href="boardDetail.do?boardNum=${bbs.boardNum}">${bbs.boardName }</a></td>
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