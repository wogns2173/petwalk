<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src = "https://code.jquery.com/jquery-3.6.4.min.js"></script>
<div id="loginBox"></div>
<script>
var chklogin = "${sessionScope.userID}";
var Role = "${sessionScope.Role}";
console.log(Role);

	if (chklogin == "") {	 
		var content = '<h2 onclick="location.href=\'./\'">너나들이</h2>'		
		content +='<br>';
		content +='<button onclick="location.href=\'join.go\'">회원가입</button>';
		content +=	'<button onclick="location.href=\'login.go\'">로그인</button>';
		content += '<button onclick="location.href=\'\'">추천 경로</button>';
		content += '<button onclick="location.href=\'routeshare/list\'">산책 경로 공유</button>';
		content += '<button onclick="location.href=\'matefind/list\'">산책 메이트 찾기</button>';
		content += '<button id = "board" onclick="location.href=\'board\'">커뮤니티</button>';
/*		content += '<button id = "board" class="panel">미아견 게시판</button>';
		content += '<button id = "boa0rd" class="panel">지식 공유 게시판</button>';
		content += '<button id = "board" class="panel">반려견 질문 게시판</button>';		
		content += '<button id = "board" class="panel">반려견 갤러리 게시판</button>';*/
		content +=	'<hr>';
		$("#loginBox").html(content);	
	}else if(Role =="admin"){		
		var content = '<h2 onclick="location.href=\'./\'">너나들이</h2>';		
		content +='<br>';
		content += '환영합니다 ${sessionScope.userNickname}님';
		content += '<button onclick="location.href=\'logout\'">로그아웃</button>';
		content += '<button onclick="location.href=\'adminPage.go\'">관리자 페이지</button>';
		content += '<button onclick="location.href=\'\'">추천 경로</button>';
		content += '<button onclick="location.href=\'routeshare/list\'">산책 경로 공유</button>';
		content += '<button onclick="location.href=\'matefind/list\'">산책 메이트 찾기</button>';
		content += '<button id = "board" onclick="location.href=\'board\'">커뮤니티</button>';
/*		content += '<button id = "board" class="panel">미아견 게시판</button>';
		content += '<button id = "board" class="panel">지식 공유 게시판</button>';
		content += '<button id = "board" class="panel">반려견 질문 게시판</button>';		
		content += '<button id = "board" class="panel">반려견 갤러리 게시판</button>';		*/
		content += '<button onclick="location.href=\'myinformation.go\'">내 정보</button>';
		content += '<button onclick="location.href=\'profile.go\'">프로필</button>';
		content += '<button onclick="location.href=\'memberdelete.go\'">회원탈퇴</button>';
		content +=	'<hr>';
		$("#loginBox").html(content);
	}else{		
		var content = '<h2 onclick="location.href=\'./\'">너나들이</h2>';		
		content +='<br>';
		content += '환영합니다 ${sessionScope.userNickname}님';
		content += '<button onclick="location.href=\'logout\'">로그아웃</button>';
		content += '<button onclick="location.href=\'\'">추천 경로</button>';
		content += '<button onclick="location.href=\'routeshare/list\'">산책 경로 공유</button>';
		content += '<button onclick="location.href=\'matefind/list\'">산책 메이트 찾기</button>';
		content += '<button id = "board" onclick="location.href=\'board\'">커뮤니티</button>';
/*		content += '<button id = "board" class="panel" >미아견 게시판</button>';
		content += '<button id = "board" class="panel">지식 공유 게시판</button>';
		content += '<button id = "board" class="panel">반려견 질문 게시판</button>';		
		content += '<button id = "board" class="panel">반려견 갤러리 게시판</button>';		*/
		content += '<button onclick="location.href=\'myinformation.go\'">내 정보</button>';
		content += '<button onclick="location.href=\'profile.go\'">프로필</button>';
		content += '<button onclick="location.href=\'memberdelete.go\'">회원탈퇴</button>';
		content +=	'<hr>';
		$("#loginBox").html(content);
	}

</script>