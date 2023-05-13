<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>너나들이 로그인</title>
<script src ="http://code.jquery.com/jquery-3.6.4.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<link rel="stylesheet" href="resources/css/common.css">

<style>
   .board-item {
    display: inline-block;
    vertical-align: top;
    text-align: center;
    margin-right: 10px;
    margin-bottom: 10px;
  }
  .board-item img {
    width: 117px;
    height: 117px;
    
  }
  .right-align{
  	float: right;
  }
</style>
</head>
<body>
<div class="main">
		<div class = "topMenu">
			<div class="logo">
				<a href="./">
					<img src="resources/img/logo.png" alt="logo">				
					<img src="resources/img/logoaname.png" alt="logoname">
				</a>	
			</div>			
				<div class="link">																		
					<c:if test="${empty sessionScope.userID}">
						<a href="login.go">로그인</a>
						<a href="join.go">회원가입</a>
					</c:if>
					
					<c:if test="${not empty sessionScope.userID}">
						<a href="myinformation.go">${sessionScope.userNickname} 님</a>
						<c:if test="${sessionScope.Role eq 'admin'}">
							<a href="adminPage.go">관리자 페이지</a>
						</c:if>
						<a href="logout">로그아웃</a>
						<a href="profile.go">프로필</a>
						<a href="memberdelete.go">회원탈퇴</a>
					</c:if>
					<br>				
					<a href="routeshare/list">산책 경로 공유</a>
					<a href="matefind/list">산책 메이트</a>
					<a href="board">커뮤니티</a>
					<hr>					
				</div>															
		</div>
		<br/>
		<br/>
		<br/>
		<br/>
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
   </div>
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