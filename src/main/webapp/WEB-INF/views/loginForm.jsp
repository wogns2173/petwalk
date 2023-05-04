<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>너나들이 로그인</title>
<script src ="http://code.jquery.com/jquery-3.6.4.min.js"></script>


<style>
   
</style>
</head>
<body>
   <h3>로그인</h3>
   <table>
      <tr>
         <th>아이디</th>
         <td><input type="text" id="userID"/></td>
      </tr>
      <tr>
         <th>비밀번호</th>
         <td><input type="password" id="userPW"/></td>
      </tr>
      <tr>
         <th colspan="2">

            <button onclick="login()">로그인</button>
            <button onclick="location.href='findmemberid.go'">아이디 찾기</button>
            <button onclick="location.href='findmemberpw.go'">비밀번호 찾기</button>
            <button onclick="location.href='join.go'">회원가입</button>
            <button onclick="location.href='./'">돌아가기</button>
         </th>
      </tr>
   </table>
</body>
<script>
function login(){		
	console.log(userID,userPW);
	$.ajax({
		type:'post'
			,url:'login.ajax'
			,data:{
				userID:$('#userID').val()
				,userPW:$('#userPW').val()
			}
			,dataType:'json'
			,success:function(data){
				console.log(data);

				if(data.member != null){
					alert('로그인에 성공 했습니다.');				

					location.href='main.go';
				}else{
					alert('아이디 또는 비밀번호를 확인해 주세요!');
				}
			}
			,error:function(e){
				console.log(e);
				alert('아이디 또는 비밀번호를 확인해 주세요!');
			}		
	});	
}
</script>
</html>