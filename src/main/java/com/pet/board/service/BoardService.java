package com.pet.board.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.pet.board.dao.boardDAO;
import com.pet.board.dto.boardDTO;

@Service
public class BoardService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired boardDAO dao;
	
	public ArrayList<boardDTO> B_02list() {
		logger.info("Service B_02list 요청완료");
		return dao.B_02list();
	}


	public String boardWrite(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return null;
	}

}
