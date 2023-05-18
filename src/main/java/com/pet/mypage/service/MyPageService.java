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

import com.pet.admin.dto.InquiryDTO;
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
		
		logger.info("내가 작성한 반려견 프로필");
		
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
		boolean deletePhoto = "true".equals(params.get("deletePhoto"));
		
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
	
	public HashMap<String, Object> petphoto(MultipartFile photo, HttpSession session) {

		logger.info("파일 업로드 중");
		
		HashMap<String, Object> map = new HashMap<>();
				
		if(photo != null && !photo.getOriginalFilename().equals("")) {
	
			String oriPhotoname = photo.getOriginalFilename();
			String ext = oriPhotoname.substring(oriPhotoname.lastIndexOf("."));
			String serPhotoname = System.currentTimeMillis()+ext;
			logger.info(oriPhotoname+"->"+serPhotoname);
			
			try {
				byte[] bytes = photo.getBytes();
				Path path = Paths.get("C:/img/petwork/"+serPhotoname);
				Files.write(path, bytes);
				logger.info(serPhotoname+" save OK");
				bdao.fileWrite("P_1", oriPhotoname, serPhotoname, 10);
				logger.info("사진 저장 완료");
				
			} catch (IOException e) {
				e.printStackTrace();
			}

			logger.info("파일 업로드 완?료");
			map.put("success", 1);
		}
		
		return map;
	}
	public HashMap<String, Object> myroutlistCall(int page, int cnt,HttpSession session) {
		logger.info(page+"페이지(내가 작성한 경로) 보여줘");
		logger.info("한 페이지에(내가 작성한 경로)  "+cnt+" 개씩 보여줄거야");
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		
		//1page = offset : 0
		//2page = offset : 5
		//3page = offset : 10
		int offset = (page-1)*cnt;
		
		// 만들 수 있는 총 페이지 수
		// 전체 게시물 / 페이지당 보여줄 수
		
		String userID =  (String) session.getAttribute("userID");
		int total = dao.totalCount(userID);
		int range = total%cnt ==0? total/cnt : (total/cnt)+1;
		logger.info("(내가 작성한 경로) 전체 게시물  수 : "+total);
		logger.info("(내가 작성한 경로) 총 페이지 수 : "+range);
		
		page = page > range ? range : page;
		map.put("currPage", page);
		map.put("pages", range);
		
		ArrayList<BoardDTO> myroutlistCall = dao.myroutlistCalllist(cnt, offset, userID);
		map.put("myroutlistCall", myroutlistCall);
		return map;
	}
	public HashMap<String, Object> mybookmarklistCall(int page, int cnt, HttpSession session) {
		logger.info(page+"페이지(내가 즐겨찾기한 경로) 보여줘");
		logger.info("한 페이지에(내가 즐겨찾기한 경로) "+cnt+" 개씩 보여줄거야");
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		
		//1page = offset : 0
		//2page = offset : 5
		//3page = offset : 10
		int offset = (page-1)*cnt;
		
		// 만들 수 있는 총 페이지 수
		// 전체 게시물 / 페이지당 보여줄 수
		
		String userID =  (String) session.getAttribute("userID");
		int total = dao.mybookmarktotalCount(userID);
		int range = total%cnt ==0? total/cnt : (total/cnt)+1;
		logger.info("(내가 즐겨찾기한 경로)전체 게시물  수 : "+total);
		logger.info("(내가 즐겨찾기한 경로)총 페이지 수 : "+range);
		
		page = page > range ? range : page;
		map.put("mybookmarkcurrPage", page);
		map.put("mybookmarkpages", range);
		
		ArrayList<BoardDTO> mybookmarklistCall = dao.mybookmarklistCall(cnt, offset, userID);
		map.put("mybookmarklistCall", mybookmarklistCall);
		return map;
	}
	
	
	public HashMap<String, Object> myinquirylistCall(int page, int cnt, HttpSession session) {
		
		logger.info(page+"페이지 보여줘(내가 문의한)");
		logger.info("한 페이지에(내가 문의한) "+cnt+" 개씩 보여줄거야");
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		
		//1page = offset : 0
		//2page = offset : 5
		//3page = offset : 10
		int offset = (page-1)*cnt;
		
		// 만들 수 있는 총 페이지 수
		// 전체 게시물 / 페이지당 보여줄 수
		
		String userID =  (String) session.getAttribute("userID");
		int total = dao.myinquirytotalCount(userID);
		int range = total%cnt ==0? total/cnt : (total/cnt)+1;
		logger.info("(내가 문의한)전체 게시물  수 : "+total);
		logger.info("(내가 문의한)총 페이지 수 : "+range);
		
		page = page > range ? range : page;
		map.put("myinquirycurrPage", page);
		map.put("myinquirypages", range);
		
		ArrayList<BoardDTO> myinquirylistCall = dao.myinquirylistCall(cnt, offset, userID);
		map.put("myinquirylistCall", myinquirylistCall);
		
		return map;
	}
	public HashMap<String, Object> myreportlistCall(int page, int cnt, HttpSession session) {
		
		logger.info(page+"페이지(내가 신고한) 보여줘");
		logger.info("한 페이지에(내가 신고한) "+cnt+" 개씩 보여줄거야");
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		
		//1page = offset : 0
		//2page = offset : 5
		//3page = offset : 10
		int offset = (page-1)*cnt;
		
		// 만들 수 있는 총 페이지 수
		// 전체 게시물 / 페이지당 보여줄 수
		
		String userID =  (String) session.getAttribute("userID");
		int total = dao.myreporttotalCount(userID);
		int range = total%cnt ==0? total/cnt : (total/cnt)+1;
		logger.info("(내가 신고한)전체 게시물  수 : "+total);
		logger.info("(내가 신고한)총 페이지 수 : "+range);
		
		page = page > range ? range : page;
		map.put("myreportcurrPage", page);
		map.put("myreportpages", range);
		
		ArrayList<BoardDTO> myreportlistCall = dao.myreportlistCall(cnt, offset, userID);
		map.put("myreportlistCall", myreportlistCall);
		
		return map;
	}
	
	public HashMap<String, Object> myreviewlistCall(int page, int cnt, HttpSession session) {

		logger.info(page+"페이지 보여줘(내게 달린 후기)");
		logger.info("한 페이지에(내게 달린 후기) "+cnt+" 개씩 보여줄거야");
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		
		//1page = offset : 0
		//2page = offset : 5
		//3page = offset : 10
		int offset = (page-1)*cnt;
		
		// 만들 수 있는 총 페이지 수
		// 전체 게시물 / 페이지당 보여줄 수
		
		String userID =  (String) session.getAttribute("userID");
		int total = dao.myreviewtotalCount(userID);
		int range = total%cnt ==0? total/cnt : (total/cnt)+1;
		logger.info("(내게 달린 후기)전체 게시물  수 : "+total);
		logger.info("(내게 달린 후기)총 페이지 수 : "+range);
		
		page = page > range ? range : page;
		map.put("myreviewcurrPage", page);
		map.put("myreviewpages", range);
		
		ArrayList<BoardDTO> myreviewlistCall = dao.myreviewlistCall(cnt, offset, userID);
		map.put("myreviewlistCall", myreviewlistCall);
		
		return map;

	}
	public HashMap<String, Object> otroutesharelistCall(int page, int cnt, String userID) {
		
		logger.info(page+"페이지 보여줘(남이 공유한 경로)");
		logger.info("한 페이지에(남이 공유한 경로) "+cnt+" 개씩 보여줄거야");
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		
		//1page = offset : 0
		//2page = offset : 5
		//3page = offset : 10
		int offset = (page-1)*cnt;
		
		// 만들 수 있는 총 페이지 수
		// 전체 게시물 / 페이지당 보여줄 수
		
		int total = dao.otroutesharetotalCount(userID);
		int range = total%cnt ==0? total/cnt : (total/cnt)+1;
		logger.info("(남이 공유한 경로)전체 게시물  수 : "+total);
		logger.info("(남이 공유한 경로)총 페이지 수 : "+range);
		
		page = page > range ? range : page;
		map.put("otroutesharecurrPage", page);
		map.put("otroutesharepages", range);
		
		ArrayList<BoardDTO> otroutesharelistCall = dao.otroutesharelistCall(cnt, offset, userID);
		map.put("otroutesharelistCall", otroutesharelistCall);
		return map;
	}
	
	public HashMap<String, Object> otreviewlistCall(int page, int cnt, String userID) {

		logger.info(page+"페이지(남의 후기) 보여줘");
		logger.info("한 페이지에(남의 후기) "+cnt+" 개씩 보여줄거야");
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		
		//1page = offset : 0
		//2page = offset : 5
		//3page = offset : 10
		int offset = (page-1)*cnt;
		
		// 만들 수 있는 총 페이지 수
		// 전체 게시물 / 페이지당 보여줄 수
		
		int total = dao.otreviewtotalCount(userID);
		int range = total%cnt ==0? total/cnt : (total/cnt)+1;
		logger.info("(남의 후기)전체 게시물  수 : "+total);
		logger.info("(남의 후기)총 페이지 수 : "+range);
		
		page = page > range ? range : page;
		map.put("otreviewcurrPage", page);
		map.put("otreviewpages", range);
		
		ArrayList<BoardDTO> otreviewlistCall = dao.otreviewlistCall(cnt, offset, userID);
		map.put("otreviewlistCall", otreviewlistCall);
		return map;
	}
	public HashMap<String, Object> deletemr(ArrayList<String> delList, HttpSession session) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		String userID = (String) session.getAttribute("userID");
		for (String walkNum : delList) {
			dao.deletemr(walkNum, userID);
		}
		
		map.put("success", true);
		return map;
	}
	
public HashMap<String, Object> application(String mateWalkNum, String userID) {
		
		int success = dao.application(mateWalkNum, userID);
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		if(success == 1) {			
			map.put("success", success);
		}else {
			map.put("success", 0);
		}
				
		return map;
	}
	
	public HashMap<String, Object> cancel(String mateWalkNum, String userID) {
		
		int success = dao.cancel(mateWalkNum, userID);		
		HashMap<String, Object> map = new HashMap<String, Object>();
		logger.info("들어와?" + success);
		
		if(success >= 1) {			
			map.put("success", success);
		}else {
			map.put("success", 0);
		}
		
		return map;
	}
	
	public HashMap<String, Object> applicantlist(String mateWalkNum) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		ArrayList<BoardDTO> applicantlist = dao.applicantlist(mateWalkNum);
	
		map.put("applicantlist", applicantlist);

		return map;
	}
	






}
