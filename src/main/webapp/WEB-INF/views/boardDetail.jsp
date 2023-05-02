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
	<c:forEach items="dto">
		<h2>${dto.categoryCode}</h2>
		</br>
		<h1>${dto.boardName}</h1>
		</br>
		닉네임
		</br>
		<h3>${dto.boardWriteDate} 조회수: ${dto.boardbHit }</h3>
		</br>
		<c:if test="${dto.newFileName ne null}">
			<tr>
				<th>사진</th>
				<td><img width="300" src="/photo/${dto.serPhotoname }"/></td>
			</tr>
		</c:if>
		<h2>${dto.boardDetail}</h2>
	</c:forEach>
		<button>신고</button>
		<button>삭제</button>
		<button>수정</button>
		<button>목록</button>
</body>
<script>

</script>
</html>