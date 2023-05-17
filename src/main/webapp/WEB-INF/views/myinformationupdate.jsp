<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
<meta charset="UTF-8">
<title>너나들이 회원정보 수정</title>
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
	<h3 id="title" style="text-align: center;">회원정보 수정</h3>
		<br/>
		<br/>

		<table class="table" style="margin-left: auto; margin-right: auto;">			
			<tr>
				<th id="title">이름</th>
				<td>
					<input type="text" id="userName" value="${member.userName}"/>						
					<button id="updateusername">수정</button><br/>			
					<span id="namemsg"></span>
				</td>				
			</tr>
			<tr>
				<th id="title">닉네임</th>
				<td>
					<input type="text" id="userNickname" value="${member.userNickname}"/>	
					<button id="updateusernickname">수정</button><br/>
					<span id="nicknamechkmsg"></span>								
				</td>
			</tr>
			<tr>
				<th id="title">이메일</th>
				<td>
					<input type="email" id="userEmail" value="${member.userEmail}"/>
					<button id="updateuseremail">수정</button><br/>
					<span id="useremailmsg"></span>
				</td>
			</tr>	
			<tr>
				<th id="title">연락처</th>
				<td>								
					<input type="number" id="ftphn" maxlength="3" value="010" readonly="readonly"/>
					<input type="number" id="mdphn" value="${mdphn}" oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);" maxlength="4" />
					<input type="number" id="ltphn" value="${lstphn}" oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);" maxlength="4" />				
					<button id="updateuserContact">수정</button><br/>
					<span id="userecontactmsg"></span>
				</td>
			</tr>										
			<tr>
				<th id="title">나이</th>
				<td>
					<input type="number" id="userAge" value="${member.userAge}"/>
					<button id="updateuserAge">수정</button><br/>
					<span id="userAgemsg"></span> 
				</td>
			</tr>
			<tr>
				<th id="title">생년월일</th>					
				<td>					
					<input type="number" id="year" min="1900" max="2023" value="${year}" oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);" maxlength="4" />
					<select id="month">
						<option value="01"<c:if test="${month eq '1' }">selected</c:if>>1</option>
						<option value="02"<c:if test="${month eq '2' }">selected</c:if>>2</option>
						<option value="03"<c:if test="${month eq '3' }">selected</c:if>>3</option>
						<option value="04"<c:if test="${month eq '4' }">selected</c:if>>4</option>
						<option value="05"<c:if test="${month eq '5' }">selected</c:if>>5</option>
						<option value="06"<c:if test="${month eq '6' }">selected</c:if>>6</option>
						<option value="07"<c:if test="${month eq '7' }">selected</c:if>>7</option>
						<option value="08"<c:if test="${month eq '8' }">selected</c:if>>8</option>
						<option value="09"<c:if test="${month eq '9' }">selected</c:if>>9</option>
						<option value="10"<c:if test="${month eq '10' }">selected</c:if>>10</option>
						<option value="11"<c:if test="${month eq '11' }">selected</c:if>>11</option>
						<option value="12"<c:if test="${month eq '12' }">selected</c:if>>12</option>											
					</select>
					<input type="number" id="day" min="1" max="31" value="${day}"oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);" maxlength="2" />
					
					<button id="updateuserBirthdate">수정</button><br/>
					<span id="userBirthdatemsg"></span>
				</td>
			</tr>	
			<tr>
				<th id="title">주소</th>
				<td>
					<select id="siID">
						<option value="">시를 선택하세요</option>																					
						<option value="1"<c:if test="${member.siID eq '1' }">selected</c:if>>서울특별시</option>
		<!--  			  	<option value="부산 광역시">부산 광역시</option>
					  	<option value="인천 광역시">인천 광역시</option>
					  	<option value="대구 광역시">대구 광역시</option>
					  	<option value="광주 광역시">광주 광역시</option>
					  	<option value="대전 광역시">대전 광역시</option>
					  	<option value="울산 광역시">울산 광역시</option>-->
					</select>
					<select id="guID">
						  <option value="">구를 선택하세요</option>					  
						 <!-- <option value="종로구">종로구</option>
						  <option value="중구">중구</option>
						  <option value="용산구">용산구</option>
						  <option value="성동구">성동구</option>
						  <option value="광진구">광진구</option>
						  <option value="동대문구">동대문구</option>
						  <option value="중랑구">중랑구</option>
						  <option value="성북구">성북구</option>
						  <option value="강북구">강북구</option>
						  <option value="도봉구">도봉구</option>
						  <option value="노원구">노원구</option>
						  <option value="은평구">은평구</option>
						  <option value="서대문구">서대문구</option>
						  <option value="마포구">마포구</option>
						  <option value="양천구">양천구</option>
						  <option value="강서구">강서구</option>
						  <option value="구로구">구로구</option>
						  <option value="금천구">금천구</option>
						  <option value="영등포구">영등포구</option>
						  <option value="동작구">동작구</option>
						  <option value="관악구">관악구</option>
						  <option value="서초구">서초구</option>-->
						  <option value="3"<c:if test="${member.guID eq '3' }">selected</c:if>>강남구</option>
						 <!-- <option value="송파구">송파구</option>
						  <option value="강동구">강동구</option>-->
					</select>
					<select id ="dongID">
					  	<option value="">동을 선택하세요</option>
					      <!--  <option value="개포동">개포동</option>-->
					      <option value="2" <c:if test="${member.dongID eq '2' }">selected</c:if>>논현동</option>
					      <!-- <option value="대치동">대치동</option>
					      <option value="도곡동">도곡동</option>
					      <option value="삼성동">삼성동</option>
					      <option value="세곡동">세곡동</option>
					      <option value="수서동">수서동</option>
					      <option value="신사동">신사동</option>
					      <option value="압구정동">압구정동</option>
					      <option value="역삼동">역삼동</option>
					      <option value="일원동">일원동</option>
					      <option value="청담동">청담동</option> -->
					</select>
					<button id="updateuseraddress">수정</button><br/>
					<span id="useraddressmsg"></span>
				</td>
			</tr>		
			<tr>	
				<th id="title">성별</th>
				<td>
					<input type="radio" name="userGender" value="남"
					<c:if test="${member.userGender eq '남' }">checked</c:if>
					/>남자 &nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="userGender" value="여"
					<c:if test="${member.userGender eq '여' }">checked</c:if>
					/>여자
					<button id="updateuserGender">수정</button><br/>
					<span id="usergendermsg"></span>
				</td>				
			</tr>		
			<tr style="text-align: center;">	
	         <th colspan="2">	            
	            <button onclick="location.href='./'">돌아가기</button>
	         </th>
	      	</tr>
		</table>
		</div>
</body>
<script>
var overlaynickname = false;

var userNickname = $('#userNickname').val();


$('#updateusername').on('click', function(e){
	console.log('이름 변경 요청');	
	console.log(username);
	
	var username = $('#userName').val();
	
	if(username==''){
		$('#namemsg').css({'font-size': '10px','color': 'red'});
		$('#namemsg').html('변경할 이름을 입력해주세요.');
		$('#userName').focus();
	}else{
	$.ajax({
	       type: 'get'
	       ,url: 'updateusername.ajax'
	       ,data:{'username':username}
	       ,dataType:'json'
	       ,success:function(data){
	          console.log(data);
	          
	          if(data.success ==1){
	        	  $('#namemsg').css({'font-size': '10px','color': 'darkgreen'});
	        		$('#namemsg').html('이름이 변경 되었습니다.');	        		
	          }else{
	        	  $('#namemsg').css({'font-size': '10px','color': 'red'});
	        		$('#namemsg').html('이름 변경에 실패했습니다.');
	          }   
	       }
	       ,error:function(e){
	          console.log(e);
	        $('#namemsg').css({'font-size': '10px','color': 'red'});
      		$('#namemsg').html('이름 변경중 오류가 발생했습니다.');
	       }
	    });
	}
});

$('#userNickname').on('keydown', function(e){
	overlaynickname=false;
});

$('#userNickname').on('keyup', function(e){
	console.log('닉네임 변경 요청');
	overlaynickname=false;	
	
	userNickname = $('#userNickname').val();
	
		$.ajax({
		       type: 'get'
		       ,url: 'overlaynickname.ajax'
		       ,data:{'userNickname':userNickname}
		       ,dataType:'json'
		       ,success:function(data){
		          console.log(data);
		          if(userNickname.length <=1 || userNickname.length >=11){
		        	  $('#nicknamechkmsg').css({'font-size': '10px','color': 'dark'});
		        		$('#nicknamechkmsg').html('닉네임을 2자리 이상 10자리 이하로 입력해주세요.');
		          }else if(data.overlaynickname == 1) {        	                
		              $('#nicknamechkmsg').css({'font-size': '10px','color': 'red'});
		        	  $('#nicknamechkmsg').html('현재 사용중인 닉네임 입니다.');         	  
				  }else {
					  overlaynickname=true;
			          	$('#nicknamechkmsg').css({'font-size': '10px','color': 'darkgreen'});
			   			$('#nicknamechkmsg').html('사용 가능한 닉네임 입니다.');      	
		          }
		       }
		       ,error:function(e){
		          console.log(e);
		       }
		});			
});

$('#updateusernickname').on('click', function(e){
	console.log('닉네임 변경 요청');
	
	userNickname = $('#userNickname').val();	
	
	if(overlaynickname){
		$.ajax({
		       type: 'get'
		       ,url: 'updateusernickname.ajax'
		       ,data:{'userNickname':userNickname}
		       ,dataType:'json'
		       ,success:function(data){
		          console.log(data);
		          
		          if(data.success ==1){
		        	  $('#nicknamechkmsg').css({'font-size': '10px','color': 'darkgreen'});
		        		$('#nicknamechkmsg').html('닉네임이 변경 되었습니다.');	        		
		          }else{
		        	  $('#nicknamechkmsg').css({'font-size': '10px','color': 'red'});
		        		$('#nicknamechkmsg').html('닉네임 변경에 실패했습니다.');
		          }   
		       }
		       ,error:function(e){
		          console.log(e);
		        $('#nicknamechkmsg').css({'font-size': '10px','color': 'red'});
	      		$('#nicknamechkmsg').html('닉네임 변경중 오류가 발생했습니다.');
		       }
		    });
	}else{
		alert('닉네임을 확인해 주세요.');
		$('#userNickname').focus();
	}
});


$('#updateuseremail').on('click', function(e){
	console.log('이메일 변경 요청');
	var useremail=$('#userEmail').val();
	
	if(useremail==''){
		$('#useremailmsg').css({'font-size': '10px','color': 'red'});
		$('#useremailmsg').html('변경할 이메일을 입력해주세요.');
		$('#userEmail').focus();
	}else{				
	$.ajax({
	       type: 'get'
	       ,url: 'updateuseremail.ajax'
	       ,data:{'useremail':useremail}
	       ,dataType:'json'
	       ,success:function(data){
	          console.log(data);
	          
	          if(data.success ==1){
	        	  $('#useremailmsg').css({'font-size': '10px','color': 'darkgreen'});
	        		$('#useremailmsg').html('이메일이 변경 되었습니다.');	        		
	          }else{
	        	  $('#useremailmsg').css({'font-size': '10px','color': 'red'});
	        		$('#useremailmsg').html('이메일 변경에 실패했습니다.');
	          }   
	       }
	       ,error:function(e){
	          console.log(e);
	        $('#useremailmsg').css({'font-size': '10px','color': 'red'});
   		$('#useremailmsg').html('이메일 변경중 오류가 발생했습니다.');
		}
	});      
	}
});

$('#updateuserContact').on('click', function(e){
	console.log('연락처 변경 요청');
	
	var ftphn = $('#ftphn').val();
	var mdphn = $('#mdphn').val();
	var ltphn = $('#ltphn').val();
	
	var userContact = ftphn+mdphn+ltphn;
	
	 if(mdphn.length <= 3){
   	  $('#userecontactmsg').css({'font-size': '10px','color': 'red'});
   		$('#userecontactmsg').html('연락처 중간 4자리를 모두 입력해주세요.');
   		$('#mdphn').focus();
     }else if(ltphn.length <= 3){
   	  $('#userecontactmsg').css({'font-size': '10px','color': 'red'});
   		$('#userecontactmsg').html('연락처 마지막 4자리를 모두 입력해주세요.');
   		$('#ltphn').focus();
     }else{
	
		$.ajax({
	       type: 'get'
	       ,url: 'updateuserContact.ajax'
	       ,data:{'usereContact':userContact}
	       ,dataType:'json'
	       ,success:function(data){
	          console.log(data);
	          
	          if(data.success ==1){
	        	  $('#userecontactmsg').css({'font-size': '10px','color': 'darkgreen'});
	        		$('#userecontactmsg').html('연락처가 변경 되었습니다.');	        		
	          }else{
	        	  $('#userecontactmsg').css({'font-size': '10px','color': 'red'});
	        		$('#userecontactmsg').html('연락처 변경에 실패했습니다.');
	          }   
	       }
	       ,error:function(e){
	          console.log(e);
	        $('#userecontactmsg').css({'font-size': '10px','color': 'red'});
			$('#userecontactmsg').html('연락처 변경중 오류가 발생했습니다.\r\n다시 시도해주세요');
		}
	});
	}
});
$('#updateuserAge').on('click', function(e){
	console.log('나이 변경 요청');
	
	var userage = $('#userAge').val();
	
	if(userage ==''){
  	  $('#userAgemsg').css({'font-size': '10px','color': 'red'});
  		$('#userAgemsg').html('변경할 나이를 입력해주세요.');
  		$('#userAge').focus();
	}else{
	$.ajax({
	       type: 'get'
	       ,url: 'updateuserAge.ajax'
	       ,data:{'userAge':userage}
	       ,dataType:'json'
	       ,success:function(data){
	          console.log(data);	          
	          
	          if(data.success == 1){
	        	  $('#userAgemsg').css({'font-size': '10px','color': 'darkgreen'});
	        		$('#userAgemsg').html('나이 변경에 성공했습니다.');
	          }else{
	        	  $('#userAgemsg').css({'font-size': '10px','color': 'red'});
	        		$('#userAgemsg').html('나이 변경에 실패했습니다.');
	          }   
	       }
	       ,error:function(e){
	          console.log(e);
	        $('#userAgemsg').css({'font-size': '10px','color': 'red'});
		$('#userAgemsg').html('나이 변경중 오류가 발생했습니다.\r\n다시 시도해주세요');
		}
	});
	}
});

$('#updateuserBirthdate').on('click', function(e){
	console.log('생년월일 변경 요청');
	
	var year = $('#year');
	var month = $('#month');
	var day = $('#day');
	var userBirthdate = year.val()+month.val()+day.val();
	
	console.log(year);
	console.log(month);
	console.log(day);
	
	if(year.val().toString().length <= 3){	        	  
  	  $('#userBirthdatemsg').css({'font-size': '10px','color': 'red'});
  		$('#userBirthdatemsg').html('태어난 년도 4자리를 입력해 주세요.');
    }else if(year.val() <= 1900  || year.val() > 2023){
		alert('태어난 년도를 4자리를 정확히 입력해 주세요!');
		year.focus();
	}else if(day.toString().length<=1 || day <=0 || day >31){
		alert('태어난 일(날짜) 을 2자리 정확히 입력해 주세요!\r\n ex)01 or 02');
		day.focus();
	}else if(day.val().toString().length<=1){
  	  $('#userBirthdatemsg').css({'font-size': '10px','color': 'red'});
  		$('#userBirthdatemsg').html('생년월일 중 날짜를 2자리 입력해 주세요!\r\n ex)01 or 02');
    }else{
    	
	$.ajax({
	       type: 'get'
	       ,url: 'updateuserBirthdate.ajax'
	       ,data:{'userBirthdate':userBirthdate}
	       ,dataType:'json'
	       ,success:function(data){
	          console.log(data);
	          
	          if(data.success ==1){
	        	  $('#userBirthdatemsg').css({'font-size': '10px','color': 'darkgreen'});
	        		$('#userBirthdatemsg').html('생년월일 변경 되었습니다.');	        		
	          }else{
	        	  $('#userBirthdatemsg').css({'font-size': '10px','color': 'red'});
	        		$('#userBirthdatemsg').html('생년월일 변경에 실패했습니다.');
	          }   
	       }
	       ,error:function(e){	          
	        $('#userBirthdatemsg').css({'font-size': '10px','color': 'red'});
			$('#userBirthdatemsg').html('생년월일 변경중 오류가 발생했습니다.\r\n다시 시도해주세요');
		}
	});
    }
});
$('#updateuseraddress').on('click', function(e){
	console.log('주소(시/구/동) 변경 요청');
	
	var siID = $('#siID').val();
	var guID = $('#guID').val();
	var dongID = $('#dongID').val();
	
	 if(siID == null){
   	  $('#useraddressmsg').css({'font-size': '10px','color': 'red'});
   		$('#useraddressmsg').html('주소(시/구/동) 중 시를 선택해 주세요');
     }else if(guID == null){
   	  $('#useraddressmsg').css({'font-size': '10px','color': 'red'});
   		$('#useraddressmsg').html('주소(시/구/동) 중 구를 선택해 주세요');
     }else if(dongID == null){
      	  $('#useraddressmsg').css({'font-size': '10px','color': 'red'});
     		$('#useraddressmsg').html('주소(시/구/동) 중 동을 선택해 주세요');
       }else{
	
	$.ajax({
	       type: 'get'
	       ,url: 'updateuseraddress.ajax'
	       ,data:{'siID':siID, 'guID':guID, 'dongID':dongID}
	       ,dataType:'json'
	       ,success:function(data){
	          console.log(data);
	          
	         if(data.success ==1){
	        	  $('#useraddressmsg').css({'font-size': '10px','color': 'darkgreen'});
	        		$('#useraddressmsg').html('주소가 변경 되었습니다.');	        		
	          }else{
	        	  $('#useraddressmsg').css({'font-size': '10px','color': 'red'});
	        		$('#useraddressmsg').html('주소 변경에 실패했습니다.');
	          }   
	       }
	       ,error:function(e){
	          console.log(e);
	        $('#useraddressmsg').css({'font-size': '10px','color': 'red'});
		$('#useraddressmsg').html('주소 변경중 오류가 발생했습니다.\r\n다시 시도해주세요');
		}
	});
    }
});
$('#updateuserGender').on('click', function(e){
	console.log('성별 변경 요청');
	var userGender = $('input[name="userGender"]:checked').val();
	console.log(userGender);
	$.ajax({
	       type: 'get'
	       ,url: 'updateuserGender.ajax'
	       ,data:{'userGender':userGender}
	       ,dataType:'json'
	       ,success:function(data){
	          console.log(data);
	          
	         if(data.success ==1){
	        	  $('#usergendermsg').css({'font-size': '10px','color': 'darkgreen'});
	        		$('#usergendermsg').html('성별이 변경 되었습니다.');	        		
	          }else{
	        	  $('#usergendermsg').css({'font-size': '10px','color': 'red'});
	        		$('#usergendermsg').html('성별 변경에 실패했습니다.');
	          }   
	       }
	       ,error:function(e){
	          console.log(e);
	        $('#usergendermsg').css({'font-size': '10px','color': 'red'});
		$('#usergendermsg').html('성별 변경중 오류가 발생했습니다.\r\n다시 시도해주세요');
		}
	});	
});
</script>
</html>