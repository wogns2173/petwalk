<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>산책 경로</title>
<link rel="icon" href="../resources/img/favicon.ico">
<script src = "https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous"/>
<script src="../resources/js/jquery.twbsPagination.js" type="text/javascript"></script>

<link rel="stylesheet" href="../resources/css/common.css">
<link rel= "stylesheet" href="../resources/css/paging.css" type="text/css">
<style>
.board-item {
    display: inline-block;
    vertical-align: top;
    text-align: center;
    margin-right: 10px;
    margin-bottom: 10px;
  }
  .board-item img {
    width: 117px;
    height: 117px;    
  }
  .right-align{
  	float: right;
}	
.image-wrapper,
.link-wrapper {
    display: flex;
    justify-content: center;
}
.image-wrapper {
	margin : 5px 34px;
}
	body {
		height : 1000px;
	}
	.select {
		width : 200px;
		/*float : left;*/
		display : inline;
	}
	#exampleFormControlInput1 {
		width : 500px;
	}
	.search {
		display : inline;
	}
	.paging {
	        position: absolute;
		    top: 347px;
		    margin-left: 596px;
		    width: 104px;
		    height: 36px;
			}
	.table {
		 margin-top: 23px;
		}
	
	 button{
		background-color: #87d1bf;
        color: white;
        border:none;
	}
	#thead{
		 	color:#87d1bf;
		 	background-color: #E3EDEB;
		 }
	.selectDiv{
		width: 100px;
		margin-left: 27px;
		display: inline;
	}
	#subejctOrId{
		width: 100px;
	}
	
	#userBtn,#adminBtn{
		margin-left: 451px;
    	margin-top: 35px;
	}
	#title {
		color: #87d1bf;
		margin-top: 10px; /* 갤러리 제목 위쪽 간격 조절 */
	}
	button{
    	background-color: #87d1bf;
    	border:none;
    	color: white;    	
    }
    #title {
		color: #87d1bf;
		margin-top: 10px; 
	}
	
</style>
</head>
<body>
<div class="main">
		<div class = "topMenu">
			<div class="logo">
				<a href="../">
					<img src="../resources/img/logo.png" alt="logo">				
					<img src="../resources/img/logoaname.png" alt="logoname">
				</a>	
			</div>			
				<div class="link">																		
					<c:if test="${empty sessionScope.userID}">
						<a href="../login.go">로그인</a>
						<a href="../join.go">회원가입</a>
					</c:if>
					
					<c:if test="${not empty sessionScope.userID}">
						<a href="../myinformation.go">${sessionScope.userNickname} 님</a>
						<c:if test="${sessionScope.Role eq 'admin'}">
							<a href="../adminPage.go">관리자 페이지</a>
						</c:if>
						<a href="../logout">로그아웃</a>
						<a href="../profile.go">프로필</a>
						<a href="../memberdelete.go">회원탈퇴</a>
					</c:if>
					<br>				
					<a href="../routeshare/list?walkRouteType=공유">산책 경로 공유</a>
					<a href="../matefind/list">산책 메이트</a>
					<a href="../board">커뮤니티</a>
					<a href="../noticelist.go">공지사항</a>
					<hr>					
				</div>															
		</div>		
		<br/>
		<br/>

		<br/>
		<br/>
		<br/>
		<br/>
		<br/>

		<c:if test="${walkRouteType eq 'share'}">
			<h3 id="title">&nbsp  &nbsp공유 경로 리스트</h3>
		</c:if>
			
		<c:if test="${walkRouteType eq 'recommend'}">
			<h3 id="title">&nbsp  &nbsp추천 경로 리스트</h3>
		</c:if>

	<div class="selectDiv">
		<select class="form-select select siList" aria-label="Default select example" name="siID"></select>
		<select class="form-select select guList" aria-label="Default select example" name="guID"></select>
		<select class="form-select select dongList" aria-label="Default select example" name="dongID"></select>
		<button onclick="addressFilter()">검색</button>
	</div>
	<br/>
	<br/>
	<div style="margin-left: 132px;">
		<select class="form-select select search" aria-label="Default select example" id="subejctOrId">
			<option value="제목">제목</option>
			<option value="아이디">아이디</option>
		</select>
		<input type="text" class="form-control search" id="exampleFormControlInput1" style="width: 300px;"/>
		<button class="search" onclick="subjectOrIdFilter()">검색</button>
	</div>
	
	<c:if test="${walkRouteType eq 'share'}">
		<button onclick="userClick()" id="userBtn">공유 글 작성하기</button>
	</c:if>
		
	<c:if test="${walkRouteType eq 'recommend'}">
		<button onclick="adminClick()" id="adminBtn">추천 글 작성하기</button>
	</c:if>
	<select class="form-select paging" aria-label="Default select example" id="pagePerNum">
		<option value="5">5개씩</option>
		<option value="10">10개씩</option>
		<option value="15">15개씩</option>
	</select>
		
	
	<table class="table">
 		<thead>
    		<tr id="thead">
    			<th scope="col">제목</th>
				<th scope="col">제목</th>
				<th scope="col">작성자</th>
				<th scope="col">등록일자</th>
				<th scope="col">추천수</th>
				<th scope="col">조회수</th>
			</tr>
		</thead>
		<tbody id="tbody">
		</tbody>
		<tr>
			<td colspan="5" id="paging">
				<div class="container">
					<nav aria-label="Page navigation example">
						<ul id="pagination" style="margin-left: 180px;">
						<!--  
							<li class="page-item">
								<a class="page-link" href="#" aria-label="Previous">
									<span aria-hidden="true">&laquo;</span>
								</a>
							</li>
							<li class="page-item"><a class="page-link" href="#">1</a></li>
							<li class="page-item"><a class="page-link" href="#">2</a></li>
							<li class="page-item"><a class="page-link" href="#">3</a></li>
							<li class="page-item">
								<a class="page-link" href="#" aria-label="Next">
									<span aria-hidden="true">&raquo;</span>
								</a>
							</li>
							-->
						</ul>
					</nav>
				</div>
			</td>
		</tr>

	</table>

	</div>
</body>
<script>
	$.ajax({
		type:'get',
		url:'../matefind/silist.ajax',
		data:{},
		dataType:'json',
		success:function(data){
			var content='';
			$('.siList').show();
		    $('.siList').empty();
			data.forEach((list, index) =>  {
				console.log(list);
				content += ('<option value="'+list.siID+'">'+list.siName+'</option>');
			});
			console.log(content);
			$('.siList').html(content);
			$('.dongList').show();
		    $('.dongList').empty();
		},
		error:function(e){
			console.log(e);
		}		
	});
	$.ajax({
		type:'get',
		url:'../matefind/gulist.ajax',
		data:{siID : 1},
		dataType:'json',
		success:function(data){
			console.log(data);
			var content='';
			data.forEach((list, index) =>  {
				content += ('<option value='+list.guID+'>'+list.guName+'</option>');
			});
			console.log(content);
			$('.guList').append(content);
			
		},
		error:function(e){
			console.log(e);
		}		
	});
	$.ajax({
		type:'get',
		url:'../matefind/donglist.ajax',
		data:{guID : 1},
		dataType:'json',
		success:function(data){
			console.log(data);
			var content='';
			data.forEach((list, index) =>  {
				content += ('<option value='+list.dongID+'>'+list.dongName+'</option>');
			});
			console.log(content);
			$('.dongList').append(content);
		},
		error:function(e){
			console.log(e);
		}		
	});
	$('.siList').change(function(){
	    $('.guList').show();
	    $('.guList').empty();
	    console.log($('option:selected', this).val());
	    $.ajax({
			type:'get',
			url:'../matefind/gulist.ajax',
			data:{siID : $('option:selected', this).val()},
			dataType:'json',
			success:function(data){
				console.log(data);
				var content='';
				data.forEach((list, index) =>  {
					content += ('<option value='+list.guID+'>'+list.guName+'</option>');
				});
				console.log(content);
				$('.guList').append(content);
				
			},
			error:function(e){
				console.log(e);
			}		
		});
	});
	
	$('.guList').change(function(){
    	$('.dongList').show();
	    $('.dongList').empty();
	    
	    console.log($('option:selected', this).val());
	    $.ajax({
			type:'get',
			url:'../matefind/donglist.ajax',
			data:{guID : $('option:selected', this).val()},
			dataType:'json',
			success:function(data){
				console.log(data);
				var content='';
				data.forEach((list, index) =>  {
					content += ('<option value='+list.dongID+'>'+list.dongName+'</option>');
				});
				console.log(content);
				$('.dongList').append(content);
				
			},
			error:function(e){
				console.log(e);
			}		
		});
    });
	
	var showPage = 1;
	listCall(showPage);
	var isAddress = false;
	var isID = false;

	$('#pagePerNum').change(function(){
		if(isAddress) {
			addressFilter(showPage);
		}
		else if(isID) {
			subjectOrIdFilter(showPage);
		}else  {
			listCall(showPage);	
		}
		
		// 페이지처리 부분이 이미 만들어져 버려서 pagePerNum 이 변경되면 수정이 안된다.
		// 그래서 pagePerNum 이 변경되면 부수고 다시 만들어야 한다.
		$('#pagination').twbsPagination('destroy');
	});


	function listCall(page){
		$.ajax({
			type:'post',
			url:'./listBring.ajax',
			data:{
				'page':page,
				'cnt':$('#pagePerNum').val(),
				'walkRouteType' : '${walkRouteType}'
			},
			dataType:'json',
			success:function(data){
				console.log(data);
				listPrint(data.list);			
				
				//paging plugin
				$('#pagination').twbsPagination({
					startPage:data.currPage,	// 시작페이지
					totalPages:data.pages,		// 총 페이지 수
					visiblePages:5, 			// 보여줄 페이지 [1][2][3][4][5]
					next : '<span style="color: #87d1bf;">></span>', 
		            last : '<span style="color: #87d1bf;">>></span>',
		            first : '<span style="color: #87d1bf;"><<</span>',
		           prev : '<span style="color: #87d1bf;"><</span>',

					onPageClick:function(event,page){// 페이지 클릭시 동작되는 함수(콜백)
						console.log(page, showPage);
						if(page != showPage){
							showPage = page;	
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
		console.log(list);
		var content = '<tr>';
		//java.sql.Date 는 js 에서 읽지 못해 밀리세컨드로 반환한다.
		// 해결방법 1. DTO 에서 Date 를 String 으로 반환
		// 해결방법 2. js 에서 변환
		list.forEach(function(item, idx){
			content += '<td>'+item.walkRouteNum+"</td>";
			content += '<td onclick="location.href=\'./detail.go?walkRouteNum='+item.walkRouteNum+'\'">'+item.walkRouteName+'</td>';
			content += '<td>'+item.userID+"</td>";
			var date = new Date(item.walkRouteWriteDate);
			content +='<td>'+date.toLocaleDateString('ko-KR')+'</td>';//en-US
			content += '<td>'+item.recommendation+"</td>";
			content += '<td>'+item.walkRoutebHit+"</td></tr>";
			
			//content +='<td>'+item.reg_date+'</td>';
		});
		$('#tbody').empty();
		$('#tbody').append(content);
	}
	
	function addressFilter() {
		isAddress = true;
		isID = false;
		var sigudong = {
			'siName' : $('select[name=siID] option:selected').val(),
			'guName' : $('select[name=guID] option:selected').val(),
			'dongName' : $('select[name=dongID] option:selected').val()
		}
		$.ajax({
			type:'post',
			url:'./addressFilter.ajax',
			data:{
				'page': showPage,
				'cnt':$('#pagePerNum').val(),
				'list' : sigudong,
				'walkRouteType' : '${walkRouteType}'
			},
			dataType:'json',
			success:function(data){
				listPrint(data.list);			
				//paging plugin
				$('#pagination').twbsPagination({
					startPage:data.currPage,	// 시작페이지
					totalPages:data.pages,		// 총 페이지 수
					visiblePages:5, 			// 보여줄 페이지 [1][2][3][4][5]
					next : '<span style="color: #87d1bf;">></span>', 
		            last : '<span style="color: #87d1bf;">>></span>',
		            first : '<span style="color: #87d1bf;"><<</span>',
		           prev : '<span style="color: #87d1bf;"><</span>',

					onPageClick:function(event,page){// 페이지 클릭시 동작되는 함수(콜백)
						console.log(page, showPage);
						if(page != showPage){
							showPage = page;	
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
	
	function subjectOrIdFilter() {
		isAddress = false;
		isID = true;
		var fewqtr = {
				'isID' : $('#subejctOrId option:selected').val(),
				'input' : $('#exampleFormControlInput1').val()
		}
		$.ajax({
			type:'post',
			url:'./subjectOrIdFilter.ajax',
			data:{
				'page': showPage,
				'cnt':$('#pagePerNum').val(),
				'list' : fewqtr,
				'walkRouteType' : '${walkRouteType}'
			},
			dataType:'json',
			success:function(data){
				listPrint(data.list);			
				//paging plugin
				$('#pagination').twbsPagination({
					startPage:data.currPage,	// 시작페이지
					totalPages:data.pages,		// 총 페이지 수
					visiblePages:5, 			// 보여줄 페이지 [1][2][3][4][5]
					next : '<span style="color: #87d1bf;">></span>', 
		            last : '<span style="color: #87d1bf;">>></span>',
		            first : '<span style="color: #87d1bf;"><<</span>',
		           prev : '<span style="color: #87d1bf;"><</span>',
					onPageClick:function(event,page){// 페이지 클릭시 동작되는 함수(콜백)
						console.log(page, showPage);
						if(page != showPage){
							showPage = page;	
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
	
	function userClick() {
		console.log('userClick() 호출');
		var user = '${sessionScope.Role}';
		if(user == 'user')  {
			location.href='./bring.go';
		}
			
		else {
			console.log('유저아님');
			alert('유저만 작성 가능합니당');
			location.href='./list?walkRouteType=share';
		}
	}
	
	function adminClick() {
		console.log('adminClick() 호출');
		var admin = '${sessionScope.Role}'; 
		if(admin == 'admin') {
			location.href='./bring.go';
		} 
		else  {
			console.log('관리자아님');
			alert('관리자만 작성 가능합니당');
			location.href='./list?walkRouteType=recommend';
		}
	}
</script>
</html>