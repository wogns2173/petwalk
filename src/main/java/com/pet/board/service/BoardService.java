package com.pet.board.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Clob;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

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
		logger.info("Service B_02list");
		return dao.B_02list();
	}

/*
	public String boardWrite(String userID, String boardName
			, String boardDetail, String categoryCode, String photo
			,HttpSession session) {
		logger.info("Service boardWrite!");
		if(userID != null) {
			logger.info("write.do:"+boardName+"/"+boardDetail+"/"+categoryCode+"/"+photo);
			
			}
		return dao.boardWrite(userID,boardName,boardDetail,categoryCode);
	}
*/
/*
	public int boardWrite(boardDTO dto) {
		return dao.boardWrite(dto);
	}
*/
	public String boardWrite(MultipartFile photo, HashMap<String, String> params) {
		
		String page = "redirect:/board";

		//1. 게시글만 작성
		boardDTO dto = new boardDTO();
		
		dto.setBoardDetail(params.get("boardDetail"));
		dto.setCategoryCode(params.get("categoryCode"));
		dto.setBoardName(params.get("boardName"));
		
		logger.info(dto.getBoardDetail() + "/" + dto.getCategoryCode() + "/" + dto.getBoardName());
		int row = dao.boardWrite(dto);
		logger.info("update row:"+row);
		
		int boardNum = Integer.parseInt(dto.getBoardNum());
		logger.info("방금 inset한 boardNum: "+boardNum);
				
	
		//첨부파일 같이 업로드 
		if(!photo.getOriginalFilename().equals("")) {
			logger.info("파일 업로드 작업");
			fileSave(boardNum,photo);
		}
		return page;
	}


	private void fileSave(int boardNum, MultipartFile photo) {
		String oriPhotoname = photo.getOriginalFilename();
		String ext = oriPhotoname.substring(oriPhotoname.lastIndexOf("."));
		String serPhotoname = System.currentTimeMillis()+ext;
		logger.info(oriPhotoname+"->"+serPhotoname);
	
		try {
			byte[] bytes = photo.getBytes();
			Path path = Paths.get("C:/img/petwork/"+serPhotoname);
			Files.write(path, bytes);
			logger.info(serPhotoname+"save OK");
			dao.fileWrite(boardNum,oriPhotoname,serPhotoname);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
}

	public boardDTO boardDetail(String boardNum) {
		logger.info("Service boardDetail!");
		dao.boardbHit(boardNum);
		return dao.boardDetail(boardNum);
	}


	

}
