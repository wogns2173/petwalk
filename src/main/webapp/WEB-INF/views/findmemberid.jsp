<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>너나들이 아이디 찾기</title>
<script src = "https://code.jquery.com/jquery-3.6.4.min.js"></script>
<style></style>
</head>
<body>
<h3>아이디 찾기</h3>
	<table>
		<tr>
			<th>이름</th>				
			<td><input type="text" id="userName"/></td>									
		</tr>
		<tr>
			<th>이메일</th>
			<td><input type="email" id="userEmail"/></td>									
		</tr>
		<tr>
       		<th colspan="2">
          		<button onclick="findmemberid()">아이디 찾기</button>
          		<button onclick="location.href='login.go'">돌아가기</button>
       		</th>
   		</tr>
	</table>
</body>
<script>	
function findmemberid(){
	console.log(userName,userEmail);
	$.ajax({
		type:'post'
			,url:'findmemberid.ajax'
			,data:{
				userName:$('#userName').val()
				,userEmail:$('#userEmail').val()
			}
			,dataType:'json'
			,success:function(data){
				console.log(data);
				if(data.member != null){					
					alert('귀하의 아이디는'+data.member.userID+'입니다.');			
					location.href='findmemberpw.go';
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