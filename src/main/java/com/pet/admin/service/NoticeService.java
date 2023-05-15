package com.pet.admin.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.pet.admin.dao.NoticeDAO;
import com.pet.admin.dto.InquiryDTO;
import com.pet.admin.dto.NoticeDTO;

@Service
public class NoticeService {

	@Autowired NoticeDAO notdao;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public HashMap<String, Object> notlist(HashMap<String, Object> params) {

		logger.info("params :"+params);
		
		int page = Integer.parseInt(String.valueOf(params.get("page")));
		
		int cnt = Integer.parseInt(String.valueOf(params.get("cnt")));
		
		String searchText = String.valueOf(params.get("searchText"));
		
		logger.info("page :"+page+"/"+"ctn :"+cnt+"/"+"searchText :"+searchText);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int offset = cnt * (page-1);
	      
	    logger.info("offset : " + offset);
	    
	    int total = 0;
	    
	    if (searchText.equals("default")) {
	    	total = notdao.noticeAllTotal(params);
	    	logger.info("noticeAllTotal");
	    	
	    }else {
	    	total = notdao.noticeSearchTotal(params,searchText);
	    	logger.info("noticeSearchTotal");
	    }
		
	    int range = total%cnt  == 0 ? total/cnt : (total/cnt)+1;
	      
	    logger.info("총게시글 수 : "+ total);
	    logger.info("총 페이지 수 : "+ range);
	    
	    page = page>range ? range:page;
	    
	    map.put("currPage", page);
	    map.put("pages", range);
	    params.put("offset", offset);
	    
	    ArrayList<NoticeDTO> noticelist = null;
	    
	    
	    if (searchText.equals("default")) {
	    	noticelist = notdao.noticeAllList(params,cnt,offset);
	    	logger.info("noticeAllList");
	    	
	    }else {
	    	noticelist = notdao.noticeSearchList(params,searchText,cnt,offset);
	    	logger.info("noticeSearchList");
	    }
	    
	    map.put("noticelist", noticelist);
	    logger.info("noticelist :"+noticelist);
	    
		return map; 
	}

	public NoticeDTO noticedetail(int boardNum, String flag) {
		logger.info("Notice Detail Service");
		if(flag.equals("noticedetail")) {
			notdao.upHit(boardNum); // 조회수 증가
		}
		return notdao.noticeDetail(boardNum);
	}

	public String noticeWrite(MultipartFile photo, HashMap<String, String> params, String userID) {
		
		String page = "redirect:/noticelist.go";

		//1. 게시글만 작성
		NoticeDTO noticedto = new NoticeDTO();		
		logger.info("userID :"+userID);
		
		noticedto.setBoardName(params.get("boardName"));
		noticedto.setBoardDetail(params.get("boardDetail"));
		noticedto.setUserID(userID);
		
		String categoryCode = "B_05";
		
		logger.info(noticedto.getBoardDetail() + "/" + noticedto.getBoardName());
		int row = notdao.noticeWrite(noticedto);
		logger.info("writeupdate row:"+row);
		int boardNum = noticedto.getBoardNum();
		logger.info("방금 inset한 boardNum: "+"/"+boardNum);
				
	
		//첨부파일 같이 업로드 
		if(!photo.getOriginalFilename().equals("")) {
			logger.info("파일 업로드 작업");
			fileSave(categoryCode,photo,boardNum);
		}
		return page;
	}

	private void fileSave(String categoryCode, MultipartFile photo, int boardNum) {
		String oriPhotoname = photo.getOriginalFilename();
		String ext = oriPhotoname.substring(oriPhotoname.lastIndexOf("."));
		String serPhotoname = System.currentTimeMillis()+ext;
		logger.info(oriPhotoname+"->"+serPhotoname);
		logger.info("categoryCode :"+categoryCode);
	
		try {
			byte[] bytes = photo.getBytes();
			Path path = Paths.get("C:/img/petwork/"+serPhotoname);
			Files.write(path, bytes);
			logger.info(serPhotoname+"save OK");
			notdao.fileWrite(categoryCode, oriPhotoname, serPhotoname, boardNum);
			logger.info("사진 저장 완료");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	public int noticereplywrite(int boardNum, String content, String userID) {
		logger.info("Notice Reply Write Service");
		logger.info("userID :"+userID);

		return notdao.noticerepwrite(boardNum, content, userID);
	}

	public ArrayList<NoticeDTO> noticereplist2(int boardNum) {
	
		return notdao.noticereplist2(boardNum);
	}

	public int notrepdel(int replyNum) {
		logger.info("Notice Reply Delete Service");
		
		return notdao.noticerepdel(replyNum);
	}

	public NoticeDTO noticereplist(int boardNum, int replyNum, String commentDetail) {
		logger.info("Notice Reply List Service");
		
		return notdao.noticereplist(boardNum, replyNum, commentDetail);
	}

	public String noticerepupdate(HashMap<String, String> params) {
		logger.info("Notice Reply Update Service");
		logger.info("params :"+ params);
		
		int row = notdao.noticerepupdate(params);
		
		logger.info("update row :"+row);
		
		return "redirect:/noticedetail.do?boardNum="+params.get("boardNum");	
		
	}

	public int noticeBlindUpdate(int boardNum, int blind) {
		logger.info("Notice Process Update Service");
		return notdao.noticeBlindUpdate(boardNum, blind);
	}




}
