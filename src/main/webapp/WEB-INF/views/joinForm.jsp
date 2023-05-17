<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
<meta charset="UTF-8">
<title>너나들이 회원가입</title>
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
<h3 id="title" style="text-align: center;">회원가입</h3>
<br/>
		<table style="margin-left: auto; margin-right: auto;">
			<tr>
				<th id="title">아이디</th>
				<td id="title">
					<input type="text" id="userID" placeholder="아이디를 입력 해주세요."/><br/>					
					<span id="idmsg"></span>
				</td>
			</tr>
			<tr>
				<th id="title">비밀번호</th>
				<td id="title">
					<input type="password" id="userPW"/><br/>
					<span id="upwmsg"></span>	
				</td>
			</tr>
			<tr>
				<th id="title">비밀번호 확인</th>
				<td id="title">
					<input type="password" id ="confirm"/><br/>
					<span id="pwmsg"></span>
				</td>
			</tr>
			<tr>

			</tr>
			<tr>
				<th id="title">이름</th>				
				<td id="title">
					<input type="text" id="userName"/>					
				</td>
			</tr>							
			<tr>
				<th id="title">닉네임</th>
				<td id="title">
					<input type="text" id="userNickname"/><br/>					
					<span id="nicknamemsg"></span>
				</td>
			</tr>
			<tr>
				<th id="title">연락처</th>
				<td id="title">
					<input type="number" id="ftphn" maxlength="3" value="010" readonly="readonly"/>
					<input type="number" id="mdphn" placeholder="휴대폰 중간(4자리)" oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);" maxlength="4" />
					<input type="number" id="ltphn" placeholder="휴대폰 마지막(4자리)" oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);" maxlength="4" />
				</td>				
			</tr>		
			<tr>
				<th id="title">이메일</th>
				<td id="title">
					<input type="email" id="userEmail"/>
				</td>
			</tr>	
			<tr>			
				<th id="title">성별</th>
				<td id="title">
					<input type="radio" name="userGender" value="남"/>남자 
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="userGender" value="여"/>여자
				</td>				
			</tr>	
			<tr>
				<th id="title">나이</th>
				<td id="title"><input type="number" id="userAge"/></td>
			</tr>
			<tr>
				<th id="title">생년월일</th>	
				<td id="title">	
					<input type="number" id="year" placeholder="년(4자)" min="1900" max="2023" oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);" maxlength="4"/>
					<!-- <select id="year">
						<option value="2005">2005</option>
						<option value="2004">2004</option>
						<option value="2003">2003</option>
						<option value="2002">2002</option>
						<option value="2001">2001</option>
						<option value="2000">2000</option>
						<option value="1999">1999</option>
						<option value="1998">1998</option>
						<option value="1997">1997</option>
						<option value="1996">1996</option>
						<option value="1995">1995</option>
						<option value="1994">1994</option>
						<option value="1993">1993</option>
						<option value="1992">1992</option>
						<option value="1991">1991</option>
						<option value="1990">1990</option>
						<option value="1989">1989</option>
						<option value="1988">1988</option>
						<option value="1987">1987</option>
						<option value="1986">1986</option>
						<option value="1985">1985</option>
						<option value="1984">1984</option>
						<option value="1983">1983</option>
						<option value="1982">1982</option>
						<option value="1981">1981</option>
						<option value="1980">1980</option>						
					</select> -->
					<select id="month">
						<option value="01">1월</option>
						<option value="02">2월</option>
						<option value="03">3월</option>
						<option value="04">4월</option>
						<option value="05">5월</option>
						<option value="06">6월</option>
						<option value="07">7월</option>
						<option value="08">8월</option>
						<option value="09">9월</option>
						<option value="10">10월</option>
						<option value="11">11월</option>
						<option value="12">12월</option>											
					</select>
					<input type="number" id="day" placeholder="일(01)"min="1" max="31" oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);" maxlength="2" />
					<!-- <select id="day">
						<option value="01">01</option>
						<option value="02">02</option>
						<option value="03">03</option>
						<option value="04">04</option>
						<option value="05">05</option>
						<option value="06">06</option>
						<option value="07">07</option>
						<option value="08">08</option>
						<option value="09">09</option>
						<option value="10">10</option>
						<option value="11">11</option>
						<option value="12">12</option>
						<option value="13">13</option>
						<option value="14">14</option>
						<option value="15">15</option>
						<option value="16">16</option>
						<option value="17">17</option>
						<option value="18">18</option>
						<option value="19">19</option>
						<option value="20">20</option>
						<option value="21">21</option>
						<option value="22">22</option>
						<option value="23">23</option>
						<option value="24">24</option>
						<option value="25">25</option>
						<option value="26">26</option>
						<option value="27">27</option>
						<option value="28">28</option>
						<option value="29">29</option>			
						<option value="30">30</option>									
						<option value="31">31</option>
					</select> -->
				</td>					
			</tr>
			<tr>
				<th id="title">주소</th>
				<td id="title">
					<select id="siID">
						<option value="">시를 선택하세요</option>
						<option value="1">서울 특별시</option>
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
						  <option value="3">강남구</option>
						 <!-- <option value="송파구">송파구</option>
						  <option value="강동구">강동구</option>-->
					</select>
					<select id ="dongID">
					  	<option value="">동을 선택하세요</option>
					      <!--  <option value="개포동">개포동</option>-->
					      <option value="2">논현동</option>
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
				</td>
			</tr>	
			<tr>
         		<th colspan="2" id="title" style="text-align: center;">
            		<button onclick="join()">확인</button>
            		<button onclick="location.href='./'">취소</button>
         		</th>
      		</tr>
		</table>
		</div>
</body>
<script>
var pweq = false;

var overlayIdChk = false;
var overlayNicknameChk = false;

function join(){
	
	var $userID = $('#userID');
	var $userPW = $('#userPW');
	var $userName = $('#userName');
	var $userNickname = $('#userNickname');
	var $ftphn = $('#ftphn');
	var $mdphn = $('#mdphn');
	var $ltphn = $('#ltphn');		
	var $userEmail = $('#userEmail');
	var $userGender = $('input[name="userGender"]:checked');
	var $userAge = $('#userAge');
	var $year = $('#year');
	var $month = $('#month');
	var $day = $('#day');	
	var $siID = $('#siID').val();
	var $guID = $('#guID').val();
	var $dongID = $('#dongID').val();

	console.log($day.val().toString().length);
	
	
	if($userID.val()==''){
		alert('아이디를 입력해 주세요!');
		$userID.focus();
	}else if($('#userID').val().length <=4){
		alert('아이디를 5자리 이상 입력해 주세요!'); 		
	}else if($userPW.val()==''){
		alert('비밀번호를 입력해 주세요!');			
		$userPW.focus();			
	}else if($userPW.val().length <= 7){
		alert('비밀번호를 8자리 이상 입력해 주세요!');
		$userPW.focus();
	}else if($userName.val()==''){
		alert('이름을 입력해 주세요!');
		$userName.focus();
	}else if($userNickname.val()==''){
		alert('닉네임를 입력해 주세요!');
		$userNickname.focus();			
	}else if($('#userNickname').val().length <=1 || $('#userNickname').val().length >=11){			
  		alert('닉네임을 2글자 이상  10글자 이하로입력해주세요.');
  		$userNickname.focus();
	}else if($ftphn.val()==''){
		alert('연락처 첫 3자리를 입력해 주세요!');	
		$ftphn.focus();
	}else if($mdphn.val().length <=3){
		alert('연락처 중간 4자리를 입력해 주세요!');
		$mdphn.focus();
	}else if($ltphn.val().length <= 3){
		alert('연락처 마지막 4자리를 입력해 주세요!');
		$ltphn.focus();
	}else if($userEmail.val()==''){
		alert('이메일을 입력해 주세요!');
		$userEmail.focus();
	}else if($userGender.val()==null){
		alert('성별을 선택해 주세요!');			
	}else if($userAge.val()==''){
		alert('나이를 입력해 주세요!');
		$userAge.focus();
	}else if($year.val().length<=3 || $year.val() <= 1900  || $year.val() > 2023){
		alert('태어난 년도를 4자리를 정확히 입력해 주세요!');
		$year.focus();
	}else if($month.val()==null){
		alert('태어난 월을 선택해 주세요!');
		$month.focus();
	}else if($day.val().length<=1 || $day.val() <=0 || $day.val() >31){
		alert('태어난 일(날짜) 을 2자리 정확히 입력해 주세요!\r\n ex)01 or 02');
		$day.focus();
	}else if($siID==''){
		alert('시를 선택해 주세요!');
	}else if($guID==''){
		alert('구를 선택해 주세요!');
	}else if($dongID==''){
		alert('동을 선택해 주세요!');
	}else if(pweq && overlayIdChk && overlayNicknameChk){

			var param = {};
			param.userID = $userID.val();
			param.siID = $siID;
			param.guID = $guID;
			param.dongID = $dongID;
			param.userPW = $userPW.val();
			param.userNickname = $userNickname.val();
			param.userName = $userName.val();
			param.userAge = $userAge.val();
			param.userBirthdate = $year.val() + $month.val() + $day.val();
			param.userGender = $userGender.val();
			param.userContact = $ftphn.val() + $mdphn.val() + $ltphn.val();
			param.userEmail = $userEmail.val();
			
			console.log(param);
			
			$.ajax({
				type:'post'
				,url:'join.ajax'
				,data:param
				,dataType:'json'
				,success:function(data){
					console.log(data);
					if(data.success == 1){
						alert('회원가입이 완료 되었습니다.');
						location.href ='./';
					}else{
						alert('회원가입에 실패 했습니다.\r\n 다시 시도해 주세요');
					}
				},
				error:function(e){
					console.log(e);
					alert('회원가입에 실패 했습니다.\r\n 다시 시도해 주세요');
				}
			});
		}else if(!overlayIdChk){
			alert('중복된 아이디 입니다.');
			$userID.focus();
		}else if(!overlayNicknameChk){
			alert('중복된 닉네임 입니다.');
			$userNickname.focus();
		}	
}

$('#userID').on('keyup', function(e){

    var chkId = $('#userID').val();      
    overlayIdChk=false;
    console.log("중복체크 요청 : " + chkId);
    console.log($('#userID').val().length);
    
    $.ajax({
       type: 'get'
       ,url: 'overlayid.ajax'
       ,data:{'userID':chkId}
       ,dataType:'json'
       ,success:function(data){
          console.log(data);

          if($('#userID').val().length <=4){
        	  $('#idmsg').css({'font-size': '10px','color': 'red'});
        		$('#idmsg').html('아이디를 5자리 이상 입력해주세요.');
          }else if(data.overlayid==0){
             overlayIdChk=true;
             $('#idmsg').css({'font-size': '10px','color': 'darkgreen'});
      		$('#idmsg').html('사용 가능한 아이디 입니다.');
          } else {             
             overlayIdChk=false;
             $('#idmsg').css({'font-size': '10px','color': 'red'});
       		$('#idmsg').html('중복된 아이디 입니다.');
          }
       }
       ,error:function(e){
          console.log(e);
       }
    });      

 });


$('#userNickname').on('keyup', function(e){
    var chkNickname = $('#userNickname').val();      
    console.log("중복체크 요청 : " + chkNickname);
    console.log($('#userNickname').val().length);
    overlayNicknameChk=false;
    
    if($('#userNickname').val().length <=1 || $('#userNickname').val().length >=11){
    	$('#nicknamemsg').css({'font-size': '10px','color': 'red'});
  		$('#nicknamemsg').html('닉네임을 2글자 이상  10글자 이하로입력해주세요.');
	}else{
			
    $.ajax({
       type: 'get'
       ,url: 'overlaynickname.ajax'
       ,data:{'userNickname':chkNickname}
       ,dataType:'json'
       ,success:function(data){
		console.log(data);			
		
		if(data.overlaynickname==0){             
             overlayNicknameChk=true;
             $('#nicknamemsg').css({'font-size': '10px','color': 'darkgreen'});
     		$('#nicknamemsg').html('사용 가능한 닉네임 입니다.');
        }else {             
             overlayNicknameChk=false;
             $('#nicknamemsg').css({'font-size': '10px','color': 'red'});
      		$('#nicknamemsg').html('중복된 닉네임 입니다.');
          }
       }
       ,error:function(e){
          console.log(e);
       }
    });     
	}
 });
 
$('#userPW').on('keyup',function(e){

	if($('#userPW').val().length <=7){
		$('#upwmsg').css({'font-size': '10px','color': 'red'});
		$('#upwmsg').html('비밀번호를 8자리 이상 입력해주세요');
	}else{
		$('#upwmsg').css({'font-size': '10px','color': 'darkgreen'});
		$('#upwmsg').html('사용 가능한 비밀번호 입니다.');
	}
});

 
$('#confirm').on('keyup',function(e){
	pweq = false;
	if($('#userPW').val() == $(this).val()){
		$('#pwmsg').css({'font-size': '10px','color': 'darkgreen'});
		$('#pwmsg').html('비밀번호가 일치 합니다.');
		pweq = true;
	}else{		  
		$('#pwmsg').css({'font-size':'10px','color': 'red'});
		$('#pwmsg').html('비밀번호가 일치 하지 않습니다');
		pweq = false;
	}	
	
});
</script>
</html>