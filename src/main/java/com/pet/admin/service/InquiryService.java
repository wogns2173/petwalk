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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.pet.admin.dao.InquiryDAO;
import com.pet.admin.dto.InquiryDTO;
import com.pet.board.dto.BoardDTO;

@Service
public class InquiryService {

	@Autowired InquiryDAO inqdao;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());

	

	/*
	 * public ArrayList<InquiryDTO> inqlist() { logger.info("Inquiry list service");
	 * return inqdao.inqlist(); }
	 */

	public InquiryDTO inqdetail(int boardNum, String flag) {
		logger.info("Inquiry detail service");
		if(flag.equals("inqdetail")) {
			inqdao.upHit(boardNum); // 조회수 증가
		}
		return inqdao.inqdetail(boardNum);
	
	}

	public InquiryDTO inqreplist(int boardNum, int replyNum, String commentDetail) {
		logger.info("Inquiry Reply List Service");
		return inqdao.inqreplist(boardNum, replyNum, commentDetail);
	}

	public int inqreplywrite(int boardNum, String content) {
		logger.info("Inquiry Reply Write Service");

		return inqdao.inqrepwrite(boardNum, content);
	}

	public int inqrepdel(int replyNum) {
		logger.info("Inquiry Reply Delete Service");
		
		return inqdao.inqrepdel(replyNum);
	}

	public String update(HashMap<String, String> params) {
		logger.info("Inquiry Reply Update Service");
		logger.info("params :"+ params);
		
		int row = inqdao.inqrepupdate(params);
		
		logger.info("update row :"+row);
		
		return "redirect:/inquirydetail.do?boardNum="+params.get("boardNum");	
		
	}

	public ArrayList<InquiryDTO> inqreplist2(int boardNum) {
		return inqdao.inqreplist2(boardNum);
	}

	public String boardWrite(MultipartFile photo, HashMap<String, String> params) {
		String page = "redirect:/inquirylist.go";

		//1. 게시글만 작성
		InquiryDTO inqdto = new InquiryDTO();
		
		
		inqdto.setCategoryCode(params.get("categoryCode"));
		inqdto.setBoardName(params.get("boardName"));
		inqdto.setBoardDetail(params.get("boardDetail"));
		
		logger.info(inqdto.getBoardDetail() + "/" + inqdto.getCategoryCode() + "/" + inqdto.getBoardName());
		int row = inqdao.boardWrite(inqdto);
		logger.info("writeupdate row:"+row);
		int boardNum = inqdto.getBoardNum();
		String categoryCode = inqdto.getCategoryCode();
		logger.info("방금 inset한 categoryCode: "+categoryCode+"/"+boardNum);
				
	
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
			inqdao.fileWrite(categoryCode, oriPhotoname, serPhotoname, boardNum);
			logger.info("사진 저장 완료");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	

	/*
	 * public HashMap<String, Object> inqlist(int page, int cnt) { // 1page = offset
	 * : 0 // 2page = offset : 5 // 3page = offset : 10
	 * 
	 * HashMap<String, Object> map = new HashMap<String,Object>();
	 * 
	 * int offset = (page-1)*cnt;
	 * 
	 * // 만들 수 있는 총 페이지 수 // 전체 게시물 / 페이지당 보여줄 수 int total = inqdao.totalCount();
	 * int range = total%cnt == 0 ? total/cnt : (total/cnt)+1;
	 * logger.info("전체 게시물 수 :"+total); logger.info("총 페이지 수 :"+range);
	 * 
	 * page = page > range ? range : page;
	 * 
	 * 
	 * 
	 * map.put("currPage", page); map.put("pages", range);
	 * 
	 * ArrayList<BoardDTO> list = inqdao.inquirylist(cnt, offset); map.put("list",
	 * list);
	 * 
	 * return map;
	 * 
	 * 
	 * }
	 */
	public HashMap<String, Object> inqlist(HashMap<String, Object> params) {
	      
			logger.info("params :"+params);
	      
	      int page = Integer.parseInt(String.valueOf(params.get("page")));
	      String categoryCode = String.valueOf(params.get("categoryCode"));
	      Boolean process = Boolean.valueOf(String.valueOf(params.get("process")));
	      int cnt = Integer.parseInt(String.valueOf(params.get("cnt")));
	      
	      logger.info("categoryCode :"+categoryCode+"/"+"process :"+process);
	      logger.info(page + "를 선택된 문의 방식이" +categoryCode+"때만 보여줘");
	      logger.info("한페이지에 " + cnt +"개씩 보여줄 것 ");
	      
	      HashMap<String, Object> map = new HashMap<String, Object>();
	      
	      // 1페이지  offset 0
	      // 2페이지 offset 5
	      // 3 페이지 offset 10
	      int offset = cnt * (page-1);
	      
	      logger.info("offset : " + offset);
	      
	      // 만들 수 있는 총 페이지 수 : 전체 게시글의 수 / 페이지당 보여줄 수 있는 수
	      int total = 0;
	      
	     // if(categoryCode.equals("default")){
	         if(categoryCode.equals("default") && process.equals(Boolean.valueOf("default"))) {
	         // 전체 보여주기
	         total = inqdao.totalCount(params);
	         logger.info("totalCount");
	        
	         }else if(!(categoryCode.equals("default")) && process.equals(Boolean.valueOf("default"))){
	        	 params.put("categoryCode", categoryCode);
			     logger.info("params :"+params);
	            // 문의 필터링만 선택 된 경우 
	            total = inqdao.totalCountinquiry(params,categoryCode);
	            logger.info("totalCountinquiry");
	            
	         }else if(categoryCode.equals("default") && !process.equals(Boolean.valueOf("default"))){
	            
	            // 처리 여부 필터링만 선택 된 경우
	            total = inqdao.totalCountprocess(params,process);
	            logger.info("totalCountprocess");
	         }else {
	            // 문의,처리 필터링 둘다 선택 된 경우 
	            total = inqdao.totalCountAll(params,categoryCode,process);
	            logger.info("totalCountAll");
	         }
	      
	      
	      
	      int range = total%cnt  == 0 ? total/cnt : (total/cnt)+1;
	      
	      logger.info("총게시글 수 : "+ total);
	      logger.info("총 페이지 수 : "+ range);
	      
	      page = page>range ? range:page;
	      
	      map.put("currPage", page);
	      map.put("pages", range);
	      
	      ArrayList<InquiryDTO> inqlist = null;
	      
	      
	      params.put("offset", offset);
	      
	      
	      logger.info("params : " + params);
	      
	      // if(categoryCode.equals("default")){
	         if(categoryCode.equals("default") && process.equals(Boolean.valueOf("default"))) {
	            // 전체 보여주기
				/* list = inqdao.inquirylist(offset,categoryCode); */
	        	 inqlist = inqdao.inquirylist(params,cnt,offset);
	            logger.info("inquirylist");
	         }else if(!(categoryCode.equals("default")) && process.equals(Boolean.valueOf("default"))) {
	            // 문의 필터링만 선택 된 경우 
	        	 inqlist = inqdao.listinquiry(params,categoryCode,cnt,offset);
	            logger.info("listinquiry");
	         }
	         
	         else if(categoryCode.equals("default") && !(process.equals(Boolean.valueOf("default")))){
	            // 처리 여부 필터링만 선택 된 경우
	        	 inqlist = inqdao.listinqprocess(params,process,cnt,offset);
	            logger.info("listinqprocess");
	         }else {
	            // 문의,처리 필터링 모두 선택
	        	 inqlist = inqdao.listinqAll(params,categoryCode,process,cnt,offset);
	            logger.info("listinqAll");
	         }
	         
	         map.put("inqlist", inqlist);
	         logger.info("inqlist :"+inqlist);
	         return map;
	      }

	public String processupdate(Boolean selectedValue, int boardNum) {
		
		logger.info("Inquiry Process Update Service");	
	    logger.info("selectedValue :"+selectedValue+"/"+"boardNum :"+boardNum);
	    
		int row = inqdao.inqprocessupdate(selectedValue,boardNum);
		
		logger.info("update row :"+row);
		
		return "redirect:/inquirydetail.do?boardNum="+boardNum;	
		
	}
		
}
	    
	      
	







