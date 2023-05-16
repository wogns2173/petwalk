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
		#paging{
			text-align: center;
		}
		table, th, td{
			border : 1px solid lightgray;
			border-collapse: collapse;
			padding : 10px 5px;
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
	<h3 id ="title">미아견 게시판</h3>
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
	게시물 갯수 : 
	<select id="pagePerNum">
		<option value="5">5</option>
		<option value="10">10</option>
		<option value="15">15</option>
	</select>
	<table>
		<thead>
			<tr id="thead">
				<th>번호</th>					
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody id="list">			
		<!-- 리스트가 출력될 영역 -->
		</tbody>
		<tr>
			<td colspan="5" id="paging">	
				<!-- 	플러그인 사용	(twbsPagination)	-->
				<div class="container">									
					<nav aria-label="Page navigation" style="text-align:center">
						<ul class="pagination" id="pagination"></ul>
					</nav>					
				</div>
			</td>
		</tr>
		<input type="button" onclick="location.href='boardWrite.go?categoryCode=B_04'" id="writeButton" value="글쓰기"/>
	</table>
</body>
<script>
	var loginID = "${sessionScope.userID}";
	if(loginID == "") {
		$('#writeButton').attr('type','hidden');
	}
	var showPage = 1;
	var selectedBoardSearch = 'default';
	var categoryCode = 'B_04';
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
	
	function listCall(page){
		$.ajax({
			type:'post',
			url:'boardList.ajax',
			data:{
				'page':page,
				'categoryCode':categoryCode,
				'boardSearch':selectedBoardSearch,
				'search':searchText,
				'cnt':$('#pagePerNum').val()
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
		var content;
		if (list.length > 0){
			
			list.forEach(function(item,boardNum){
				content += '<tr>';
				content += '<td id="boardNum">'+item.boardNum+'</td>';
				content += '<td id ="boardName"><a href="boardDetail.do?boardNum='+item.boardNum+'">'
					+item.boardName+'['+item['replyCount']+']'+'</td>';
				content += '<td id ="userNickname">'+item.userNickname+'</td>';
				
				var date = new Date(item.boardWriteDate);
				content += '<td>'+date.toLocaleDateString('ko-KR')+'</td>'; //String('ko-KR')
				content += '<td>'+item.boardbHit+'</td>';
				content += '</tr>';
			});
			}else{
				content += '<tr>';
				content += '<td colspan="6" style="text-align: center;">등록된 글이 없습니다.<td>';
				content += '</tr>';
			}
			$('#list').empty();
			$('#list').append(content);
	}

</script>
</html>