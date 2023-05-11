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
<style>
.gallery-wrap {
  max-width: 1200px; /* 원하는 최대 너비로 설정 */
  margin: 0 auto; /* 가운데 정렬 */
}

.gallery-list {
  display: flex; /* 가로 방향으로 나열 */
  flex-wrap: wrap; /* 리스트를 자동으로 내려줌 */
  justify-content: space-between; /* 리스트 간격을 좀 띄움 */
  margin: 20px 0; /* 위아래 간격 */
}

.gallery-item {
  width: 23%; /* 리스트 너비 */
  margin-bottom: 20px; /* 아래 간격 */
}

.thumbnail {
  max-width: 100%; /* 최대 너비 */
  height: auto; /* 이미지 비율 유지 */
  display: block; /* 이미지를 가운데 정렬하기 위해 */
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
</style>
</head>
<body>
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
		<ul class="gallery-list">
			<!-- 리스트를 출력할 영역-->
	
		    <li class="gallery-item">
				<a href="#">
		        	<img src="/photo/1682988733053.png" class="thumbnail">
		      	</a>
		      	<p class="date">제목</p>
		      	<p class="view-count">작성자 / 댓글수 </p>
		      	<p class="view-count">작성일자 / 조회수</p>
			</li>
		</ul>
	</div>
		<button onclick="location.href='boardWrite.go?categoryCode=B_01'">글쓰기</button>
</body>
<script>
	
	var showPage = 1;
	var selectedBoardSearch = 'default';
	var categoryCode = 'B_01';
	var searchText = 'default';
	console.log(selectedBoardSearch);
	listCall(showPage);
	
	$('#pagePerNum').change(function(){
		listCall(showPage);
		// 페이지처리 부분이 이미 만들어져 버려서 pagePerNum 이 변경되면 수정이 안된다.
		// 그래서 pagePerNum 이 변경되면 부수고 다시 만들어야 한다.
		$('#pagination').twbsPagination('destroy');
	});

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
</script>
</html>