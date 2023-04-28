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


<h3> 문의 리스트 </h3>

	<!-- 문의 필터링  -->
	<select>
		<option selected>문의 필터링</option>
		<option value="inq_01">산책 경로 문의</option>
		<option value="inq_02">게시글 문의</option>
		<option value="inq_03">계정 문의</option>
		<option value="inq_04">채팅 문의</option>
		<option value="inq_05">광고 문의</option>
		<option value="inq_06">기타 문의</option>
	</select>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	
	<!-- 처리 여부 필터링  -->
	<select>
		<option selected>처리 여부 필터링</option>
		<option value="inq_01">미처리</option>
		<option value="inq_02">처리완료</option>
	</select>
	
	<hr>
	
	<!-- 문의 게시판 리스트  -->
	<table>
		<c:if test="${inqlist.size() eq 0}">
			<tr><th colspan="10">게시물이 없습니다.</th></tr>	
		</c:if>
			<c:forEach items="${inqlist}" var="inq">
				<tr>
					<td><a href="inquirydetail.do?boardNum=${inq.boardNum}">${inq.boardName }</a></td>
					<td>${inq.userID }</td>
					<td>${inq.boardbHit }</td>
					<td>${inq.boardWriteDate }</td>
				</tr>	
			</c:forEach>
	</table>
	

</body>
<script></script>
</html>