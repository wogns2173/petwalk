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
</style>
</head>
<body>
	<input type="hidden" name="inquriy" value="${inq.boardNum}">
   <table>
      <tr>
         <th>${inq.boardName }</th>
      </tr>   
      <tr>
         <td>${inq.userID}</td>
      </tr>
      <tr>         
         <td>${inq.boardWriteDate}</td>
      </tr>      
      <tr>
         <td>${inq.boardbHit}</td>
      </tr>            
   </table>
   <select>
      <option selected>미처리</option>
      <option>처리완료</option>
   </select>
   
      <p><a href="./inquiry">목록</a></p>
      
   <hr>
   
   <p>답변</p>         
   
    <form method="post" action="/inquiryreply/inquirywrite">
       
        <div class="inquiry_reply">
            <input id="inquiryreply_text" type="text" maxlength="100" oninput="checkLength();" placeholder="내용을 입력 해 주세요.">
            <p id="inquiryreply_legnth">0/100</p>
            <button type="submit">등록</button>
        </div>  
    </form>
    
            
      
      
   

</body>
<script>

function checkLength() {
    var maxLength = 100;
    var length = document.getElementById("inquiryreply_text").value.length;
    var lengthElement = document.getElementById("inquiryreply_legnth");
    lengthElement.innerHTML = length + "/" + maxLength;
  }
  
</script>
</html>