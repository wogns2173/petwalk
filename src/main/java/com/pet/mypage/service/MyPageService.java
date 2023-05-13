package com.pet.mypage.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.pet.board.dao.BoardDAO;
import com.pet.board.dto.BoardDTO;
import com.pet.mypage.dao.MyPageDAO;
import com.pet.mypage.dto.MyPageDTO;

@Service
public class MyPageService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MyPageDAO dao;
	@Autowired BoardDAO bdao;
	
	
	public HashMap<String, Object> petprofilecreate(HashMap<String, String> params, MultipartFile photo, HttpSession session) {
		
		String userID = (String) session.getAttribute("userID");
		HashMap<String, Object> map = new HashMap<>();
		//map.put("success", dao.profileWrite(userID, params));
		
		MyPageDTO dto = new MyPageDTO();
		logger.info(params.get("petSize"));
		logger.info(params.get("petName"));
		logger.info(params.get("petAge"));
		logger.info(params.get("petGender"));
		logger.info(params.get("petNeutered"));
		logger.info(params.get("petIntroduce"));
		
		String petSize = params.get("petSize");
		String petName = params.get("petName");
		int petAge = Integer.parseInt(params.get("petAge"));
		String petGender = params.get("petGender");
		int petNeutered = Integer.parseInt(params.get("petNeutered"));
		String petIntroduce = params.get("petIntroduce");
		
		int success = dao.profileWrite(userID, petSize, petName, petAge, petGender, petNeutered, petIntroduce);
		
		if(success == 1) {
			
			map.put("success", 1);
			
			logger.info("프로필 생성 완료");
			
			dto = dao.findprofile(userID);
			
			int profileID = dto.getProfileID();
			
			//첨부파일 같이 업로드 
			if(!photo.getOriginalFilename().equals("")) {
				logger.info("파일 업로드 작업");
				profilephotosave(photo, profileID);
			}
			
		}

			return map;
	}
	// 사진 저장하기
	private void profilephotosave(MultipartFile photo, int profileID) {
		
		String oriPhotoname = photo.getOriginalFilename();
		String ext = oriPhotoname.substring(oriPhotoname.lastIndexOf("."));
		String serPhotoname = System.currentTimeMillis()+ext;
		logger.info(oriPhotoname+"->"+serPhotoname);
		
	
		try {
			byte[] bytes = photo.getBytes();
			Path path = Paths.get("C:/img/petwork/"+serPhotoname);
			Files.write(path, bytes);
			logger.info(serPhotoname+" save OK");
			bdao.fileWrite("P_1", oriPhotoname, serPhotoname, profileID);
			logger.info("사진 저장 완료");
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	public MyPageDTO findprofileAndphoto(String userID) {
		
		MyPageDTO dto = new MyPageDTO();
		dto = dao.findprofile(userID);
		
		if(dto != null) {
			int profileID = dto.getProfileID();
			logger.info("들어와?");
			
			if(profileID != 0) {
				dto = dao.findprofileAndphoto(userID,"P_1",profileID);
				logger.info("여긴?");
			}
		}
				
		return dto;
	}
	
	public HashMap<String, Object> petprofileUpdate(HashMap<String, String> params, MultipartFile photo,
			HttpSession session) {
		
		String userID = (String) session.getAttribute("userID");
		HashMap<String, Object> map = new HashMap<>();
		//map.put("success", dao.profileWrite(userID, params));
		
		MyPageDTO dto = new MyPageDTO();
		logger.info(params.get("petSize"));
		logger.info(params.get("petName"));
		logger.info(params.get("petAge"));
		logger.info(params.get("petGender"));
		logger.info(params.get("petNeutered"));
		logger.info(params.get("petIntroduce"));
		
		String petSize = params.get("petSize");
		String petName = params.get("petName");
		int petAge = Integer.parseInt(params.get("petAge"));
		String petGender = params.get("petGender");
		int petNeutered = Integer.parseInt(params.get("petNeutered"));
		String petIntroduce = params.get("petIntroduce");
		boolean deletePhoto = params.get("deletePhoto") != null;
		
		int success = dao.petprofileUpdate(userID, petSize, petName, petAge, petGender, petNeutered, petIntroduce);
		
		
		if (deletePhoto) {
			String serPhotoname = params.get("serPhotoname");
			logger.info("사진 삭제");
			logger.info("del serPhotoname: " +serPhotoname);
			int row = bdao.photoDelete(serPhotoname);
			if(row == 1) {
				logger.info("사진 블라인드 처리 완료");
			}
		}
		if(success == 1) {
			
			map.put("success", success);
			
			logger.info("프로필 수정 완료");
			
			dto = dao.findprofile(userID);
			
			int profileID = dto.getProfileID();
	
			//사진 저장
			if(photo != null && !photo.getOriginalFilename().equals("")) {
				profilephotosave(photo,profileID);
					
			}
		}
		return map;
	}
	public ArrayList<MyPageDTO> findrouteDrawList(String userID) {
		
		logger.info("내가 작성한 산책 경로 리스트");
	
		ArrayList<MyPageDTO> findrouteDrawList = dao.findrouteDrawList(userID);
	
		return findrouteDrawList;
	}
	public ArrayList<MyPageDTO> myinquiryList(String userID) {
 
		logger.info("내가 문의한 글 리스트");
		
		ArrayList<MyPageDTO> myinquiryList = dao.myinquiryList(userID);
		
		return myinquiryList;
	}
	public ArrayList<MyPageDTO> findrouteShareList(String userID) {

		logger.info("산책경로 공유글 리스트");
		
		ArrayList<MyPageDTO> findrouteShareList = dao.findrouteShareList(userID);
		
		return findrouteShareList;
	}
	public ArrayList<MyPageDTO> bookmark(String userID) {
		
		logger.info("즐겨찾기 산책 경로");
		
		ArrayList<MyPageDTO> bookmark = dao.bookmark(userID);
		return bookmark;
	}


}
