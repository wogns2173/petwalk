<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
<meta charset="UTF-8">
<title>너나들이 반려견 프로필 수정</title>
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
	<h3 id="title">반려견 정보 수정</h3>
		<table class="table" style="margin-left: auto; margin-right: auto;">
			<tr style="text-align: center;">
				<th colspan="2" id="title">반려견 사진</th>			
			</tr>
			<tr style="text-align: center;">
				<td colspan="2" >									                     
						<p id="filename">					
	                     <img width="100" src="/photo/${pet.serPhotoname}"/><br/>
	                      	<br/>      	
	                      	<button id="deleteButton" onclick="delphoto()">삭제</button>                      	
	                     </p>                     
                     <input type="file" name="photo" id = "fileInput" onchange="checkExtension()"/>
                                          
                      <input type="hidden" name="deletePhoto" value="false" id="deletePhotoInput">
                      <input type="hidden" id="serPhotoname" value="${pet.serPhotoname}">
				</td>
			</tr>
			<tr style="text-align: center;">
				<th id="title">견종 사이즈</th>
				<td>
					<select id ="petSize">
						<option value="">사이즈를 선택해 주세요.</option>
						<option value="대형견"<c:if test="${pet.petSize eq '대형견' }">selected</c:if>>대형견</option>
						<option value="중형견"<c:if test="${pet.petSize eq '중형견' }">selected</c:if>>중형견</option>
						<option value="소형견"<c:if test="${pet.petSize eq '소형견' }">selected</c:if>>소형견</option>
					</select>					
				</td>				
			</tr>				
			<tr style="text-align: center;">
				<th id="title">이름</th>
				<td>
					<input type="text" id="petName" value="${pet.petName}"/>					
				</td>				
			</tr>
			<tr style="text-align: center;">
				<th id="title">나이</th>
				<td>
					<input type="number" id="petAge" value="${pet.petAge}"/>										
				</td>
			</tr>
			<tr style="text-align: center;">					
				<th id="title">성별</th>
				<td>
					<input type="radio" name="petGender" value="남"<c:if test="${pet.petGender eq '남' }">checked</c:if>/>남아 &nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="petGender" value="여"<c:if test="${pet.petGender eq '여' }">checked</c:if>/>여아
				</td>				
			</tr>
			<tr style="text-align: center;">					
				<th id="title">중성화 여부</th>
				<td>
					<input type="radio" name="petNeutered" value="1"<c:if test="${pet.petNeutered eq '1' }">checked</c:if>/>O &nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="petNeutered" value="0"<c:if test="${pet.petNeutered eq '0' }">checked</c:if>/>X
				</td>				
			</tr>
			<tr style="text-align: center;">					
				<th id="title">반려견 소개</th>
				<td>					
					<textarea id="petIntroduce">${pet.petIntroduce}</textarea>
				</td>				
			</tr>		
			<tr style="text-align: center;">		
		         <th colspan="2">
		            <button onclick="petprofileupdate()">수정</button>		            
		            <button onclick="location.href='./'">돌아가기</button>
		         </th>
	      	</tr>
		</table>
	</div>
</body>
<script>
function delphoto(){
	document.getElementById("filename").remove();    
    document.getElementById("deletePhotoInput").value = "true";
    
}

function checkExtension() {
    var file = document.getElementById("fileInput");

    if(document.getElementById("filename")) {
            alert("이미 등록된 이미지가 있습니다. 새로운 이미지를 등록하려면 삭제 버튼을 눌러주세요.");
            file.value = "";
            return false;
           }    
  }
  
function petprofileupdate() {
	  var photo = $('#fileInput')[0].files[0]; // 파일 객체 가져오기
	  var petSize = $('#petSize');
	  var petName = $('#petName');
	  var petAge = $('#petAge');
	  var petGender = $('input[name="petGender"]:checked');
	  var petNeutered = $('input[name="petNeutered"]:checked');
	  var petIntroduce = $('#petIntroduce');
	  var deletePhoto = $('#deletePhotoInput');
	  var serPhotoname = $('#serPhotoname');
		  
	  var file = document.getElementById("fileInput");
	  var fileName = file.value;
	  var idx = fileName.lastIndexOf(".");	  
	  var ext = fileName.slice(idx + 1).toLowerCase();
	  
	  console.log(deletePhoto.val());
	  console.log(photo);
	  console.log(ext);
	  
	if (deletePhoto.val() == true && photo == undefined) { // 파일이 첨부되지 않았거나 파일을 삭제했을 경우
	    alert('반려견 사진을 첨부해 주세요!');
	  } else if (deletePhoto.val() == true && ext != 'jpg' && ext != 'png') { // 첨부한 파일의 확장자가 jpg또는 png가 아니거나 파일을 삭제했을 경우
		alert('사진만 첨부해 주세요.');
	  } else if (petSize.val() == '') {
	    alert('반려견 사이즈를 선택해 주세요!');
	    petSize.focus();
	  } else if (petName.val() == '') {
	    alert('반려견 이름을 입력해 주세요!');
	    petName.focus();
	  } else if (petAge.val() == '') {
	    alert('반려견 나이를 입력해 주세요!');
	    petAge.focus();
	  } else if (petGender.val() == '') {
	    alert('반려견 성별을 선택해 주세요!');
	  } else if (petNeutered.val() == '') {
	    alert('반려견 중성화여부를 선택해 주세요!');
	  } else if (petIntroduce.val() == '') {
	    alert('반려견 소개를 입력해 주세요!');
	    petSize.focus();
	  } else {
		  
	    var formData = new FormData(); // FormData 객체 생성
	    formData.append('photo', photo); // 파일 추가
	    formData.append('petSize', petSize.val()); // 나머지 필드 추가
	    formData.append('petName', petName.val());
	    formData.append('petAge', petAge.val());
	    formData.append('petGender', petGender.val());
	    formData.append('petNeutered', petNeutered.val());
	    formData.append('petIntroduce', petIntroduce.val());
	    formData.append('deletePhoto', deletePhoto.val());
	    formData.append('serPhotoname', serPhotoname.val());

	    $.ajax({
	      type: 'post',
	      url: 'petprofileUpdate.ajax',
	      data: formData, // FormData 객체 전송
	      processData: false, // 데이터를 처리하지 않음
	      contentType: false, // 컨텐츠 타입을 설정하지 않음
	      success: function (data) {
	        console.log(data);
	        if (data.success == 1) {
	          alert('반려견 정보가 수정되었습니다.');
	          location.href = './';
	        }else {
	          alert('반려견 정보가 수정에 실패했습니다.\r\n 다시 시도해 주세요.');
	        }
	      },
	      error: function (e) {
	        console.log(e);
	        alert('반려견 정보가 수정 중 오류가 발생했습니다.\r\n 다시 시도해 주세요');
	      }
	    });
	  }
	}

</script>
</html>