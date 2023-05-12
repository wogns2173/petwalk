<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src = "https://code.jquery.com/jquery-3.6.4.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<style>
	table tbody tr th {
		text-align: center;
	}
</style>
</head>
<body>
	<h1>산책 경로 불러오기</h1>
	<h3>산책 경로 공유글에 올릴 경로를 불러와주세요</h3>
	<table class="table">
		<colgroup>
			<col width="20%">
			<col width="60%">
			<col width="20%">
		</colgroup>
		<tbody id="tbody">
			<tr>
				<th colspan="3">내 산책경로</th>
			</tr>
   			<tr>
				<td>a</td>
				<td>b</td>
				<td>c</td>
			</tr>
			
		</tbody>
	</table>
</body>
<script>
	$.ajax({
		type:'get',
		url:'./routelist.ajax',
		data:{},
		dataType:'json',
		success:function(data){
			console.log(data);
			var content = '<tr>';
			var i = 1;
			data.forEach(function(data) {
				content += '<td>'+i+'</td>'+'<td>'+data.walkName+'</td><td>';
				content +='<button onclick="location.href=\'./write.go?walkNum='+data.walkNum+'\'">선택</button>'+'</td></tr>';
				i++;
			});
			$('#tbody').append(content);
		},
		error:function(e){
			console.log(e);
		}		
	});
</script>
</html>