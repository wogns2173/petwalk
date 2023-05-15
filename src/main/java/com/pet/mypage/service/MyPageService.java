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
		logger.info(page+"페이지 보여줘");
		logger.info("한 페이지에 "+cnt+" 개씩 보여줄거야");
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
		logger.info("전체 게시물  수 : "+total);
		logger.info("총 페이지 수 : "+range);
		
		page = page > range ? range : page;
		map.put("currPage", page);
		map.put("pages", range);
		
		ArrayList<BoardDTO> myroutlistCall = dao.myroutlistCalllist(cnt, offset, userID);
		map.put("myroutlistCall", myroutlistCall);
		return map;
	}
	public HashMap<String, Object> mybookmarklistCall(int page, int cnt, HttpSession session) {
		logger.info(page+"페이지 보여줘");
		logger.info("한 페이지에 "+cnt+" 개씩 보여줄거야");
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
		logger.info("전체 게시물  수 : "+total);
		logger.info("총 페이지 수 : "+range);
		
		page = page > range ? range : page;
		map.put("mybookmarkcurrPage", page);
		map.put("mybookmarkpages", range);
		
		ArrayList<BoardDTO> mybookmarklistCall = dao.mybookmarklistCall(cnt, offset, userID);
		map.put("mybookmarklistCall", mybookmarklistCall);
		return map;
	}
	
/*	public HashMap<String, Object> myreviewlistCall(int page, int cnt, HttpSession session) {

		logger.info(page+"페이지 보여줘");
		logger.info("한 페이지에 "+cnt+" 개씩 보여줄거야");
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
		logger.info("전체 게시물  수 : "+total);
		logger.info("총 페이지 수 : "+range);
		
		page = page > range ? range : page;
		map.put("mybookmarkcurrPage", page);
		map.put("mybookmarkpages", range);
		
		ArrayList<BoardDTO> mybookmarklistCall = dao.mybookmarklistCall(cnt, offset, userID);
		map.put("mybookmarklistCall", mybookmarklistCall);
		return map;
	}
	*/
	
	public HashMap<String, Object> myinquirylistCall(int page, int cnt, HttpSession session) {
		
		logger.info(page+"페이지 보여줘");
		logger.info("한 페이지에 "+cnt+" 개씩 보여줄거야");
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
		logger.info("전체 게시물  수 : "+total);
		logger.info("총 페이지 수 : "+range);
		
		page = page > range ? range : page;
		map.put("myinquirycurrPage", page);
		map.put("myinquirypages", range);
		
		ArrayList<BoardDTO> myinquirylistCall = dao.myinquirylistCall(cnt, offset, userID);
		map.put("myinquirylistCall", myinquirylistCall);
		
		return map;
	}
	public HashMap<String, Object> myreportlistCall(int page, int cnt, HttpSession session) {
		
		logger.info(page+"페이지 보여줘");
		logger.info("한 페이지에 "+cnt+" 개씩 보여줄거야");
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
		logger.info("전체 게시물  수 : "+total);
		logger.info("총 페이지 수 : "+range);
		
		page = page > range ? range : page;
		map.put("myreportcurrPage", page);
		map.put("myreportpages", range);
		
		ArrayList<BoardDTO> myreportlistCall = dao.myreportlistCall(cnt, offset, userID);
		map.put("myreportlistCall", myreportlistCall);
		
		return map;
	}
	
	public ArrayList<MyPageDTO> myinquiryList(String userID) {
		
		ArrayList<MyPageDTO> myinquiryList = dao.myinquiryList(userID);
		
		return myinquiryList;
	}
	
	public ArrayList<MyPageDTO> findrouteShareList(String userID) {
		
		ArrayList<MyPageDTO> findrouteShareList = dao.findrouteShareList(userID);
		
		return findrouteShareList;
	}
	public HashMap<String, Object> inqlistme(HashMap<String, Object> params, HttpSession session) {

		logger.info("params :"+params);
		String userID = (String) session.getAttribute("userID");
		int page = Integer.parseInt(String.valueOf(params.get("page")));
	      
		String categoryCode = String.valueOf(params.get("categoryCode"));
      
		int cnt = Integer.parseInt(String.valueOf(params.get("cnt")));
		
		String inqProcess = String.valueOf(params.get("inqProcess"));
		Object storedValue;

		if (inqProcess.equals("default")) {
		    storedValue = inqProcess; // "default"를 문자열로 저장합니다.
		} else {
		    storedValue = inqProcess.equals("true") ? 1 : 0; // "true"일 때는 1로, "false"일 때는 0으로 저장합니다.
		}
		
		logger.info("storedValue :"+storedValue);
		
		
		logger.info("categoryCode :"+categoryCode+"/"+"storedValue :"+storedValue);
		logger.info(page + "페이지를 선택된 문의 방식이 " +categoryCode+" 때만 보여준다.");
		logger.info("한 페이지에 " + cnt +" 개씩 보여줄 것 ");
      
		HashMap<String, Object> map = new HashMap<String, Object>();
	      
	      // 1페이지  offset 0
	      // 2페이지 offset 5
	      // 3 페이지 offset 10
	    int offset = cnt * (page-1);
	      
	    logger.info("offset : " + offset);
	      
	    // 만들 수 있는 총 페이지 수 : 전체 게시글의 수 / 페이지당 보여줄 수 있는 수
	    int total = 0;

	    if (categoryCode.equals("default")) {
	        if (inqProcess.equals("default")) {
	            total = dao.metotalCount(params, categoryCode,storedValue, userID);
	            logger.info("전체 문의 리스트 / totalCount");
	        } else {
	            total = dao.metotalCountprocess(params, storedValue, categoryCode, userID);
	            logger.info("처리 여부 리스트 / totalCountprocess" + storedValue);
	        }
	    } else {
	        if (inqProcess.equals("default")) {
	            total = dao.metotalCountinquiry(params, categoryCode,userID);
	            logger.info("선택한 문의 리스트 / totalCountinquiry" + categoryCode);
	        } else {
	            total = dao.metotalCountAll(params, categoryCode, storedValue, userID);
	            logger.info("선택한 문의, 처리여부 리스트 / totalCountAll" + categoryCode + storedValue,userID);
	        }
	    }

      
      int range = total%cnt  == 0 ? total/cnt : (total/cnt)+1;
      
      logger.info("총게시글 수 : "+ total);
      logger.info("총 페이지 수 : "+ range);
      
      page = page>range ? range:page;
      
      map.put("currPage", page);
      map.put("pages", range);
      
      ArrayList<InquiryDTO> inqlist = null;
           
      params.put("offset", offset);
      
      // if(categoryCode.equals("default")){
      //  && (inqProcess.equals(Boolean.valueOf("default")))
		/*
		 * if(categoryCode.equals("default") && (inqProcess.equals("default"))){ inqlist
		 * = inqdao.inquirylist(map, cnt, offset, categoryCode);
		 * logger.info("전체 문의 리스트 / inquirylist"); }else
		 * if(!(categoryCode.equals("default") && (inqProcess.equals("default")))) {
		 * inqlist = inqdao.listinquiry(params, categoryCode, cnt, offset);
		 * logger.info("선택한 문의 리스트 / listinquiry"+categoryCode); }else
		 * if(categoryCode.equals("default") && !(inqProcess.equals("default"))) {
		 * inqlist = inqdao.listinqprocess(params, storedValue, cnt, offset,
		 * categoryCode); logger.info("처리 여부 리스트 / listinqprocess"+storedValue); }else {
		 * inqlist = inqdao.listinqAll(params, categoryCode, storedValue, cnt, offset);
		 * logger.info("선택한 문의, 처리여부 리스트 / listinqAll"+categoryCode+storedValue); }
		 */
      if (categoryCode.equals("default")) {
    	    if (inqProcess.equals("default")) {
    	    	inqlist = dao.meinquirylist(map, cnt, offset, categoryCode,storedValue,userID);
    	        logger.info("전체 문의 리스트 / inquirylist");
    	    } else {
    	    	inqlist = dao.melistinqprocess(params, storedValue, cnt, offset,categoryCode,userID);
    	        logger.info("처리 여부 리스트 / listinqprocess" + storedValue);
    	    }
    	} else {
    	    if (inqProcess.equals("default")) {
    	    	inqlist = dao.melistinquiry(params, categoryCode, cnt, offset,userID);
    	        logger.info("선택한 문의 리스트 / listinquiry" + categoryCode);
    	    } else {
    	    	inqlist = dao.melistinqAll(params, categoryCode, storedValue, cnt, offset,userID);
    	        logger.info("선택한 문의, 처리여부 리스트 / listinqAll" + categoryCode + storedValue);
    	    }
    	}

         
         map.put("inqlist", inqlist);
         logger.info("inqlist :"+inqlist);
         return map;
	}
	






}
