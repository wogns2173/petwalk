<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
<meta charset="UTF-8">
<title>너나들이 반려견 프로필 생성</title>
<script src = "https://code.jquery.com/jquery-3.6.4.min.js"></script>
<style>
		
</style>
</head>
<body>
	<jsp:include page="loginBox.jsp"></jsp:include>
	<h3>반려견 생성</h3>
		<table>
			<tr>
				<th>사진</th>
				<td>				
					<input id="photo" type="file"/>					
				</td>
			</tr>
			<tr>
				<th>견종 사이즈</th>
				<td>
					<select id ="petSize">
						<option value="">사이즈를 선택해 주세요.</option>
						<option value="대형견">대형견</option>
						<option value="중형견">중형견</option>
						<option value="소형견">소형견</option>
					</select>					
				</td>				
			</tr>				
			<tr>
				<th>이름</th>
				<td>
					<input type="text" id="petName" />					
				</td>				
			</tr>
			<tr>
				<th>나이</th>
				<td>
					<input type="number" id="petAge" />										
				</td>
			</tr>
			<tr>					
				<th>성별</th>
				<td>
					<input type="radio" name="petGender" value="남"/>남아 &nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="petGender" value="여"/>여아
				</td>				
			</tr>
			<tr>					
				<th>중성화 여부</th>
				<td>
					<input type="radio" name="petNeutered" value="1"/>O &nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="petNeutered" value="0"/>X
				</td>				
			</tr>
			<tr>					
				<th>반려견 소개</th>
				<td>					
					<textarea id="petIntroduce"></textarea>
				</td>				
			</tr>		
			<tr>		
		         <th colspan="2">
		            <button onclick="petprofilecreate()">등록</button>		            
		            <button onclick="location.href='./'">취소</button>
		         </th>
	      	</tr>
		</table>
</body>
<script>
function petprofilecreate() {
	  var photo = $('#photo')[0].files[0]; // 파일 객체 가져오기
	  var petSize = $('#petSize');
	  var petName = $('#petName');
	  var petAge = $('#petAge');
	  var petGender = $('input[name="petGender"]:checked');
	  var petNeutered = $('input[name="petNeutered"]:checked');
	  var petIntroduce = $('#petIntroduce');
	  
	  var file = document.getElementById("photo");
	  var fileName = file.value;
	  var idx = fileName.lastIndexOf(".");	  
	  var ext = fileName.slice(idx + 1).toLowerCase();
	  
	if (photo === undefined) { // 파일이 첨부되지 않았으면
	    alert('반려견 사진을 첨부해 주세요!');
	  } else if (ext != 'jpg' && ext != 'png') {
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

	    $.ajax({
	      type: 'post',
	      url: 'petprofilecreate.ajax',
	      data: formData, // FormData 객체 전송
	      processData: false, // 데이터를 처리하지 않음
	      contentType: false, // 컨텐츠 타입을 설정하지 않음
	      success: function (data) {
	        console.log(data);
	        if (data.success == 1) {
	          alert('반려견 정보가 생성되었습니다.');
	          location.href = './';
	        }else {
	          alert('반려견 정보가 생성에 실패했습니다.\r\n 다시 시도해 주세요.');
	        }
	      },
	      error: function (e) {
	        console.log(e);
	        alert('반려견 정보가 생성 중 오류가 발생했습니다.\r\n 다시 시도해 주세요');
	      }
	    });
	  }
	}

</script>
</html>