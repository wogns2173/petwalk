<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src = "https://code.jquery.com/jquery-3.6.4.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<style>
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
		position : absolute;
		top : 100px;
		right : 10px;
		width : 200px;
	}
	.table {
		margin-top : 100px;
	}
</style>
</head>
<body>
	<div class="selectDiv">
		<select class="form-select select siList" aria-label="Default select example" name="siID"></select>
		<select class="form-select select guList" aria-label="Default select example" name="guID"></select>
		<select class="form-select select dongList" aria-label="Default select example" name="dongID"></select>
		<button>검색</button>
	</div>
	<div>
		<select class="form-select select search" aria-label="Default select example">
			<option value="제목">제목</option>
			<option value="아이디">아이디</option>
		</select>
		<input type="text" class="form-control search" id="exampleFormControlInput1"/>
		<button class="search">검색</button>
	</div>
	
	<select class="form-select paging" aria-label="Default select example">
		<option value="제목">5개씩</option>
		<option value="아이디">10개씩</option>
		<option value="아이디">15개씩</option>
	</select>
	
	<table class="table">
 		<thead>
    		<tr>
		      <th scope="col">제목</th>
		      <th scope="col">작성자</th>
		      <th scope="col">등록일자</th>
		      <th scope="col">추천수</th>
		      <th scope="col">조회수</th>
			</tr>
		</thead>
		<tbody id="tbody">
   	
		</tbody>
	</table>
	<button onclick="location.href='./bring.go'">작성하기</button>
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
			$('.siList').append(content);
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
</script>
</html>