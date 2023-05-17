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
	  
	 #pagePerNum{
	 	float: right;
	 	margin-right: 10px;
	 }
	 
	 #categoryCode{
	 	margin-left: 10px;
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
		
<h3 id="title">문의 리스트 </h3>
		
		
	<!-- 문의 필터링  -->
	<select id="categoryCode">
		<option value="default">문의 필터링</option>
		<option value="B_06">산책 경로 문의</option>
		<option value="B_07">게시글 문의</option>
		<option value="B_08">계정 문의</option>
		<option value="B_09">광고 문의</option>
		<option value="B_10">채팅 문의</option>
		<option value="B_11">기타 문의</option>
	</select>
	
	<!-- 처리 여부 필터링  -->
	<select id="inqProcess">
		<option value="default">처리 여부 필터링</option>
		<option value="false">미처리</option>
		<option value="true">처리완료</option>
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
				<th>문의 종류</th>
				<th>제목</th>
				<th>ID</th>
				<th>조회수</th>
				<th>작성날짜</th>
				<th>처리여부</th>
			</tr>
		
		</thead>
		<tbody id = "inqlist">
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
var selectedcategoryCode = 'default'
var selectedprocess = 'default'

listCall(showPage);
console.log("list call");

// 필터링 선택에 따른 출력
$('#categoryCode').change(function(){
	console.log("inquiry change");
	console.log(selectedcategoryCode);
	selectedcategoryCode = $(this).val();
   listCall(showPage);
   $('#pagination').twbsPagination('destroy');
});

$('#inqProcess').change(function(){
	console.log("process change");
	console.log(selectedprocess);
	selectedprocess = $(this).val();
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

function listCall(page, cnt){
	
	  	cnt = cnt || 5;
	   $.ajax({
	      type:'post',
	      url:'inqlist.ajax',
	      data:{
	    	  'page':page,
	    	  'categoryCode' :selectedcategoryCode,
	    	  'inqProcess' :selectedprocess,
	    	  'cnt': cnt
	      },
	      dataType:'json',           
	      success:function(data){
	    	 console.log("success");
	         console.log(data);
	         listPrint(data.inqlist);
	         
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
	
function listPrint(inqlist){
	console.log("listPrint Call");
	var content ='';
	
	if(inqlist && Array.isArray(inqlist)){
		inqlist.forEach(function(item,board){
			
		var categoryNames = {
				B_06 : "산책 경로 문의",
				B_07 : "게시글 문의",
				B_08 : "계정 문의",
				B_09 : "광고 문의",
				B_10 : "채팅 문의",
				B_11 : "기타 문의"
				
		};
		
		var processNames = {
				false : "미처리",
				true : "처리완료"
		};
		      
		var categoryName = categoryNames[item.categoryCode] || item.categoryCode;
		var processName = processNames[item.inqProcess] || item.inqProcess;
		
      content +='<tr>';
      content +='<td id="inquiry">'+categoryName+'</td>';
      content +='<td id="boardName"><a href="inquirydetail.do?boardNum='+ item.boardNum+'">'+item.boardName+'</a></td>';
      content +='<td id="userID">'+item.userID +'</td>';
      content +='<td>'+item.boardbHit +'</td>';
      var date = new Date(item.boardWriteDate);
		// 기본값은 en-US
	  content +='<td>'+date.toLocaleDateString('ko-KR')+'</td>';
     /*  content +='<td>'+item.boardWriteDate +'</td>'; */
      content +='<td>'+processName+'</td>';
      content +='</tr>';
      
      
  	 });
	}
   $('#inqlist').empty();
   $('#inqlist').append(content);
}

</script>
</html>