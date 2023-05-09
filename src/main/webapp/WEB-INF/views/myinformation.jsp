<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
<meta charset="UTF-8">
<title>너나들이 회원정보</title>
<script src = "https://code.jquery.com/jquery-3.6.4.min.js"></script>
<style>
		
</style>
</head>
<body>
	<jsp:include page="loginBox.jsp"></jsp:include>
	<h3>회원정보</h3>
		<table>
			<tr>
				<th>아이디</th>
				<td>
					<input type="text" id="userID" value="${member.userID}" readonly/>									
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>
					<input type="text" id="userName" value="${member.userName}" readonly/>					
				</td>				
			</tr>
			<tr>
				<th>닉네임</th>
				<td>
					<input type="text" id="userNickname" value="${member.userNickname}" readonly/>										
				</td>
			</tr>
			<tr>
				<th>E-MAIL</th>
				<td><input type="email" id="userEmail" value="${member.userEmail}" readonly/></td>
			</tr>	
			<tr>
				<th>연락처</th>
				<td><input type="text" id="userContact" value="${member.userContact}" readonly/></td>
			</tr>										
			<tr>
				<th>나이</th>
				<td><input type="text" id="userAge" value="${member.userAge}" readonly/></td>
			</tr>
			<tr>
				<th>생년월일</th>					
				<td><input type="text" id = userBirthdate value="${member.userBirthdate}"/></td>
			<tr>	
			<tr>
			<th>주소</th>
				<td>
					<input type="text" id = siName value="${member.siName} ${member.guName} ${member.dongName}"/>
				</td>
			</tr>
			<tr>			
				<th>성별</th>
				<td>
					<input type="radio" name="userGender" value="남"
					<c:if test="${member.userGender eq '남' }">checked</c:if>
					/>남자 &nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="userGender" value="여"
					<c:if test="${member.userGender eq '여' }">checked</c:if>
					/>여자
				</td>				
			</tr>	
			<tr>		
		         <th colspan="2">
		            <button onclick="location.href='myinformationupdate.go'">회원정보 수정</button>
		            <button onclick="location.href='changememberpw.go'">비밀번호 변경</button>
		            <button onclick="location.href='./'">돌아가기</button>
		         </th>
	      	</tr>
		</table>
</body>
<script>

</script>
</html>