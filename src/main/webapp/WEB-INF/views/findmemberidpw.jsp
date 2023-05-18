<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>너나들이 ID/PW 찾기</title>
<link rel="icon" href="./resources/img/favicon.ico">
<script src = "https://code.jquery.com/jquery-3.6.4.min.js"></script>
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
  	button{
    	background-color: #87d1bf;
    	border:none;
    	color: white;    	
    }
    #title {
		color: #87d1bf;
		margin-top: 10px; /* 갤러리 제목 위쪽 간격 조절 */
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
					<a href="routeshare/list?walkRouteType=공유">산책 경로 공유</a>
					<a href="matefind/list">산책 메이트</a>
					<a href="board">커뮤니티</a>
					<a href="noticelist.go">공지사항</a>
					<hr>					
				</div>															
		</div>
		<br/>
		<br/>
		<br/>
		<br/>
<c:if test="${findType eq '아이디'}">
<br/>
<div style="text-align: center;">
    <button id="idButton" onclick="location.href='findmemberidpw.go?findType=아이디'">아이디 찾기</button>
    <button id="pwButton" onclick="location.href='findmemberidpw.go?findType=비밀번호'">비밀번호 찾기</button>
</div>

	

<br/>			
<div id="title" style="text-align: center;">아이디가 생각나지 않으세요?</div>
<div style="text-align: center;">회원정보에 등록하신 이름과 이메일 주소를 입력해주세요</div>
<div style="text-align: center;">아래 입력하신 이름과 이메일 정보는 회원정보에 등록된 정보와 반드시 같아야 합니다.</div>
<hr/>
	<table style="margin-left: auto; margin-right: auto;">
		<tr>
			<th id="title" style="text-align: center;">이름</th>				
			<td id="title" style="text-align: center;"><input type="text" id="userName"/></td>									
		</tr>
		<tr>
			<th id="title" style="text-align: center;">이메일</th>
			<td id="title" style="text-align: center;"><input type="email" id="userEmail"/></td>									
		</tr>
		<tr>
       		<th colspan="2" id="title" style="text-align: center;">
          		<button onclick="findmemberid()">확인</button>
          		<button onclick="location.href='login.go'">취소</button>
       		</th>
   		</tr>
	</table>
</c:if>
<c:if test="${findType eq '비밀번호'}">
<br/>
	<div style="text-align: center;">
	    <button id="idButton" onclick="location.href='findmemberidpw.go?findType=아이디'">아이디 찾기</button>
    	<button id="pwButton" onclick="location.href='findmemberidpw.go?findType=비밀번호'">비밀번호 찾기</button>
	</div>
		<br/>			
<div id="title" style="text-align: center;">비밀번호가 생각나지 않으세요?</div>
<div style="text-align: center;">회원정보에 등록하신 이메일 주소로 임시 비밀번호를 발송해 드립니다.</div>
<div style="text-align: center;">아래 입력하신 이름과 아이디, 이메일 정보는 회원정보에 정보와 반드시 같아야 합니다.</div>
	<hr>
		<br>
		<table style="margin-left: auto; margin-right: auto;">
			<tr>
				<th id="title" style="text-align: center;">이름</th>
				<td id="title" style="text-align: center;">
					<input type="text" id="userName"/>					
				</td>
			</tr>
			<tr>
				<th id="title" style="text-align: center;">아이디</th>
				<td id="title" style="text-align: center;">
					<input type="text" id="userID"/>					
				</td>
			</tr>			
			<tr>
				<th id="title" style="text-align: center;">이메일</th>
				<td id="title" style="text-align: center;">
					<input type="text" id="userEmail"/>					
				</td>
			</tr>
			<tr>
         		<th colspan="2" id="title" style="text-align: center;">
            		<button onclick="findmemberpw()">확인</button>
            		<button onclick="location.href='login.go'">취소</button>
         		</th>
      		</tr>
		</table>
</c:if>
	</div>
</body>
<script>	

var urlParams = new URLSearchParams(window.location.search);

var findType = urlParams.get('findType');

if (findType === '아이디') {
	document.getElementById('pwButton').style.backgroundColor = '#e8e8e8';
}
if (findType === '비밀번호') {
    document.getElementById('idButton').style.backgroundColor = '#e8e8e8';
}



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
	               alert('이메일로 임시비밀번호를 전송했습니다.\r\n로그인 후 비밀번호를 변경해 사용해주세요.');
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