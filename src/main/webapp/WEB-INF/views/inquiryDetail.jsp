<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<style>
   .inquiry_reply {
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
     
     #inquiryreply_legnth {
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


  

<body onload="loadSavedOption()">
	<!-- 글 번호 -->
	<input type="hidden" name="inquiry" value="${inq.boardNum}">
	
	<!-- 문의 글 디테일 가져오기  -->
	<table>
		<tr>
        	<th>${inq.boardName } / ${inq.categoryCode }</th>
        </tr>   
        <tr>
            <td>${inq.userID} </td>
        </tr>
        <tr>         
            <td>${inq.boardWriteDate} 조회수 : ${inq.boardbHit }</td>
        </tr>      
        <tr>
            <td>${inq.boardDetail}</td>
            <c:if test="${inq.serPhotoname ne null}">
			<tr>
				<td><img width="300" src="/photo/${inq.serPhotoname}"/></td>
			</tr>
			</c:if>
    	 </tr>            
   </table>
   
   <form id="inquiryprocess" action="inquriyprocess.go" method="POST">
	   <div>
		   <select name="selectedValue" id="${inq.boardNum}">
		      <option value="false">미처리</option>
		      <option value="true">처리완료</option>
		   </select>
		   <input type="hidden" name="boardNum" value="${inq.boardNum}">
		   <input type="submit" value="저장">
	   	</div>
   	</form>
   	
		<!-- 문의글 목록으로 돌아가기 -->
        <input type="button" onclick='location.href="./inquirylist.go"' value="목록">
      
   <hr>
   
   <p>답변</p>         
   
	<!-- 문의글 댓글 리스트 가져오기 -->
    <c:if test="${inqreplist.size() eq 0}">
		<tr><th colspan="10">등록된 답변이 없습니다.</th></tr>	
	</c:if>
	
	<c:forEach items="${inqreplist}" var="inqrep">
		<div class="inqrep">
			${inqrep.userID} / ${inqrep.commentWriteDate}
			<input type ="button" onclick='location.href="inqrepdel.do?replyNum=${inqrep.replyNum}&boardNum=${inq.boardNum}"' value="삭제"/>
			<input type ="button" onclick='location.href="inqrepupdate.go?replyNum=${inqrep.replyNum}&boardNum=${inq.boardNum}&commentDetail=${inqrep.commentDetail }"' value="수정"/>
			<p>${inqrep.commentDetail }</p>
		</div>	
	</c:forEach>
	
	<!-- 댓글 작성 -->
    <form method="post" action="inquiryreplywrite.do">
    <input type="hidden" name="boardNum" value="${inq.boardNum}">
    
	<div class="inquiry_reply">
        <input name = "content" id="inquiryreply_text" type="text" maxlength="100" oninput="checkLength();" placeholder="내용을 입력 해 주세요.">
        <p id="inquiryreply_legnth">0/100</p>
        <button type="submit">등록</button>
	</div>  
    </form>
    
</body>
<script>

	/* 댓글 작성 글자 수 표시 */
	function checkLength() {
	    var maxLength = 100;
	    var length = document.getElementById("inquiryreply_text").value.length;
	    var lengthElement = document.getElementById("inquiryreply_legnth");
	    lengthElement.innerHTML = length + "/" + maxLength;
	  }
  	
</script>
</html>