<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>너나들이 비밀번호 수정</title>
<script src = "https://code.jquery.com/jquery-3.6.4.min.js"></script>
<style></style>
</head>
<body>
<h3>비밀번호 수정</h3>
	<table>
		<tr>
			<th>현재 비밀번호</th>
			<td>
				<input type="password" id="nowuserPW"/>							
			</td>
		</tr>
		<tr>
			<th>새 비밀번호</th>
			<td>
				<input type="password" id="changeuserPW"/></br>
				<span id="pwchkmsg"></span>			
			</td>
		</tr>
		<tr>
			<th>새 비밀번호 확인</th>
			<td>
				<input type="password" id="confirm"/></br>
				<span id="pwmsg"></span>			
			</td>
		</tr>
		<tr>
       		<th colspan="2">
          		<button onclick="chguserpw()">확인</button>
          		<button onclick="location.href='./'">취소</button>
       		</th>
      	</tr>
	</table>
</body>
<script>
var overlayPwChk = false;
var nowpwchk = false;
var pweq = false;

function chguserpw(){
	
	if(overlayPwChk && nowpwchk && pweq){
		
		var $nowuserPW = $('#nowuserPW');
		var $changeuserPW = $('#changeuserPW').val();
		var $confirm = $('#confirm');
		
		if($nowuserPW.val()==''){
			alert('현재 비밀번호를 입력해주세요.')
		}else if($nowuserPW.val()==''){
			alert('새 비밀번호를 입력해주세요.')
		}else{
			
			$.ajax({
				type:'post'
				,url:'chguserpw.ajax'
				,data:{'changeuserPW':$changeuserPW}
				,dataType:'json'
				,success:function(data){
					console.log(data);
					console.log(data.success);
					if(data.success == 1){
						alert('비밀번호 수정이 완료 되었습니다.');
						location.href ='./';
					}else{
						alert('비밀번호 수정에 실패 했습니다.\r\n 다시 시도해 주세요');
					}
				},
				error:function(e){
					console.log(e);
					alert('오류가 발생 했습니다.\r\n 다시 시도해 주세요');
				}
			});			
		}		
	}else{
		alert('비밀번호 확인를 해 주세요');
	}
}

$('#nowuserPW').on('keyup', function(e){
	var nowuserPW = $('#nowuserPW').val();  
	nowpwchk=false;
	
    $.ajax({
        type: 'get'
        ,url: 'overlaynowpw.ajax'
        ,data:{'nowuserPW':nowuserPW}
        ,dataType:'json'
        ,success:function(data){
           console.log(data);
           
           if(data.overlaynowpw != null) {        	                
        	   nowpwchk=true;  
 		  }		    	         
		}
        ,error:function(e){
           console.log(e);
        }
     });  
});


$('#changeuserPW').on('keyup', function(e){
    var chkPW = $('#changeuserPW').val();      
    
    console.log("현재 사용중인 비밀번호? : " + chkPW);
    console.log($('#changeuserPW').val().length);
    
    $.ajax({
       type: 'get'
       ,url: 'overlaypw.ajax'
       ,data:{'changeuserPW':chkPW}
       ,dataType:'json'
       ,success:function(data){
          console.log(data);
          if($('#changeuserPW').val().length <=7){
        	  $('#pwchkmsg').css({'font-size': '10px','color': 'dark'});
        		$('#pwchkmsg').html('비밀번호를 8자리 이상 입력해주세요.');
          }else if(data.overlaypw != null) {        	                
              $('#pwchkmsg').css({'font-size': '10px','color': 'red'});
        	  $('#pwchkmsg').html('현재 사용중인 비밀번호 입니다.');         	  
		  }else {
			  overlayPwChk=true;
	          	$('#pwchkmsg').css({'font-size': '10px','color': 'darkgreen'});
	   			$('#pwchkmsg').html('사용 가능한 비밀번호 입니다.');      	
          }
       }
       ,error:function(e){
          console.log(e);
       }
    });      
 });

	$('#confirm').on('keyup',function(e){	
		if($('#changeuserPW').val() == $('#confirm').val()){
			$('#pwmsg').css({'font-size': '10px','color': 'darkgreen'});
			$('#pwmsg').html('비밀번호가 일치 합니다.');
			pweq = true;
		}else{
			$('#pwmsg').css({'font-size':'10px','color': 'red'});
			$('#pwmsg').html('비밀번호가 일치 하지 않습니다');
		}		
	});
	

</script>
</html>