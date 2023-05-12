<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
<meta charset="UTF-8">
<title>너나들이 반려견 정보 수정</title>
<script src = "https://code.jquery.com/jquery-3.6.4.min.js"></script>
<style>
		
</style>
</head>
<body>
	<jsp:include page="loginBox.jsp"></jsp:include>
	<h3>반려견 정보 수정</h3>
		<table>
			<tr>
				<th>사진</th>
				<td>				
					<input type="file" name="photo" id = "fileInput" onchange="checkExtension()"/>
                     <p id="filename">
                     <img width="100" src="/photo/${pet.serPhotoname}"/>
                      	현재 등록된 이미지: ${pet.serPhotoname}                      	
                      	<button id="deleteButton" onclick="delphoto()">삭제</button>                      	
                     </p>
                      <input type="hidden" name="deletePhoto" value="false" id="deletePhotoInput">
                      <input type="hidden" id="serPhotoname" value="${pet.serPhotoname}">

				</td>
			</tr>
			<tr>
				<th>견종 사이즈</th>
				<td>
					<select id ="petSize">
						<option value="">사이즈를 선택해 주세요.</option>
						<option value="대형견"<c:if test="${pet.petSize eq '대형견' }">selected</c:if>>대형견</option>
						<option value="중형견"<c:if test="${pet.petSize eq '중형견' }">selected</c:if>>중형견</option>
						<option value="소형견"<c:if test="${pet.petSize eq '소형견' }">selected</c:if>>소형견</option>
					</select>					
				</td>				
			</tr>				
			<tr>
				<th>이름</th>
				<td>
					<input type="text" id="petName" value="${pet.petName}"/>					
				</td>				
			</tr>
			<tr>
				<th>나이</th>
				<td>
					<input type="number" id="petAge" value="${pet.petAge}"/>										
				</td>
			</tr>
			<tr>					
				<th>성별</th>
				<td>
					<input type="radio" name="petGender" value="남"<c:if test="${pet.petGender eq '남' }">checked</c:if>/>남아 &nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="petGender" value="여"<c:if test="${pet.petGender eq '여' }">checked</c:if>/>여아
				</td>				
			</tr>
			<tr>					
				<th>중성화 여부</th>
				<td>
					<input type="radio" name="petNeutered" value="1"<c:if test="${pet.petNeutered eq '1' }">checked</c:if>/>O &nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="petNeutered" value="0"<c:if test="${pet.petNeutered eq '0' }">checked</c:if>/>X
				</td>				
			</tr>
			<tr>					
				<th>반려견 소개</th>
				<td>					
					<textarea id="petIntroduce">${pet.petIntroduce}</textarea>
				</td>				
			</tr>		
			<tr>		
		         <th colspan="2">
		            <button onclick="petprofileupdate()">수정</button>		            
		            <button onclick="location.href='./'">돌아가기</button>
		         </th>
	      	</tr>
		</table>
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
	  
	if (deletePhoto.val() == true || photo == undefined) { // 파일이 첨부되지 않았거나 파일을 삭제했을 경우
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