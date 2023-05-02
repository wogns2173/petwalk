<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
<meta charset="UTF-8">
<title>너나들이 회원가입</title>
<script src = "https://code.jquery.com/jquery-3.6.4.min.js"></script>
<style>

		
</style>
</head>
<body>
<h3>회원가입</h3>
		<table>
			<tr>
				<th>아이디</th>
				<td>

					<input type="text" id="userID"/>					
					<button id="overlayid">중복체크</button></br>
					<span id="idmsg"></span>

				</td>
			</tr>
			<tr>
			<th>주소</th>
				<td>
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
						  <option value="1">강남구</option>
						 <!-- <option value="송파구">송파구</option>
						  <option value="강동구">강동구</option>-->
					</select>
					<select id ="dongID">
					  	<option value="">동을 선택하세요</option>
					      <!--  <option value="개포동">개포동</option>-->
					      <option value="1">논현동</option>
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
				<th>비밀번호</th>
				<td><input type="password" id="userPW"/></td>
			</tr>
			<tr>
				<th>비밀번호 확인</th>
				<td>

					<input type="password" id ="confirm"/></br>
					<span id="pwmsg"></span>

				</td>
			</tr>
			<tr>
				<th>닉네임</th>

				<td>
					<input type="text" id="userNickname"/>					
					<button id="overlaynickname">중복체크</button></br>
					<span id="nicknamemsg"></span>
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>
					<input type="text" id="userName"/>					
				</td>
				

			</tr>
			<tr>
				<th>나이</th>
				<td><input type="text" id="userAge"/></td>
			</tr>
			<tr>
				<th>생년월일</th>	
					<td>	
					<select id="year">
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
					</select>
					<select id="month">
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
					</select>
					<select id="day">
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
					</select>
					</td>
			<tr>			
				<th>성별</th>
				<td>
					<input type="radio" name="userGender" value="남"/>남자 
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="userGender" value="여"/>여자
				</td>				
			</tr>
			<tr>
				<th>연락처</th>
				<td><input type="text" id="userContact"/></td>
			</tr>		
			<tr>
				<th>E-MAIL</th>
				<td><input type="email" id="userEmail"/></td>
			</tr>			
			<tr>
         <th colspan="2">
            <button onclick="join()">가입</button>
            <button onclick="location.href='./'">돌아가기</button>
         </th>
      </tr>
		</table>
</body>
<script>
var pweq = false;

var overlayIdChk = false;
var overlayNicknameChk = false;

function join(){
	
	if(pweq && overlayIdChk && overlayNicknameChk){

		
		var $userID = $('#userID');
		var $siID = $('#siID');
		var $guID = $('#guID');
		var $dongID = $('#dongID');
		var $userPW = $('#userPW');
		var $userNickname = $('#userNickname');
		var $userName = $('#userName');
		var $userAge = $('#userAge');
		var $year = $('#year');
		var $month = $('#month');
		var $day = $('#day');
		var $userGender = $('input[name="userGender"]:checked');
		var $userContact = $('#userContact');
		var $userEmail = $('#userEmail');
		
		if($userID.val()==''){
			alert('아이디를 입력해 주세요!');
			$userID.focus();
		}else if($siID.val()==''){
			alert('시를 입력해 주세요!');
		}else if($guID.val()==''){
			alert('구를 입력해 주세요!');
		}else if($dongID.val()==''){
			alert('동을 입력해 주세요!');
		}else if($userPW.val()==''){
			alert('비밀번호를 입력해 주세요!');
			$userPW.focus();
		}else if($userNickname.val()==''){
			alert('닉네임를 입력해 주세요!');
			$userNickname.focus();			
		}else if($userName.val()==''){
			alert('이름을 입력해 주세요!');
			$userName.focus();
		}else if($userAge.val()==''){
			alert('나이를 입력해 주세요!');
			$userAge.focus();
		}else if($year.val()==null){
			alert('년도 선택해 주세요!');			
		}else if($month.val()==null){
			alert('월을 선택해 주세요!');			
		}else if($day.val()==null){
			alert('일을 선택해 주세요!');			
		}else if($userGender.val()==null){
			alert('성별을 입력해 주세요!');			
		}else if($userContact.val()==''){
			alert('연락처를 입력해 주세요!');
			$userContact.focus();
		}else if($userEmail.val()==''){
			alert('이메일을 입력해 주세요!');
			$userEmail.focus();
		}else{
			
			var $userBirthdate = $('#year')+$('#month')+$('#day');
			var param = {};
			param.userID = $userID.val();
			param.siID = $siID.val();
			param.guID = $guID.val();
			param.dongID = $dongID.val();
			param.userPW = $userPW.val();
			param.userNickname = $userNickname.val();
			param.userName = $userName.val();
			param.userAge = $userAge.val();
			param.userBirthdate = $year.val()+$month.val()+$day.val();
			param.userGender = $userGender.val();
			param.userContact = $userContact.val();
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
		}
				
	}else{

		alert('아이디, 닉네임 중복체크와 비밀번호 확인을 해 주세요');
	}	
}

$('#overlayid').on('click', function(e){

    var chkId = $('#userID').val();      
    console.log("중복체크 요청 : " + chkId);
    
    $.ajax({
       type: 'get'

       ,url: 'overlayid.ajax'

       ,data:{'userID':chkId}
       ,dataType:'json'
       ,success:function(data){
          console.log(data);

          if(data.overlayid==0){
             alert('사용 가능한 아이디 입니다.');
             overlayIdChk=true;
             $('#idmsg').css({'font-size': '10px','color': 'darkgreen'});
      		$('#idmsg').html('사용가능한 아이디 입니다.');

          } else {
             alert('이미 사용중인 아이디 입니다.');
             $('#userID').val('');
          }
       }
       ,error:function(e){
          console.log(e);
       }
    });      

 });

$('#overlaynickname').on('click', function(e){
    var chkNickname = $('#userNickname').val();      
    console.log("중복체크 요청 : " + chkNickname);
    
    $.ajax({
       type: 'get'
       ,url: 'overlaynickname.ajax'
       ,data:{'userNickname':chkNickname}
       ,dataType:'json'
       ,success:function(data){
          console.log(data);
          if(data.overlaynickname==0){
             alert('사용 가능한 닉네임 입니다.');
             overlayNicknameChk=true;
             $('#nicknamemsg').css({'font-size': '10px','color': 'darkgreen'});
     		$('#nicknamemsg').html('사용가능한 닉네임 입니다.');
          } else {
             alert('이미 사용중인 닉네임 입니다.');
             $('#userNickname').val('');
          }
       }
       ,error:function(e){
          console.log(e);
       }
    });      
 });



$('#confirm').on('keyup',function(e){	
	if($('#userPW').val() == $(this).val()){

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