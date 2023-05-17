<%@page import="com.pet.admin.dto.InquiryDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>너나들이</title>
<link rel="icon" href="./resources/img/favicon.ico">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>    
<script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<link rel= "stylesheet" href="resources/css/paging.css" type="text/css">
<link rel="stylesheet" href="resources/css/common.css" type="text/css">
<style>
	table, th, td{
		border : 1px solid lightgray;
		border-collapse: collapse;
		padding : 10px 5px;
		text-align: center;
	}
	
	input[type="button"]{
        background-color: #87d1bf;
        color: white;
        border:none;
    }
	
	button{
        background-color: #87d1bf;
        color: white;
        border:none;
	}
	
	#title{
	 	color:#87d1bf;
	 	margin-left: 20px;
	 	margin-bottom: 70px;
	 }
	 
	 #thead{
	 	color:#87d1bf;
	 	background-color: #E3EDEB;
	 }
	 
	  .container{
	 	width : 710px;
	 }
	 
	 #memManage{
		margin-bottom: 10px;
		margin-left: 10px;
	 }
	 
	 #memProcess{
	 	float: right;
	 	margin-right: 10px;
	 }
	 
	 #pagePerNum{
	 	float: right;
	 	margin-right: 10px;
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
		
		<br>
		<br>
		<br>
		<br>


<h3 id="title"> 회원 리스트 </h3>

	<!-- 회원 필터링  -->
	<select id="memManage">
		<option value="default">회원 정보 검색</option>
		<option value="userID">아이디</option>
		<option value="userName">이름</option>
	</select>
	
	<input type="text" id="memManageInput" placeholder="내용을 입력 해 주세요">
    <button id="searchButton">검색</button>
   
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	
	<select id="memProcess">
		<option value="default">블라인드 처리 여부</option>
		<option value="false">false</option>
		<option value="true">true</option>
	</select>
	 
	<select id="pagePerNum">
		<option value="5">5</option>
		<option value="10">10</option>
		<option value="15">15</option>
		<option value="20">20</option>
	</select>
	
	<hr>
	
	<table>
		<thead>
		<tr id="thead">
			<th>이름</th>
			<th>아이디</th>
			<th>가입일자</th>
			<th>블라인드 처리 여부</th>
			<th>회원 상세보기</th>
		</tr>


		</thead>
		<tbody id = "memlist">			
		<!-- 리스트가 출력될 영역 -->
		</tbody>
		<tr>
			<td colspan="6" id="paging">	
				<!-- 	플러그인 사용	(twbsPagination)	-->
				<div class="container">									
					<nav aria-label="Page navigation" style="text-align:center">
						<ul class="pagination" id="pagination"></ul>
					</nav>					
				</div>
			</td>
		</tr>
	</table>
</div>
</body>
<script>

var showPage = 1;
var searchText = 'default';
var searchType = 'default';
var memProcess = 'default';

listCall(showPage);
console.log("list call");

//검색어에 따른 출력 
$('#searchButton').click(function(){
   //검색어 확인 
   searchText = $('#memManageInput').val();
   searchType = $('#memManage').val();
   console.log(searchText,searchType);
   listCall(showPage, $('#pagePerNum').val(), searchText, searchType);
   $('#pagination').twbsPagination('destroy');
});

$('#memProcess').change(function(){
	console.log("process change");
	console.log(memProcess);
	memProcess = $(this).val();
   listCall(showPage);
   $('#pagination').twbsPagination('destroy');
});


$('#pagePerNum').change(function(){
	console.log("Paging");
	listCall(showPage ,$(this).val()); // cnt 값 전달
	// 페이지 처리 부분이 이미 만들어져 버려서 pagePerNum 이 변경되면 수정이 안된다.
	// 그래서 pagePerNum 이 변경되면 부수고 다시 만들어야 한다.
	$('#pagination').twbsPagination('destroy');
});

function listCall(page,cnt){
	
	  	cnt = cnt || 5;
	   $.ajax({
	      type:'post',
	      url:'memlist.ajax',
	      data:{
	    	  'page':page,
	    	  'searchText':searchText,
	    	  'searchType':searchType,
	    	  'cnt': cnt,
	    	  'memProcess':memProcess
	      },
	      dataType:'json',           
	      success:function(data){
	    	 console.log("success");
	         console.log(data);
	         listPrint(data.memlist);
	         
	         // 페이징 처리를 위해 필요한 데이터
	         // 1. 총 페이지의 수
	         // 2. 현재 페이지
	         
	         // Paging Plugin (j-query의 기본기능을 가지고 만들었기 때문에  plugin)
	         $('#pagination').twbsPagination({
	         startPage:data.currPage, // 시작 페이지
	         totalPages:data.pages,// 총 페이지 수 
	         visiblePages:5,// 보여줄 페이지
	         next : '<span style="color: #87d1bf;">></span>', 
	         last : '<span style="color: #87d1bf;">>></span>',
	         first : '<span style="color: #87d1bf;"><<</span>',
	 		 prev : '<span style="color: #87d1bf;"><</span>',
	         onPageClick:function(event,page){ // 페이지 클릭시 동작되는 (콜백)함수
	            console.log(page,showPage);
	            if(page != showPage){
	               showPage=page;
	               listCall(page,cnt);
	               
	            }
	         	}
	         	})
	      },
	      error:function(e){
				console.log(e);
	      }
	});
}
	
function listPrint(memlist){
	console.log("listPrint Call");
	var content ='';
	
	if (memlist && Array.isArray(memlist) && memlist.length > 0) {
        memlist.forEach(function (item, memlist) {
		
      content +='<tr>';
      content +='<td id="userName">'+item.userName+'</td>';
      content +='<td id="userID">'+item.userID +'</td>';
      var date = new Date(item.userSignup);
		// 기본값은 en-US
	  content +='<td>'+date.toLocaleDateString('ko-KR')+'</td>';
     /*  content +='<td>'+item.boardWriteDate +'</td>'; */
      content +='<td>'+item.userBlindWhether+'</td>';
      // content +='<td><input type="button" onclick="location.href=\'./memMangeDetail.go\'" value="상세보기"></td>';
      content += '<td><input type="button" data-userid="' + item.userID + '" onclick="location.href=\'./memMangeDetail.go?userID=\' + this.dataset.userid" value="상세보기"></td>';
      content +='</tr>';
      
      
  	 });
    }else{
    	
    content += '<tr>';
    content += '<td colspan="6" style="text-align: center;">검색한 정보가 없습니다.</td>';
    content += '</tr>';
	}
	
   $('#memlist').empty();
   $('#memlist').append(content);
}

</script>
</html>