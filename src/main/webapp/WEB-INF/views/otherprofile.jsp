<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
<meta charset="UTF-8">
<title>너나들이 프로필</title>
<link rel="icon" href="./resources/img/favicon.ico">
<script src = "https://code.jquery.com/jquery-3.6.4.min.js"></script>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="resources/css/common.css">
<script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>  
<link rel= "stylesheet" href="resources/css/paging.css" type="text/css">
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
  	button{
    	background-color: #87d1bf;
    	border:none;
    	color: white;    	
    }
    #title {
		color: #87d1bf;
		margin-top: 10px; /* 갤러리 제목 위쪽 간격 조절 */
	}	
	.inner {
    	position : relative;
    }
    
.container {
  display: flex;
  justify-content: center;
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
						<a href="logout">로그아웃</a>
						<a href="profile.go">프로필</a>
						<a href="memberdelete.go">회원탈퇴</a>
					</c:if>
					<br>				
					<a href="routeshare/list?walkRouteType=공유">산책 경로 공유</a>
					<a href="matefind/list">산책 메이트</a>
					<a href="board">커뮤니티</a>
					<hr>					
				</div>															
		</div>
		<br/>
		<br/>
		<br/>
		<br/>
	<div class="inner">
		<h3 id="title" style="text-align: center;">반려견 프로필</h3>
		<div style="text-align: right;">		
		</div>
		<c:if test="${empty pet}">
		등록된 반려견 정보가 없습니다.
		
		</c:if>
		
		<c:if test="${not empty pet}">
		
			<table class="table" style="margin-left: auto; margin-right: auto;">
				<tr style="text-align: center;">
					<th colspan="2" id="title" >반려견 사진</th>			
				</tr>
				<tr>
					<td style="text-align: center;" colspan="2">
						<img width="100" src="/photo/${pet.serPhotoname}" style="border-radius: 50%;"/>					
					</td>				
				</tr>	
				<tr style="text-align: center;">
					<th id="title">이름</th>
					<td>
						${pet.petName}					
					</td>				
				</tr>
				<tr style="text-align: center;">
					<th id="title">나이</th>
					<td>
						${pet.petAge} 살										
					</td>
				</tr>
				<tr style="text-align: center;">					
					<th id="title">성별</th>
					<td>
						<c:if test="${pet.petGender eq '남' }">남아</c:if>
						<c:if test="${pet.petGender eq '여' }">여아</c:if>
	<!-- 				<input type="radio" name="petGender" value="남"<c:if test="${pet.petGender eq '남' }">checked</c:if>/>남아 &nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="petGender" value="여"<c:if test="${pet.petGender eq '여' }">checked</c:if>/>여아 -->
					</td>				
				</tr>
				<tr style="text-align: center;">					
					<th id="title">중성화 여부</th>
					<td>
						<c:if test="${pet.petNeutered eq '1' }">O</c:if>
						<c:if test="${pet.petNeutered eq '0' }">X</c:if>
	<!-- 				<input type="radio" name="petNeutered" value="1"<c:if test="${pet.petNeutered eq '1' }">checked</c:if>/>O &nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="petNeutered" value="0"<c:if test="${pet.petNeutered eq '0' }">checked</c:if>/>X -->
					</td>				
				</tr>		
				<tr style="text-align: center;">
					<th id="title">견종 사이즈</th>
					<td>
						${pet.petSize}										
					</td>				
				</tr>							
				<tr style="text-align: center;">					
					<th id="title">반려견 소개</th>
					<td>
						${pet.petIntroduce}
					</td>				
				</tr>						
			</table>
			</c:if>
		<input type="hidden" value="${userID}" id="userID"> 
		<hr>
		
		<h3 id="title" style="text-align: center;">공유한 산책 경로</h3>			
			
			<table  class="table">
			<thead id="otroutesharehead">
				<colgroup>					
					<col width="70%">
					<col width="30%">
				</colgroup>					
				<tr>						
					<td id="title">제목</td>
					<td id="title">작성일자</td>
				</tr>
			</thead>										
			<tbody id="otroutesharebody">
			
			</tbody>
				<tr>
					<td colspan="2" id="paging">	
					<!-- 	플러그인 사용	(twbsPagination)	-->
						<div class="container" style="text-align: center;">									
							<nav aria-label="Page navigation" style="text-align:center">
								<ul class="pagination" id="pagination10"></ul>
							</nav>					
						</div>
					</td>
				</tr>		
			</table>
		
		<hr>

		<h3 id="title" style="text-align: center;">산책 후기</h3>
			<div style="text-align: right;">				
			</div>
			
			<table  class="table">
			<thead id="otreviewhead">
				<colgroup>					
					<col width="40%">
					<col width="40%">
					<col width="20%">
				</colgroup>					
				<tr>						
					<td id="title">제목</td>
					<td id="title">내용</td>
					<td id="title">작성일자</td>
				</tr>
			</thead>										
			<tbody id="otreviewbody">
			
			</tbody>
				<tr>
					<td colspan="3" id="paging">	
					<!-- 	플러그인 사용	(twbsPagination)	-->
						<div class="container" style="text-align: center;">									
							<nav aria-label="Page navigation" style="text-align:center">
								<ul class="pagination" id="pagination11"></ul>
							</nav>					
						</div>
					</td>
				</tr>		
			</table>
		
		<hr>
	</div>	
	
</body>
<script>
var otrouteshareshowPage = 1;
var otreviewshowPage = 1;

var cnt = 5;

otroutesharelistCall(otrouteshareshowPage);
otreviewlistCall(otreviewshowPage);

var userID = document.getElementById("userID").value;
console.log(userID);

function otroutesharelistCall(page){
	$.ajax({
		type:'post',
		url:'otroutesharelistCall.ajax',
		data:{
			'page':page,
			'cnt':cnt,
			'userID': document.getElementById("userID").value
		},
		dataType:'json',
		success:function(data){
			console.log(data);
			otroutesharelistPrint(data.otroutesharelistCall);
			
			// 총 페이지 수
			// 현재 페이지
			
			//paging plugin
			$('#pagination10').twbsPagination({
				startPage:data.otroutesharecurrPage,		// 시작페이지
				totalPages:data.otroutesharepages,	// 총 페이지 수
				visiblePages:5,	// 보여줄 페이지[1][2][3][4][5]
				next : '<span style="color: #87d1bf;">></span>', 
	            last : '<span style="color: #87d1bf;">>></span>',
	            first : '<span style="color: #87d1bf;"><<</span>',
	           prev : '<span style="color: #87d1bf;"><</span>',
				onPageClick:function(event,page){// 페이지 클릭시 동작되는 함수(콜백)
					console.log(page, otrouteshareshowPage);
					if (page != otrouteshareshowPage) {
						otrouteshareshowPage = page;
						otroutesharelistCall(page);
						}					
				}
			});
		},
		error:function(e){
			console.log(e);
		}
	});
}

function otroutesharelistPrint(list){
	console.log(list);
	var content='';
	// java.sql.Date 는 js 에서 읽지 못해 밀리세컨드로 반환한다.
	// 해결방법 1. DTO 에서 Date 를 String 으로 반환
	// 해결방법 2. js 에서 변환
	if (list.length > 0){
		list.forEach(function(item, idx){
		
		content +='<tr>';				
		content +='<td><a href="routeshare/detail.go?walkRouteNum='+ item.walkRouteNum+'">'+item.walkRouteName+'</a></td>';
		content +='<td>'+item.walkRouteWriteDate+'</td>';		
		content +='</tr>';
		});
	}else{
		content = '<tr><td colspan="2">공유한 산책 경로가 없습니다.</td></tr>';
	}
	$('#otroutesharebody').empty();
	$('#otroutesharebody').append(content);
}

function otreviewlistCall(page){
	$.ajax({
		type:'post',
		url:'otreviewlistCall.ajax',
		data:{
			'page':page,
			'cnt':cnt,
			'userID': document.getElementById("userID").value
		},
		dataType:'json',
		success:function(data){
			console.log(data);
			otreviewlistPrint(data.otreviewlistCall);
			
			// 총 페이지 수
			// 현재 페이지
			
			//paging plugin
			$('#pagination11').twbsPagination({
				startPage:data.otreviewcurrPage,		// 시작페이지
				totalPages:data.otreviewpages,	// 총 페이지 수
				visiblePages:5,	// 보여줄 페이지[1][2][3][4][5]
				next : '<span style="color: #87d1bf;">></span>', 
	            last : '<span style="color: #87d1bf;">>></span>',
	            first : '<span style="color: #87d1bf;"><<</span>',
	           prev : '<span style="color: #87d1bf;"><</span>',
				onPageClick:function(event,page){// 페이지 클릭시 동작되는 함수(콜백)
					console.log(page, otreviewshowPage);
					if (page != otreviewshowPage) {
						otreviewshowPage = page;
						otreviewlistCall(page);
						}					
				}
			});
		},
		error:function(e){
			console.log(e);
		}
	});
}

function otreviewlistPrint(list){
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
		content = '<tr><td colspan="3">작성된 산책 후기가 없습니다.</td></tr>';
	}
	$('#otreviewbody').empty();
	$('#otreviewbody').append(content);
}




</script>
</html>