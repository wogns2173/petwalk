<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>너나들이 비밀번호 수정</title>
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
			<br>
			<br>
			<br>
			<br>
<h3 id="title" style="text-align: center;">비밀번호 수정</h3>
	<table class="table" style="margin-left: auto; margin-right: auto;">
		<tr style="text-align: center;">
			<th id="title">현재 비밀번호</th>
			<td>
				<input type="password" id="nowuserPW"/>							
			</td>
		</tr>
		<tr style="text-align: center;">
			<th id="title">새 비밀번호</th>
			<td>
				<input type="password" id="changeuserPW"/></br>
				<span id="pwchkmsg"></span>			
			</td>
		</tr>
		<tr style="text-align: center;">
			<th id="title">새 비밀번호 확인</th>
			<td>
				<input type="password" id="confirm"/></br>
				<span id="pwmsg"></span>			
			</td>
		</tr>
		<tr style="text-align: center;">
       		<th colspan="2">
          		<button onclick="chguserpw()">확인</button>
          		<button onclick="location.href='./'">취소</button>
       		</th>
      	</tr>
	</table>
	</div>
</body>
<script>
var overlayPwChk = false;
var nowpwchk = false;
var pweq = false;

function chguserpw(){
	
	if(overlayPwChk && nowpwchk && pweq){
		
		var $nowuserPW = $('#nowuserPW');
		var $changeuserPW = $('#changeuserPW').val();
		var $confirm = $('#confirm');
		
		if($nowuserPW.val()==''){
			alert('현재 비밀번호를 입력해주세요.')
		}else if($nowuserPW.val()==''){
			alert('새 비밀번호를 입력해주세요.')
		}else{
			
			$.ajax({
				type:'post'
				,url:'chguserpw.ajax'
				,data:{'changeuserPW':$changeuserPW}
				,dataType:'json'
				,success:function(data){
					console.log(data);
					console.log(data.success);
					if(data.success == 1){
						alert('비밀번호 수정이 완료 되었습니다.');
						location.href ='./';
					}else{
						alert('비밀번호 수정에 실패 했습니다.\r\n 다시 시도해 주세요');
					}
				},
				error:function(e){
					console.log(e);
					alert('오류가 발생 했습니다.\r\n 다시 시도해 주세요');
				}
			});			
		}		
	}else{
		alert('비밀번호 확인를 해 주세요');
	}
}

$('#nowuserPW').on('keyup', function(e){
	var nowuserPW = $('#nowuserPW').val();  
	nowpwchk=false;
	
    $.ajax({
        type: 'get'
        ,url: 'overlaynowpw.ajax'
        ,data:{'nowuserPW':nowuserPW}
        ,dataType:'json'
        ,success:function(data){
           console.log(data);
           
           if(data.overlaynowpw != null) {        	                
        	   nowpwchk=true;  
 		  }		    	         
		}
        ,error:function(e){
           console.log(e);
        }
     });  
});


$('#changeuserPW').on('keyup', function(e){
	overlayPwChk=false;
	
    var chkPW = $('#changeuserPW').val();      
    
    console.log("현재 사용중인 비밀번호? : " + chkPW);
    console.log($('#changeuserPW').val().length);
    
    $.ajax({
       type: 'get'
       ,url: 'overlaypw.ajax'
       ,data:{'changeuserPW':chkPW}
       ,dataType:'json'
       ,success:function(data){
          console.log(data);
          if($('#changeuserPW').val().length <=7){
        	  $('#pwchkmsg').css({'font-size': '10px','color': 'dark'});
        		$('#pwchkmsg').html('비밀번호를 8자리 이상 입력해주세요.');
          }else if(data.overlaypw != null) {        	                
              $('#pwchkmsg').css({'font-size': '10px','color': 'red'});
        	  $('#pwchkmsg').html('현재 사용중인 비밀번호 입니다.');         	  
		  }else {
			  overlayPwChk=true;
	          	$('#pwchkmsg').css({'font-size': '10px','color': 'darkgreen'});
	   			$('#pwchkmsg').html('사용 가능한 비밀번호 입니다.');      	
          }
       }
       ,error:function(e){
          console.log(e);
       }
    });      
 });

	$('#confirm').on('keyup',function(e){	
		pweq = false;
		
		if($('#changeuserPW').val() == $('#confirm').val()){
			$('#pwmsg').css({'font-size': '10px','color': 'darkgreen'});
			$('#pwmsg').html('비밀번호가 일치 합니다.');
			pweq = true;
		}else{
			$('#pwmsg').css({'font-size':'10px','color': 'red'});
			$('#pwmsg').html('비밀번호가 일치 하지 않습니다');
		}		
	});
	

</script>
</html>