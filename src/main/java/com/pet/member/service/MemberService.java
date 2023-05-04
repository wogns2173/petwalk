package com.pet.member.service;

import java.security.SecureRandom;
import java.util.HashMap;

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
		
		if(changeuserPW.length()>=8) {
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();		
			String encodedPassword = encoder.encode(changeuserPW);
					
			map.put("overlaypw", dao.overlaypw(encodedPassword));	
			logger.info("있냐?",map);
		}
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


	public MemberDTO findloginpw(String userID) {
		
		return dao.findloginpw(userID);

	}

	public int memberdeletetrue(Object attribute) {

		return dao.memberdelete(attribute);
	}

	public MemberDTO memberdetail(Object attribute) {

		return dao.memberdetail(attribute);
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
		
	    return sb;
	}


	public MemberDTO chkpw(Object attribute) {

		return dao.chkpw(attribute);
	}

	public HashMap<String, Object> overlaynickname(String userNickname) {
		
		HashMap<String, Object> map = new HashMap<>();
		// 같은 닉네임이 있는가? 있으면 1 없으면 0	
		map.put("overlaynickname", dao.overlaynickname(userNickname));	
		
		return map;
	}
	public HashMap<String, Object> overlaynickname(Object attribute) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("overlaynickname", dao.overlaynickname(attribute));
		return map;
		
		
	}


	public MemberDTO changememberpw(Object attribute) {

		return dao.changememberpw(attribute);
	}


	public int changememberpwtrue(Object object, String changeuserPW) {
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String encodedPassword = encoder.encode(changeuserPW);
		
		return dao.changememberpwtrue(object, encodedPassword);
	}







}

