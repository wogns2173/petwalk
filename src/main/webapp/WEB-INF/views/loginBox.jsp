<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<div id="loginBox"></div>
<script>
	var loginId = "${sessionScope.loginId}";
	if (loginId = null) {		
		var content = '<button onclick="location.href=\'join.go\'">회원가입</button>'
			content +=	'<button onclick="location.href=\'login.go\'">로그인</button>'
			content += '<button onclick="location.href=\'\'">경로 추천</button>'
			content += '<button onclick="location.href=\'\'">산책 경로 공유</button>'
			content += '<button onclick="location.href=\'\'">산책 메이트 찾기</button>'
			content += '<button onclick="location.href=\'\'">커뮤니티</button>'
		$("#loginBox").html(content); 
	}else{
		var content = '안녕하세요 ${sessionScope.loginId} 님!'
			content += '<button onclick="location.href=\'logout\'">로그아웃</button>';
			content += '<button onclick="location.href=\'\'">경로 추천</button>'
			content += '<button onclick="location.href=\'\'">산책 경로 공유</button>'
			content += '<button onclick="location.href=\'\'">산책 메이트 찾기</button>'
			content += '<button onclick="location.href=\'\'">커뮤니티</button>'
			content += '<button onclick="location.href=\'memberdelete.go\'">회원탈퇴</button>'
		$("#loginBox").html(content); 

	}
</script>