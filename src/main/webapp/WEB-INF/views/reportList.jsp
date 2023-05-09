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

</style>
</head>
<body>

<h3> 신고 리스트 </h3>

	<!-- 신고 필터링  -->
	<select id="categoryCode">
		<option value="default">신고 필터링</option>
		<option value="B_12">프로필 신고</option>
		<option value="B_13">게시글 신고</option>
	</select>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	
	<!-- 처리 여부 필터링  -->
	<select id="process">
		<option value="default">처리 여부 필터링</option>
		<option value="false">미처리</option>
		<option value="true">처리완료</option>
	</select>
	
	<!-- 검색 조건 -->
	<select id="serchText">
		<option value="default">검색 조건</option>
		<option value="userName">이름</option>
		<option value="userID">아이디</option>
		<option value="userNickname">닉네임</option>
	</select>
	
	<input type="text" id="searchInput" placeholder="내용을 입력 해 주세요">
   <button id="searchButton">검색</button>
	
	<select id="pagePerNum">
		<option value="5">5</option>
		<option value="10">10</option>
		<option value="15">15</option>
		<option value="20">20</option>
	</select>
	
	<hr>
	
		<table>
		<thead>
		</thead>
		<tbody id = "replist">
		<!-- 리스트가 출력될 영역 -->
		</tbody>
		<tr>
			<td colspan="6" id="paging">	
					<!-- 플러그인 사용	(twbsPagination)	 -->
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
var selectedcategoryCode = 'default'
var selectedprocess = 'default'
var searchText = 'default';
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

$('#process').change(function(){
	console.log("process change");
	console.log(selectedprocess);
	selectedprocess = $(this).val();
   listCall(showPage);
   $('#pagination').twbsPagination('destroy');
});

$('#searchText').change(function(){
	console.log("searchText change");
	console.log(selectedprocess);
	searchText = $(this).val();
   listCall(showPage);
   $('#pagination').twbsPagination('destroy');
});
/* //검색어에 따른 출력 
$('#searchButton').click(function(){
	console.log("searchButton");
   //검색어 확인 
   searchText = $('#searchInput').val();
   listCall(showPage);
   $('#pagination').twbsPagination('destroy');
}); */

$('#pagePerNum').change(function(){
	console.log("Paging");
	listCall(showPage);
	// 페이지 처리 부분이 이미 만들어져 버려서 pagePerNum 이 변경되면 수정이 안된다.
	// 그래서 pagePerNum 이 변경되면 부수고 다시 만들어야 한다.
	$('#pagination').twbsPagination('destroy');
});

function listCall(page){
	   $.ajax({
	      type:'post',
	      url:'replist.ajax',
	      data:{
	    	  'page':page,
	    	  'categoryCode' :selectedcategoryCode,
	    	  'process' :selectedprocess,
	    	  'cnt':$('#pagePerNum').val(),
	    	  'search':searchText
	      },
	      dataType:'json',           
	      success:function(data){
	    	 console.log("success");
	         console.log(data);
	         listPrint(data.replist);
	         
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
	               listCall(page);
	               
	            }
	         	}
	         	})
	      },
	      error:function(e){
				console.log(e);
	      }
	});
}
	
function listPrint(replist){
	console.log("listPrint Call");
	var content ='';
	
	if(replist && Array.isArray(replist)){
		replist.forEach(function(item,reportNum){
		      
      content +='<tr>';
      content +='<td id="inquiry">'+item.categoryCode+'</td>';
      content +='<td id="boardName"><a href="inquirydetail.do?boardNum='+ item.reportNum+'">'+item.reportName+'</a></td>';
      content +='<td id="userID">'+item.userID +'</td>';
      content +='<td id="userName">'+item.userName +'</td>';
      content +='<td id="userNickName">'+item.userNickName +'</td>';
      content +='<td>'+item.reportDate +'</td>';
      content +='<td>'+item.process +'</td>';
      content +='</tr>';
     
      
  	 });
	}
   $('#list').empty();
   $('#list').append(content);
}

/* //검색어에 따른 출력 
$('#searchButton').click(function(){
   //검색어 확인 
   var searchText = $('#searchInput').val();
   console.log(searchText);
   
   $('tbody tr').each(function() {
      var subject = $(this).find('#subject').text();
      var writerId = $(this).find('#writerId').text();
      
      if (subject.includes(searchText) || writerId.includes(searchText)){
         $(this).show();
      } else {
           $(this).hide();
       }
   });
}); */
</script>
</html>