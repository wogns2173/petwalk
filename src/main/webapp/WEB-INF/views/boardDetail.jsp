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
	<!-- <c:forEach items="dto">-->
		<input type="hidden" name="categoryCode">${dto.categoryCode}</input>
		</br>
		<h1>${dto.boardName}</h1>
		</br>
		닉네임
		</br>
		<h3>${dto.boardWriteDate} 조회수: ${dto.boardbHit }</h3>
		</br>
		<c:if test="${dto.serPhotoname ne null}">
			<tr>
				<td><img width="300" src="/photo/${dto.serPhotoname}"/></td>
			</tr>
			
		</c:if>
		<h2>${dto.boardDetail}</h2>
		<button>신고</button>
		<input type= "button" onclick="location.href='./boardDelete.do?boardNum=${dto.boardNum}'" value="삭제"/>
		<input type= "button" onclick="location.href='./boardUpdate.go?boardNum=${dto.boardNum}&categoryCode=${dto.categoryCode}'" value="수정"/>
		<button>목록</button>
	<!--</c:forEach>-->
</body>
<script>

</script>
</html>