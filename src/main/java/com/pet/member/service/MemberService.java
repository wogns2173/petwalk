package com.pet.member.service;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pet.member.dao.MemberDAO;

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

	public HashMap<String, Object> overlaynickname(String userNickname) {
		
		HashMap<String, Object> map = new HashMap<>();
		// 같은 닉네임이 있는가? 있으면 1 없으면 0	
		map.put("overlaynickname", dao.overlaynickname(userNickname));		
		return map;
	}
	

	public HashMap<String, Object> join(HashMap<String, String> params) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("success", dao.join(params));		
		return map;
	}

	public int login(String userID, String userPW) {
		
		return dao.login(userID, userPW);
	}


	public int deletemember(Object removeAttribute) {

		return dao.memberdelete(removeAttribute);
	}

	public int memberdeletetrue(Object attribute) {

		return dao.memberdelete(attribute);
	}



	
}

