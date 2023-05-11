<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<style>
	
	 #title{
	 	color:#87d1bf;
	 }
	 
     table, th, td{
        border-collapse: collapse;
        padding : 10px 5px;
     }
     
     th {
     	color:#87d1bf;
     }
     
     input[type="submit"]{
        background-color: #87d1bf;
        color: white;
        border:none;
    }
    
    input[type="button"]{
    	background-color: #87d1bf;
        color: white;
        border:none;
       	width:110px;
       	height: 35px;
       	font-weight: bold;
       	margin-left: 130px;
       	margin-top: 30px;
    	}
</style>
</head>
<body>

<h3 id="title">회원 상세보기</h3>

<hr>
	<!-- 글 번호 -->
	<input type="hidden" name="memDetail" value="${mem.userID}">
	
	<!-- 회원 정보 디테일 가져오기 -->
	<table>
		<tr>
        	<th>아이디</th>
        	<td>${mem.userID}</td>
        </tr>   
        <tr>
            <th>이름</th>
            <td>${mem.userName}</td>
        </tr>
        <tr>         
            <th>닉네임</th>
            <td>${mem.userNickname}</td>
        </tr>      
        <tr>
        	<th>이메일</th>
        	<td>${mem.userEmail}</td>
  		</tr>
  		<tr>
        	<th>연락처</th>
        	<td>${mem.userContact}</td>
  		</tr>
  		<tr>
        	<th>생년월일</th>
        	<td>${mem.userBirthdate}</td>
  		</tr>
  		<tr>
        	<th>주소</th>
        	<td>${mem.siName} ${mem.guName} ${mem.dongName}</td>
  		</tr>
  		<tr>
        	<th>성별</th>
        	<td>${mem.userGender}</td>
  		</tr>
  		<tr>
        	<th>회원가입 날짜</th>
        	<td>${mem.userSignup}</td>
  		</tr>
  		<tr>
        	<th>블라인드 처리 여부</th>
        	<td>
        		<form id="memManageProcess" action="memManageProcess.go" method="POST">
		   			<div>
		   				<input type="hidden" name="userID" value="${mem.userID}">
						<select name="selectedValue" id="${mem.userID}">
					    	<option value="false">블라인드 미처리 상태</option>
					    	<option value="true">블라인드 처리 완료 상태</option>
					   </select>
					   <input type="submit" value="상태 변경">
		  		 	</div>
	   			</form>
   			</td>
  		</tr>
	</table>
	
	<!-- 회원 리스트로 돌아가기 -->
    <input type="button" onclick='location.href="./memManageList.go"' value="회원 리스트">
					   
	
	 
</body>
</html>
