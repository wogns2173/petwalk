<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>너나들이 비밀번호 찾기</title>
<script src = "https://code.jquery.com/jquery-3.6.4.min.js"></script>
<style></style>
</head>
<body>
<h3>비밀번호 찾기</h3>
		<table>
			<tr>
				<th>이름</th>
				<td>
					<input type="text" id="userName"/>					
				</td>
			</tr>
			<tr>
				<th>아이디</th>
				<td>
					<input type="text" id="userID"/>					
				</td>
			</tr>			
			<tr>
				<th>이메일</th>
				<td>
					<input type="text" id="userEmail"/>					
				</td>
			</tr>
			<tr>
         		<th colspan="2">
            		<button onclick="findmemberpw()">비밀번호 찾기</button>
            		<button onclick="location.href='login.go'">돌아가기</button>
         		</th>
      		</tr>
		</table>
</body>
<script>
function findmemberpw(){
	console.log(userName,userID,userEmail);
	$.ajax({
		type:'post'
			,url:'findmemberpw.ajax'
			,data:{
				userName:$('#userName').val()
				,userID:$('#userID').val()
				,userEmail:$('#userEmail').val()
			}
			,dataType:'json'
			,success:function(data){
				console.log(data);
				if(data.findpw != null){					
					alert('임시비밀번호는'+data.findpw+'입니다.\r\n로그인 후 비밀번호를 변경해 사용해주세요.');
					location.href='login.go';
				}else{
					alert('일치하는 회원정보가 없습니다.');
				}
			}
			,error:function(e){
				console.log(e);
				alert('오류가 발생했습니다 다시 시도해 주세요');
			}		
	});	
}
</script>
</html>