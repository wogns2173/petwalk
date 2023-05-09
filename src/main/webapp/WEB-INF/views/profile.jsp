<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
<meta charset="UTF-8">
<title>너나들이 프로필</title>
<script src = "https://code.jquery.com/jquery-3.6.4.min.js"></script>
<style>
		
</style>
</head>
<body>
	<jsp:include page="loginBox.jsp"></jsp:include>
	<h3>반려견 프로필</h3>
		<table>
			<tr>
				<th>견종 사이즈</th>
				<td>
					<select>
						<option value="">사이즈를 선택해 주세요.</option>
						<option value="대형견">대형견</option>
						<option value="중형견">중형견</option>
						<option value="소형견">소형견</option>
					</select>					
				</td>				
			</tr>				
			<tr>
				<th>이름</th>
				<td>
					<input type="text" id="petName" />					
				</td>				
			</tr>
			<tr>
				<th>나이</th>
				<td>
					<input type="number" id="userNickname" />										
				</td>
			</tr>
			<tr>					
				<th>성별</th>
				<td>
					<input type="radio" name="petGender" value="남"/>남아 &nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="petGender" value="여"/>여아
				</td>				
			</tr>
			<tr>					
				<th>중성화 여부</th>
				<td>
					<input type="radio" name="petNeutered" value="true"/>O &nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="petNeutered" value="false"/>X
				</td>				
			</tr>
			<tr>					
				<th>반려견 소개</th>
				<td>
					<input type="text" id="petIntroduce"/>
				</td>				
			</tr>		
			<tr>		
		         <th colspan="2">
		            <button onclick="location.href='petprofileupdate.go'">반려견 정보 수정</button>		            
		            <button onclick="location.href='./'">돌아가기</button>
		         </th>
	      	</tr>
		</table>
</body>
<script>

</script>
</html>