package com.pet.member.service;

import java.security.SecureRandom;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.apache.commons.mail.HtmlEmail;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.pet.member.dao.MemberDAO;
import com.pet.member.dto.MemberDTO;

@Service
public class MemberService {
	
	@Autowired MemberDAO dao;
	
	Logger logger = LoggerFactory.getLogger(getClass());

	public HashMap<String, Object> overlayid(String userID) {
		
		HashMap<String, Object> map = new HashMap<>();
		// 같은 아이디가 있는가? 있으면 1 없으면 0	
		map.put("overlayid", dao.overlayid(userID));	
		
		return map;
	}	

	public HashMap<String, Object> overlaypw(String changeuserPW) {
		
		HashMap<String, Object> map = new HashMap<>();		
		// 현재비밀번호를 사용중인가? 있으면 1 없으면 0	
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();		
		String encodedPassword = encoder.encode(changeuserPW);
				
		map.put("overlaypw", dao.overlaypw(encodedPassword));	
		logger.info("있냐?",map);

		return map;
	}
	
	public HashMap<String, Object> overlaynickname(String userNickname) {
		
		HashMap<String, Object> map = new HashMap<>();
		// 같은 닉네임이 있는가? 있으면 1 없으면 0	
		map.put("overlaynickname", dao.overlaynickname(userNickname));	
		
		return map;
	}
	
	public HashMap<String, Object> join(HashMap<String, String> params) {
		
		HashMap<String, Object> map = new HashMap<>();
		
		String password = params.get("userPW"); 
		logger.info(password);
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String encodedPassword = encoder.encode(password);
		params.replace("userPW", password, encodedPassword);
		map.put("success", dao.join(params));	

		return map;
	}

	public MemberDTO login(String userID) {
		
		logger.info(userID);
		
		return dao.login(userID);
	}
	
	public MemberDTO changememberpw(Object attribute) {

		return dao.changememberpw(attribute);
	}
	
	public int changememberpwtrue(Object object, String changeuserPW) {
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String encodedPassword = encoder.encode(changeuserPW);
		
		return dao.changememberpwtrue(object, encodedPassword);
	}
	
	public int memberdeletetrue(Object attribute) {

		return dao.memberdelete(attribute);
	}
	
	public MemberDTO myinformation(Object attribute) {

		return dao.myinformation(attribute);
	}
	
	public MemberDTO findmemberid(String userName, String userEmail) {

		return dao.findmemberid(userName,userEmail);
	}
	
	public int findmemberpw(String userName, String userID, String userEmail) {
		
		logger.info("비밀번호찾기");
		
		return dao.findmemberpw(userName, userID, userEmail);
	}
	
	public String RandomPassword(String userName, String userID, String userEmail){
		
		String CHAR_LOWER = "abcdefghijklmnopqrstuvwxyz";
	    String CHAR_UPPER = CHAR_LOWER.toUpperCase();
	    String NUMBER = "0123456789";
	    String PASSWORD_ALLOW_BASE = CHAR_LOWER + CHAR_UPPER + NUMBER;
	    int PASSWORD_LENGTH = 8;
	    
	    SecureRandom random = new SecureRandom();
	    
	    String sb = "";
	    
	    for (int i = 0; i < PASSWORD_LENGTH; i++) {
	        int randomIndex = random.nextInt(PASSWORD_ALLOW_BASE.length());
	        char randomChar = PASSWORD_ALLOW_BASE.charAt(randomIndex);
	        sb+=randomChar;
	    }
	    
	    logger.info("임시 비밀번호"+sb);
	    
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String encodedPassword = encoder.encode(sb);
		dao.RandomPassword(userName, userID, userEmail, encodedPassword);
		
		String charSet = "UTF-8";
	    String hostSMTP = "smtp.naver.com"; //네이버 이용시 smtp.naver.com / 구글 사용시 smtp.gmail.com
	    String hostSMTPid = "rckdgns125@naver.com";
	    String hostSMTPpwd = "ckdgns1486";

	    // 보내는 사람 EMail, 제목, 내용
	    String fromEmail = "rckdgns125@naver.com";
	    String fromName = "너나들이";
	    String subject = "";
	    String msg = "";
	      
       subject = "너나들이 임시 비밀번호 입니다.";
       msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
       msg += "<h3 style='color: skyblue;'>";
       msg += "아이디: "+ userID + " 의 임시 비밀번호 입니다. 비밀번호를 변경하여 사용하세요.</h3>";
       msg += "<p>임시 비밀번호 : ";
       msg += sb + "</p></div>";

	      // 받는 사람 E-Mail 주소
	      String mail = userEmail;
	      try {
	         HtmlEmail email = new HtmlEmail();
	         email.setDebug(true);
	         email.setCharset(charSet);
	         email.setSSL(true);
	         email.setHostName(hostSMTP);
	         email.setSmtpPort(587); //네이버 이용시 587 / 구글 이용시 465

	         email.setAuthentication(hostSMTPid, hostSMTPpwd);
	         email.setTLS(true);
	         email.addTo(mail, charSet);
	         email.setFrom(fromEmail, fromName, charSet);
	         email.setSubject(subject);
	         email.setHtmlMsg(msg);
	         email.send();
	      } catch (Exception e) {
	         logger.info("메일발송 실패 : " + e);
	      }		
	    return sb;
	}
	
	
	public MemberDTO findloginpw(String userID) {
		
		return dao.findloginpw(userID);
	}

	

	public MemberDTO chkpw(Object attribute) {

		return dao.chkpw(attribute);
	}


	public HashMap<String, Object> overlaynickname(Object attribute) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("overlaynickname", dao.overlaynickname(attribute));
		
		return map;				
	}





	public HashMap<String, Object> updateusername(String usernickname, String userNickname) {
		
		HashMap<String, Object> map = new HashMap<>();
		// 이름 변경에 실패 했을경우 1, 아니면 0	
		map.put("success", dao.updateusername(usernickname, userNickname));	
		
		return map;
	}
	
	public HashMap<String, Object> updateusernickname(String nownickname, String userNickname) {	
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("success", dao.updateusernickname(nownickname, userNickname));
		
		return map;
	}

	public HashMap<String, Object> updateuseremail(String usernickname, String useremail) {
		
		HashMap<String, Object> map = new HashMap<>();
		// 이메일 변경에 실패 했을경우 1, 아니면 0	
		map.put("success", dao.updateuseremail(usernickname, useremail));
		
		return map;
	}

	public HashMap<String, Object> updateuserContact(String usernickname, String usereContact) {

		HashMap<String, Object> map = new HashMap<>();
		// 전화번호 변경에 실패 했을경우 1, 아니면 0	
		map.put("success", dao.updateuserContact(usernickname, usereContact));
		
		return map;
	}

	public HashMap<String, Object> updateuserAge(String usernickname, String userAge) {
		
		HashMap<String, Object> map = new HashMap<>();
		// 나이 변경에 실패 했을경우 1, 아니면 0	
		map.put("success", dao.updateuserAge(usernickname, userAge));
		
		return map;
	}

	public HashMap<String, Object> updateuserBirthdate(String usernickname, String userBirthdate) {
		
		HashMap<String, Object> map = new HashMap<>();
		// 이메일 변경에 실패 했을경우 1, 아니면 0	
		map.put("success", dao.updateuserBirthdate(usernickname, userBirthdate));
		
		return map;
	}

	public HashMap<String, Object> updateuseraddress(String usernickname, String siID, String guID, String dongID) {

		HashMap<String, Object> map = new HashMap<>();
		// 주소 변경에 실패 했을경우 1, 아니면 0	
		map.put("success", dao.updateuseraddress(usernickname, siID, guID, dongID));
		
		return map;
	}

	public HashMap<String, Object> updateuserGender(String usernickname, String userGender) {

		HashMap<String, Object> map = new HashMap<>();
		// 성별 변경에 실패 했을경우 1, 아니면 0	
		map.put("success", dao.updateuserGender(usernickname, userGender));
		
		return map;		
	}

	public MemberDTO sessionupdatenickname(String userNickname) {
		
		return dao.sessionupdatenickname(userNickname);	
	}

	

}

