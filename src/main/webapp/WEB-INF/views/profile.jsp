<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
<meta charset="UTF-8">
<title>너나들이 프로필</title>
<script src = "https://code.jquery.com/jquery-3.6.4.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous"/>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<link rel="stylesheet" href="resources/css/common.css"/>
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
					<hr>					
				</div>															
		</div>
		<br/>
		<br/>
		<br/>
		<br/>

	<c:if test="${empty pet}">
	등록된 반려견 정보가 없습니다.
	<button onclick="location.href='petprofileWrite.go'">반려견 정보 추가하기</button>
	</c:if>
	
	<c:if test="${not empty pet}">
	<h3>반려견 프로필</h3>
		<table class="table">
			<tr>
				<th>사진</th>
				<td>
					<img width="100" src="/photo/${pet.serPhotoname}"/>					
				</td>				
			</tr>	
			<tr>
				<th>이름</th>
				<td>
					${pet.petName}					
				</td>				
			</tr>
			<tr>
				<th>나이</th>
				<td>
					${pet.petAge} 살										
				</td>
			</tr>
			<tr>					
				<th>성별</th>
				<td>
					<c:if test="${pet.petGender eq '남' }">남아</c:if>
					<c:if test="${pet.petGender eq '여' }">여아</c:if>
<!-- 				<input type="radio" name="petGender" value="남"<c:if test="${pet.petGender eq '남' }">checked</c:if>/>남아 &nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="petGender" value="여"<c:if test="${pet.petGender eq '여' }">checked</c:if>/>여아 -->
				</td>				
			</tr>
			<tr>					
				<th>중성화 여부</th>
				<td>
					<c:if test="${pet.petNeutered eq '1' }">O</c:if>
					<c:if test="${pet.petNeutered eq '0' }">X</c:if>
<!-- 				<input type="radio" name="petNeutered" value="1"<c:if test="${pet.petNeutered eq '1' }">checked</c:if>/>O &nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="petNeutered" value="0"<c:if test="${pet.petNeutered eq '0' }">checked</c:if>/>X -->
				</td>				
			</tr>		
			<tr>
				<th>견종 사이즈</th>
				<td>
					${pet.petSize}										
				</td>				
			</tr>							
			<tr>					
				<th>반려견 소개</th>
				<td>
					${pet.petIntroduce}
				</td>				
			</tr>		
			<tr>		
		         <th colspan="2">
		            <!-- <button onclick="location.href='petprofileWrite.go'"<c:if test="${pet.petNeutered eq '1' }">hidden</c:if>>반려견 정보 추가하기</button> -->
		            <button onclick="location.href='petprofileUpdate.go'">수정하기</button>		            		            
		         </th>
	      	</tr>	      	
		</table>
		</c:if>
		
		<hr>
		
		<h3>작성한 산책 경로</h3>
		<button onclick="location.href='walkroute/routedraw'">산책 경로 작성</button>		
		
		<table class="table">
		<thead id="myroutehead">
			<colgroup>					
				<col width="70%">
				<col width="30%">
			</colgroup>								
   			<tr>						
				<td>제목</td>
				<td>작성일자</td>
			</tr>
		</thead>		
		<tbody id="myroutebody">
			
		</tbody>						
			<tr>
				<td colspan="2" id="paging">	
				<!-- 	플러그인 사용	(twbsPagination)	-->
					<div class="container">									
						<nav aria-label="Page navigation" style="text-align:center">
							<ul class="pagination" id="pagination1"></ul>
						</nav>					
					</div>
				</td>
			</tr>			
		</table>		
		
		<hr>

		<h3>즐겨찾기한 산책 경로</h3>
		<button onclick="location.href='routeshare/list'">산책 경로 공유 게시판 가기</button>				
		
		<table  class="table">
		<thead id="mybookmarkhead">
			<colgroup>					
				<col width="50%">
				<col width="25%">
				<col width="25%">
			</colgroup>					
			<tr>						
				<td>제목</td>
				<td>작성자</td>
				<td>작성일자</td>
			</tr>
		</thead>										
		<tbody id="mybookmarkbody">
		
		</tbody>
			<tr>
				<td colspan="3">	
				<!-- 	플러그인 사용	(twbsPagination)	-->
					<div class="container">									
						<nav aria-label="Page navigation" style="text-align:center">
							<ul class="pagination" id="pagination2"></ul>
						</nav>					
					</div>
				</td>
			</tr>		
		</table>
		
		<hr>
		
		<h3>산책 후기</h3>
		<button onclick="location.href='matefind/list'">산책 메이트 찾기</button>				
		
		<table  class="table">
		<thead id="myreviewhead">
			<colgroup>					
				<col width="40%">
				<col width="40%">
				<col width="20%">
			</colgroup>					
			<tr>						
				<td>제목</td>
				<td>내용</td>
				<td>작성일자</td>
			</tr>
		</thead>										
		<tbody id="myreviewbody">
		
		</tbody>
			<tr>
				<td colspan="3">	
				<!-- 	플러그인 사용	(twbsPagination)	-->
					<div class="container">									
						<nav aria-label="Page navigation" style="text-align:center">
							<ul class="pagination" id="pagination3"></ul>
						</nav>					
					</div>
				</td>
			</tr>		
		</table>
		
		<hr>	
		
		<h3>문의 내역</h3>
			<button onclick="location.href='inquirywrite.go'">문의 하기</button>				
		
		<table  class="table">
		<thead id="myinquiryhead">
			<colgroup>					
				<col width="50%">				
				<col width="25%">
				<col width="25%">
			</colgroup>					
			<tr>						
				<td>제목</td>
				<td>문의일자</td>
				<td>처리여부</td>
			</tr>
		</thead>										
		<tbody id="myinquirybody">
		
		</tbody>
			<tr> 
				<td colspan="3">	
				<!-- 	플러그인 사용	(twbsPagination)	-->
					<div class="container">									
						<nav aria-label="Page navigation" style="text-align:center">
							<ul class="pagination" id="pagination4"></ul>
						</nav>					
					</div>
				</td>
			</tr>		
		</table>
		
		<hr>
		
		<h3>신고 내역</h3>
			<button onclick="location.href='reportwrite.go'">신고 하기</button>				
		
		<table  class="table">
		<thead id="myreporthead">
			<colgroup>					
				<col width="50%">				
				<col width="25%">
				<col width="25%">
			</colgroup>					
			<tr>						
				<td>제목</td>
				<td>문의일자</td>
				<td>처리여부</td>
			</tr>
		</thead>										
		<tbody id="myreportbody">
		
		</tbody>
			<tr> 
				<td colspan="3">	
				<!-- 	플러그인 사용	(twbsPagination)	-->
					<div class="container">									
						<nav aria-label="Page navigation" style="text-align:center">
							<ul class="pagination" id="pagination5"></ul>
						</nav>					
					</div>
				</td>
			</tr>		
		</table>
		
		<hr>			
		
		

	</div>
</body>
<script>
var myrouteshowPage = 1;
var mybookmarkshowPage = 1;
var myreviewshowPage = 1;
var myinquiryshowPage = 1;
var myreportshowPage = 1;

var cnt = 5;

myroutlistCall(myrouteshowPage);
mybookmarklistCall(mybookmarkshowPage);
myreviewlistCall(myreviewshowPage);
myinquirylistCall(myinquiryshowPage);
myreportlistCall(myreportshowPage);


function myroutlistCall(page){
	$.ajax({
		type:'post',
		url:'myroutlistCall.ajax',
		data:{
			'page':page,
			'cnt':cnt
		},
		dataType:'json',
		success:function(data){
			console.log(data);
			myroutlistPrint(data.myroutlistCall);
			
			// 총 페이지 수
			// 현재 페이지
			
			//paging plugin
			$('#pagination1').twbsPagination({
				startPage:data.currPage,		// 시작페이지
				totalPages:data.pages,	// 총 페이지 수
				visiblePages:5,	// 보여줄 페이지[1][2][3][4][5]
				onPageClick:function(event,page){// 페이지 클릭시 동작되는 함수(콜백)
					console.log(page, myrouteshowPage);
					if (page != myrouteshowPage) {
						myrouteshowPage = page;
						myroutlistCall(page);
						}					
				}
			});
		},
		error:function(e){
			console.log(e);
		}
	});
}

function myroutlistPrint(list){
	console.log(list);
	var content='';
	// java.sql.Date 는 js 에서 읽지 못해 밀리세컨드로 반환한다.
	// 해결방법 1. DTO 에서 Date 를 String 으로 반환
	// 해결방법 2. js 에서 변환
	if (list.length > 0){
	list.forEach(function(item, idx){
		content +='<tr>';		
		content +='<td>'+item.walkName+'</td>';
		content +='<td>'+item.walkDate+'</td>';		
		content +='</tr>';
	});
	}else{
		content = '<tr><td colspan="2">작성한 산책 경로가 없습니다.</td></tr>';
	}
	$('#myroutebody').empty();
	$('#myroutebody').append(content);
	
}


function mybookmarklistCall(page){
	$.ajax({
		type:'post',
		url:'mybookmarklistCall.ajax',
		data:{
			'page':page,
			'cnt':cnt
		},
		dataType:'json',
		success:function(data){
			console.log(data);
			mybookmarkPrint(data.mybookmarklistCall);
			
			// 총 페이지 수
			// 현재 페이지
			
			//paging plugin
			$('#pagination2').twbsPagination({
				startPage:data.mybookmarkcurrPage,		// 시작페이지
				totalPages:data.mybookmarkpages,	// 총 페이지 수
				visiblePages:5,	// 보여줄 페이지[1][2][3][4][5]
				onPageClick:function(event,page){// 페이지 클릭시 동작되는 함수(콜백)
					console.log(page, mybookmarkshowPage);
					if (page != mybookmarkshowPage) {
						mybookmarkshowPage = page;
						mybookmarklistCall(page);
						}					
				}
			});
		},
		error:function(e){
			console.log(e);
		}
	});
}

function mybookmarkPrint(list){
	console.log(list);
	var content='';
	// java.sql.Date 는 js 에서 읽지 못해 밀리세컨드로 반환한다.
	// 해결방법 1. DTO 에서 Date 를 String 으로 반환
	// 해결방법 2. js 에서 변환
	if (list.length > 0){
	list.forEach(function(item, idx){
		content +='<tr>';		
		content +='<td>'+item.walkName+'</td>';
		content +='<td>'+item.userID+'</td>';
		content +='<td>'+item.walkDate+'</td>';		
		content +='</tr>';
	});
	}else{
		content = '<tr><td colspan="2">즐겨찾기한 산책 경로가 없습니다.</td></tr>';
	}
	$('#mybookmarkbody').empty();
	$('#mybookmarkbody').append(content);
}

function myreviewlistCall(page){
	$.ajax({
		type:'post',
		url:'myreviewlistCall.ajax',
		data:{
			'page':page,
			'cnt':cnt
		},
		dataType:'json',
		success:function(data){
			console.log(data);
			myreviewlistPrint(data.myreviewlistCall);
			
			// 총 페이지 수
			// 현재 페이지
			
			//paging plugin
			$('#pagination3').twbsPagination({
				startPage:data.myreviewcurrPage,		// 시작페이지
				totalPages:data.myreviewpages,	// 총 페이지 수
				visiblePages:5,	// 보여줄 페이지[1][2][3][4][5]
				onPageClick:function(event,page){// 페이지 클릭시 동작되는 함수(콜백)
					console.log(page, myreviewshowPage);
					if (page != myreviewshowPage) {
						myreviewshowPage = page;
						myreviewlistCall(page);
						}					
				}
			});
		},
		error:function(e){
			console.log(e);
		}
	});
}

function myreviewlistPrint(list){
	console.log(list);
	var content='';
	// java.sql.Date 는 js 에서 읽지 못해 밀리세컨드로 반환한다.
	// 해결방법 1. DTO 에서 Date 를 String 으로 반환
	// 해결방법 2. js 에서 변환
	if (list.length > 0){
	list.forEach(function(item, idx){
		content +='<tr>';		
		content +='<td>'+item.reviewName+'</td>';
		content +='<td>'+item.reviewDetail+'</td>';
		content +='<td>'+item.reviewDate+'</td>';		
		content +='</tr>';
	});
	}else{
		content = '<tr><td colspan="2">작성된 산책 후기가 없습니다.</td></tr>';
	}
	$('#myreviewbody').empty();
	$('#myreviewbody').append(content);
}

function myinquirylistCall(page){
	$.ajax({
		type:'post',
		url:'myinquirylistCall.ajax',
		data:{
			'page':page,
			'cnt':cnt
		},
		dataType:'json',
		success:function(data){
			console.log(data);
			myinquirylistPrint(data.myinquirylistCall);
			
			// 총 페이지 수
			// 현재 페이지
			
			//paging plugin
			$('#pagination4').twbsPagination({
				startPage:data.myinquirycurrPage,		// 시작페이지
				totalPages:data.myinquirypages,	// 총 페이지 수
				visiblePages:5,	// 보여줄 페이지[1][2][3][4][5]
				onPageClick:function(event,page){// 페이지 클릭시 동작되는 함수(콜백)
					console.log(page, myrouteshowPage);
					if (page != myrouteshowPage) {
						myrouteshowPage = page;
						myroutlistCall(page);
						}					
				}
			});
		},
		error:function(e){
			console.log(e);
		}
	});
}

function myinquirylistPrint(list){
	console.log(list);
	var content='';
	// java.sql.Date 는 js 에서 읽지 못해 밀리세컨드로 반환한다.
	// 해결방법 1. DTO 에서 Date 를 String 으로 반환
	// 해결방법 2. js 에서 변환
	if (list.length > 0){
	list.forEach(function(item, idx){
		content +='<tr>';		
		content +='<td><a href="inquirydetail.do?boardNum='+ item.boardNum+'">'+item.boardName+'</a></td>';
		content +='<td>'+item.boardWriteDate+'</td>';
		if(item.inqProcess == 1){
		    content += '<td>처리완료</td>'
		}else{
		    content += '<td>미처리</td>'
		}
		content +='</tr>';
		

	});
	}else{
		content = '<tr><td colspan="2">문의 내역이 없습니다.</td></tr>';
	}
	$('#myinquirybody').empty();
	$('#myinquirybody').append(content);
}

function myreportlistCall(page){
	$.ajax({
		type:'post',
		url:'myreportlistCall.ajax',
		data:{
			'page':page,
			'cnt':cnt
		},
		dataType:'json',
		success:function(data){
			console.log(data);
			myreportlistPrint(data.myreportlistCall);
			
			// 총 페이지 수
			// 현재 페이지
			
			//paging plugin
			$('#pagination5').twbsPagination({
				startPage:data.myreportcurrPage,		// 시작페이지
				totalPages:data.myreportpages,	// 총 페이지 수
				visiblePages:5,	// 보여줄 페이지[1][2][3][4][5]
				onPageClick:function(event,page){// 페이지 클릭시 동작되는 함수(콜백)
					console.log(page, myreportshowPage);
					if (page != myreportshowPage) {
						myreportshowPage = page;
						myreportlistCall(page);
						}					
				}
			});
		},
		error:function(e){
			console.log(e);
		}
	});
}

function myreportlistPrint(list){
	console.log(list);
	var content='';
	// java.sql.Date 는 js 에서 읽지 못해 밀리세컨드로 반환한다.
	// 해결방법 1. DTO 에서 Date 를 String 으로 반환
	// 해결방법 2. js 에서 변환
	if (list.length > 0){
	list.forEach(function(item, idx){
		content +='<tr>';		
		content +='<td><a href="reportdetail.do?reportNum='+ item.reportNum+'">'+item.reportName+'</a></td>';
		content +='<td>'+item.reportDate+'</td>';
		if(item.repProcess == 1){
		    content += '<td>처리완료</td>'
		}else{
		    content += '<td>미처리</td>'
		}	
		content +='</tr>';
	});
	}else{
		content = '<tr><td colspan="2">신고 내역이 없습니다.</td></tr>';
	}
	$('#myreportbody').empty();
	$('#myreportbody').append(content);
}
</script>
</html>