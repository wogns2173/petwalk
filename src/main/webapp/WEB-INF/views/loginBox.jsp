<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src = "https://code.jquery.com/jquery-3.6.4.min.js"></script>
<div id="loginBox"></div>
<script>
var chklogin = "${sessionScope.userNickname}";
	if (chklogin == "") {	 
		var content = '<h2>너나들이</h2>'		
		content +='<br>';
		content +='<button onclick="location.href=\'join.go\'">회원가입</button>';
		content +=	'<button onclick="location.href=\'login.go\'">로그인</button>';
		content += '<button onclick="location.href=\'\'">추천 경로</button>';
		content += '<button onclick="location.href=\'\'">산책 경로 공유</button>';
		content += '<button onclick="location.href=\'\'">산책 메이트 찾기</button>';
		content += '<button onclick="location.href=\'\'">커뮤니티</button>';
		content +=	'<hr>';
		$("#loginBox").html(content);	
	}else{		
		var content = '<h2>너나들이</h2>';		
		content +='<br>';
		content += '환영합니다 ${sessionScope.userNickname}님';
		content += '<button onclick="location.href=\'logout\'">로그아웃</button>';
		content += '<button onclick="location.href=\'\'">추천 경로</button>';
		content += '<button onclick="location.href=\'\'">산책 경로 공유</button>';
		content += '<button onclick="location.href=\'\'">산책 메이트 찾기</button>';
		content += '<button onclick="location.href=\'\'">커뮤니티</button>';
		content += '<button onclick="location.href=\'memberdetail.do\'">프로필</button>';
		content += '<button onclick="location.href=\'memberdelete.go\'">회원탈퇴</button>';
		content +=	'<hr>';
		$("#loginBox").html(content);
	}
</script>