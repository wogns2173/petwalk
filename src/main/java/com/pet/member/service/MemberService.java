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

	public HashMap<String, Object> overlay(String userID) {
		logger.info("시발 아이디 서비스 옴");
		HashMap<String, Object> map = new HashMap<>();
		// 같은 아이디가 있는가? 있으면 1 없으면 0	
		map.put("overlay", dao.overlay(userID));		
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
	
	
}
