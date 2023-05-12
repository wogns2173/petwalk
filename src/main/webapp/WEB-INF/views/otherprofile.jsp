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
	<c:if test="${pet.petSize == null}">
	등록된 반려견 정보가 없습니다.	
	</c:if>
	
	<c:if test="${pet.petSize != null }">
	<h3>반려견 프로필</h3>
		<table>
			<tr>
				<th>사진</th>
				<td>
					<img width="100" src="/photo/${pet.serPhotoname}"/>					
				</td>				
			</tr>			
			<tr>
				<th>견종 사이즈</th>
				<td>
					${pet.petSize}										
				</td>				
			</tr>				
			<tr>
				<th>이름</th>
				<td>
					${pet.petName}					
				</td>				
			</tr>
			<tr>
				<th>나이</th>
				<td>
					${pet.petAge} 살										
				</td>
			</tr>
			<tr>					
				<th>성별</th>
				<td>
					<input type="radio" name="petGender" value="남"<c:if test="${pet.petGender eq '남' }">checked</c:if>/>남아 &nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="petGender" value="여"<c:if test="${pet.petGender eq '여' }">checked</c:if>/>여아
				</td>				
			</tr>
			<tr>					
				<th>중성화 여부</th>
				<td>
					<input type="radio" name="petNeutered" value="1"<c:if test="${pet.petNeutered eq '1' }">checked</c:if>/>O &nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="petNeutered" value="0"<c:if test="${pet.petNeutered eq '0' }">checked</c:if>/>X
				</td>				
			</tr>
			<tr>					
				<th>반려견 소개</th>
				<td>
					${pet.petIntroduce}
				</td>				
			</tr>						      	
		</table>
		</c:if>
		
		<hr>
		
		<h3>공유한 산책 경로</h3>
		
		<c:if test="${routeShare == null}">
		공유한 산책 경로가 없습니다.<br/>		
		</c:if>
		<c:if test="${routeShare != null}">		
			<table class="table">
				<colgroup>					
					<col width="40%">
					<col width="40%">
					<col width="20%">
				</colgroup>
				<tbody id="tbody">					
		   			<tr>						
						<td>공유한 산책 경로 제목</td>
						<td>작성일자</td>
						<td>조회수</td>
					</tr>					
					<c:forEach items="${routeShare}" var="routeShare">
					<tr>
						<td><a href="detail.do?idx=${routeShare.walkNum}">${routeShare.walkName}</a></td>
						<td>${routeShare.walkDate}</td>						
					</tr>				
					</c:forEach>
					
				</tbody>
			</table>
		</c:if>
		
		<hr>

		<h3>산책 후기</h3>
		<c:if test="${review == null}">
		산책 후기가 없습니다.<br/>
		</c:if>
		<c:if test="${review != null}">
		<table>
			<tr>		
		         <th colspan="2">
		            
		         </th>
	      	</tr>		
		</table>
		</c:if>
		
		<hr>
		
	
</body>
<script>
console.log('${pet.serPhotoname}');
console.log('${pet.profileID}');
console.log('${pet.petSize}');
console.log('${pet.petName}');
console.log('${pet.petAge}');
console.log('${pet.petGender}');
console.log('${pet.petNeutered}');
console.log('${pet.petIntroduce}');
console.log('${inquiry}');
</script>
</html>