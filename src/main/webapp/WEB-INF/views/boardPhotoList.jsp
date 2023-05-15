<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>    
	<script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
	<link rel="stylesheet" href="resources/css/common.css">
<style>
	.gallery-wrap {
		max-width: 1200px; 
		margin: 0 auto; 
	}
	
	.gallery-list {
		display: flex; 
		flex-wrap: wrap; 
		justify-content: space-between; 
		margin: 20px 0; 
	}
	
	.gallery-item {
		width: 23%; 
		margin-bottom: 20px; 
	}
	
	.thumbnail {
		max-width: 100%; 
		height: auto; 
		display: block; 
	}
	
	
	.title {
		font-size: 18px;
		font-weight: bold;
		margin-bottom: 10px;
	}
	
	.author, .comment, .date, .view-count {
		font-size: 14px;
		margin: 5px 0;
	}
	img{
		width: 300px;
		hight: 300px;
	}
	ul{
		list-style: none;
	}
	#paging{
			text-align: center;
	}
	#pagePerNum{
		display:none;
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
					<a href="routeshare/list">산책 경로 공유</a>
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
	<h1>반려견 갤러리</h1>
   <div id = "boardSearchForm">
	<select id="boardSearch">
     	<option value="default">검색조건</option>
     	<option value="boardName">제목</option>
     	<option value="userNickname">닉네임</option>
     	<option value="userID">ID</option>
    </select> 
	<input type="text" id="searchInput" placeholder="검색 조건을 입력해주세요.">
   	<button id="searchButton">검색</button>
	</div>
	<div class="gallery-wrap">
		<ul class="gallery-list" id="list">
			<!-- 리스트를 출력할 영역-->
		</ul>
	</div>
	<input type="button" onclick="location.href='boardWrite.go?categoryCode=B_01'" id="writeButton" value="글쓰기"/>
	<div id="paging">	
		<!-- 	플러그인 사용	(twbsPagination)	-->
		<div class="container">									
			<nav aria-label="Page navigation" style="text-align:center">
				<ul class="pagination" id="pagination"></ul>
			</nav>					
		</div>
	</div>
		
</body>
<script>

	var loginID = "${sessionScope.userID}";
	if(loginID == "") {
		$('#writeButton').attr('type','hidden');
	}
	var cnt = 8;
	var showPage = 1;
	var selectedBoardSearch = 'default';
	var categoryCode = 'B_01';
	var searchText = 'default';
	console.log(selectedBoardSearch);
	listCall(showPage);

	//검색어에 따른 출력
	$('#searchButton').click(function(){
		   //검색어 확인 
		   searchText = $('#searchInput').val();
		   if(selectedBoardSearch){
		   listCall(showPage);
		   $('#pagination').twbsPagination('destroy');
		   }
		});
	
	// 조건방식 선택에 따른 출력
	$('#boardSearch').change(function(){
	    selectedBoardSearch = $(this).val();
	});
	
	function listCall(page){
		$.ajax({
			type:'post',
			url:'boardList.ajax',
			data:{
				'page':page,
				'categoryCode':categoryCode,
				'boardSearch':selectedBoardSearch,
				'search':searchText,
				'cnt': cnt
			},
			dataType:'json',
			success:function(data){
				console.log(data);
				listPrint(data.list);			
				
				//paging plugin
				$('#pagination').twbsPagination({
		         startPage:data.currPage, // 시작 페이지
		         totalPages:data.pages,// 총 페이지 수 
		         visiblePages:4,// 보여줄 페이지
		         onPageClick:function(event,page){ // 페이지 클릭시 동작되는 (콜백)함수
		            console.log(page,showPage);
		            if(page != showPage){
		               showPage=page;
		               listCall(page);				
						}				
					}
				});	
				
			},
			error:function(e){
				console.log(e);
			}
		});
	}


	function listPrint(list){
		var content ='';
		list.forEach(function(item,boardNum){
			content += '<li class="gallery-item">';
			content += '<input type="hidden" name="boardNum" value="'+item.boardNum+'"/>';
			content += '<a href="boardDetail.do?boardNum='+item.boardNum+'">';
			content += '<img class="tehumbnail" src="/photo/'+item.serPhotoname+'"> </a>';
			content += '<p class ="boardName"><a href="boardDetail.do?boardNum='+item.boardNum+'">'
					+item.boardName+'['+item['replyCount']+']'+'</a></p>';
			content += '<p class ="userNickname">'+item.userNickname+'</p>';
			
			var date = new Date(item.boardWriteDate);
			content += '<p>'+date.toLocaleDateString('ko-KR')+' 조회 '+item.boardbHit+'</p>'; //String('ko-KR')
			content += '</li>';
		});
		console.log(content);
		$('#list').empty();
		$('#list').append(content);
	}
</script>
</html>