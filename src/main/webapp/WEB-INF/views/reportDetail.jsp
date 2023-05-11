<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<style>
   .report_reply {
      border : 1px solid lightgray;
      border-radius: 5px;
      height: 30px;
      width : 800px;
      display: inline-flex;
   }
   
   input {
      margin : 0;
      
   }
   
    input[type="text"]{
       width : 500px;
       border : none;
    }
    
    input[type="button"]{
    	float: right;
        background-color: #87d1bf;
        color: white;
        border:none;
    
    }
    
    button{
        float: right;
        background-color: #87d1bf;
        color: white;
        border:none;
        
     }
     
     #reportreply_legnth {
       float: right;
        border:none;
        font-size: 14px;
        color : lightgray;
        
     }
     
     .inqrep {
     	border : 1px solid lightgray;
     	border-collapse: collapse;
     	padding : 10px 5px;
     }
     
     table, th, td{
     	border : 1px solid lightgray;
     	border-collapse: collapse;
     	padding : 10px 5px;
     }
</style>
</head>

	<!-- 글 번호 -->
	<input type="hidden" name="inquiry" value="${rep.reportNum}">
	
	<!-- 신고 글 디테일 가져오기  -->
	<table>
		<tr>
        	<th>${rep.reportName }</th>
        </tr>   
        <tr>
            <td>${rep.userID} </td>
        </tr>
        <tr>         
            <td>${rep.reportDate}</td>
        </tr>      
        <tr>
            <td>${rep.reportDetail}</td>
            <c:if test="${rep.serPhotoname ne null}">
			<tr>
				<td><img width="300" src="/photo/${rep.serPhotoname}"/></td>
			</tr>
			</c:if>
    	 </tr>            
   </table>
   
   <form id="reportprocess" action="reportprocess.go" method="POST">
	   <div>
		   <select name="selectedValue" id="${rep.reportNum}">
		      <option value="false">미처리</option>
		      <option value="true">처리완료</option>
		   </select>
		   <input type="hidden" name="reportNum" value="${rep.reportNum}">
		   <input type="submit" value="저장">
	   	</div>
   	</form>
   	
		<!-- 신고글 목록으로 돌아가기 -->
        <input type="button" onclick='location.href="./reportList.go"' value="목록">
      
   <hr>
   
   <p>답변</p>         
   
	<!-- 신고글 댓글 리스트 가져오기 -->
    <c:if test="${repreplist.size() eq 0}">
		<tr><th colspan="10">등록된 답변이 없습니다.</th></tr>	
	</c:if>
	
	<c:forEach items="${repreplist}" var="report">
		<div class="inqrep">
			${report.userID}
			<input type ="button" onclick='location.href="reprepdel.do?repReplyNum=${report.repReplyNum}&reportNum=${rep.reportNum}"' value="삭제"/>
			<input type ="button" onclick='location.href="reprepupdate.go?repReplyNum=${report.repReplyNum}&reportNum=${rep.reportNum}&reportProcess=${report.reportProcess }"' value="수정"/>
			<p>${report.reportProcess }</p>
		</div>	
	</c:forEach>
	
	<!-- 댓글 작성 -->
    <form method="post" action="reportreplywrite.do">
    <input type="hidden" name="reportNum" value="${rep.reportNum}">
    
	<div class="report_reply">
        <input name = "content" id="reportreply_text" type="text" maxlength="100" oninput="checkLength();" placeholder="내용을 입력 해 주세요.">
        <p id="reportreply_legnth">0/100</p>
        <button type="submit">등록</button>
	</div>  
    </form>
    
</body>
<script>

	/* 댓글 작성 글자 수 표시 */
	function checkLength() {
	    var maxLength = 100;
	    var length = document.getElementById("reportreply_text").value.length;
	    var lengthElement = document.getElementById("reportreply_legnth");
	    lengthElement.innerHTML = length + "/" + maxLength;
	  }
  	
</script>
</html>