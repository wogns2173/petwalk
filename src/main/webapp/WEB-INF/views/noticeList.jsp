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

<h3 id="title"> 공지사항 </h3>

	<input type="text" id="noticeInput" placeholder="제목을 입력 해 주세요">
    <button id="searchButton">검색</button>
   
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 
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
				<th>제목</th>
				<th>ID</th>
				<th>조회수</th>
				<th>작성날짜</th>
				<th>처리여부</th>
			</tr>
		</thead>
		<tbody id = "noticelist">
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
	
	<div>
		<input type="button" name="noticeWirte" value="글쓰기" onclick="location.href='noticewrite.go'">
	</div>
	
</body>
<script>

var showPage = 1;
var searchText = 'default';

listCall(showPage);
console.log("list call");

//검색어에 따른 출력 
$('#searchButton').click(function(){
   //검색어 확인 
   searchText = $('#noticeInput').val();
   console.log(searchText);
   listCall(showPage, $('#pagePerNum').val(), searchText);
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
	      url:'noticelist.ajax',
	      data:{
	    	  'page':page,
	    	  'searchText':searchText,
	    	  'cnt': cnt,
	      },
	      dataType:'json',           
	      success:function(data){
	    	 console.log("success");
	         console.log(data);
	         listPrint(data.noticelist);
	         
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
	
function listPrint(noticelist){
	console.log("noticelist Call");
	var content ='';
	
	if(noticelist && Array.isArray(noticelist)){
		noticelist.forEach(function(item,noticelist){
		
      content +='<tr>';
      content +='<td id="boardName"><a href="noticedetail.do?boardNum='+ item.boardNum+'">'+item.boardName+'</a></td>';
      content +='<td id="userID">'+item.userID +'</td>';
      content +='<td>'+item.boardbHit +'</td>';
      var date = new Date(item.boardWriteDate);
		// 기본값은 en-US
	  content +='<td>'+date.toLocaleDateString('ko-KR')+'</td>';
     /*  content +='<td>'+item.boardWriteDate +'</td>'; */
      content +='<td>';
      content += '<input type="checkbox" ';
	  if (item.boardBlindWhether) {
      content += 'checked';
	  }
      content += ' onclick="toggleBlind(this, '+ item.boardNum +')" />';
	  content +='</td>';
      content +='</tr>';
      
      
  	 });
	}
   $('#noticelist').empty();
   $('#noticelist').append(content);
}

function toggleBlind(checkbox, boardNum) {
    var blind = !checkbox.checked;
    // Ajax 요청 등을 통해 서버로 블라인드 처리 여부를 전달하고, 서버에서 처리합니다.
    // 예를 들어, 'noticelist.ajax' 요청에 블라인드 처리 여부를 전달하여 서버에서 업데이트할 수 있습니다.
    $.ajax({
        type: 'post',
        url: 'updateBlind.ajax',
        data: {
            'boardNum': boardNum,
            'blind': blind
        },
        success: function(response) {
            // 서버에서 처리 후의 콜백 동작 (예: 성공 메시지 표시)
            console.log(response);
        },
        error: function(e) {
            console.log(e);
        }
    });
}
</script>
</html>

</script>
</html>