<%@page import="com.pet.admin.dto.InquiryDTO"%>
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
	table, th, td{
		border : 1px solid lightgray;
		border-collapse: collapse;
		padding : 10px 5px;
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
	 }
	 
	 #thead{
	 	color:#87d1bf;
	 	background-color: #E3EDEB;
	 }
</style>
</head>
<body>

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
	
	if(memlist && Array.isArray(memlist)){
		memlist.forEach(function(item,memlist){
		
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
	}
   $('#memlist').empty();
   $('#memlist').append(content);
}

</script>
</html>