package com.pet.admin.service;

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

	public int inqreplywrite(int boardNum, String content, String userID) {
		logger.info("Inquiry Reply Write Service");
		logger.info("userID :"+userID);

		return inqdao.inqrepwrite(boardNum, content, userID);
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

	public String boardWrite(MultipartFile photo, HashMap<String, String> params, String userID) {
		
		String page = "redirect:/profile.go";	
			
		//1. 게시글만 작성
		InquiryDTO inqdto = new InquiryDTO();
		logger.info("userID :"+userID);

		inqdto.setCategoryCode(params.get("categoryCode"));
		inqdto.setBoardName(params.get("boardName"));
		inqdto.setBoardDetail(params.get("boardDetail"));
		inqdto.setUserID(userID);
		
		logger.info(inqdto.getUserID()+"/"+inqdto.getBoardDetail() + "/" + inqdto.getCategoryCode() + "/" + inqdto.getBoardName());
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

	public HashMap<String, Object> inqlist(HashMap<String, Object> params) {
	      
			logger.info("params :"+params);
			
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
		            total = inqdao.totalCount(params, categoryCode,storedValue);
		            logger.info("전체 문의 리스트 / totalCount");
		        } else {
		            total = inqdao.totalCountprocess(params, storedValue, categoryCode);
		            logger.info("처리 여부 리스트 / totalCountprocess" + storedValue);
		        }
		    } else {
		        if (inqProcess.equals("default")) {
		            total = inqdao.totalCountinquiry(params, categoryCode);
		            logger.info("선택한 문의 리스트 / totalCountinquiry" + categoryCode);
		        } else {
		            total = inqdao.totalCountAll(params, categoryCode, storedValue);
		            logger.info("선택한 문의, 처리여부 리스트 / totalCountAll" + categoryCode + storedValue);
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
	    	    	inqlist = inqdao.inquirylist(map, cnt, offset, categoryCode,storedValue);
	    	        logger.info("전체 문의 리스트 / inquirylist");
	    	    } else {
	    	    	inqlist = inqdao.listinqprocess(params, storedValue, cnt, offset,categoryCode);
	    	        logger.info("처리 여부 리스트 / listinqprocess" + storedValue);
	    	    }
	    	} else {
	    	    if (inqProcess.equals("default")) {
	    	    	inqlist = inqdao.listinquiry(params, categoryCode, cnt, offset);
	    	        logger.info("선택한 문의 리스트 / listinquiry" + categoryCode);
	    	    } else {
	    	    	inqlist = inqdao.listinqAll(params, categoryCode, storedValue, cnt, offset);
	    	        logger.info("선택한 문의, 처리여부 리스트 / listinqAll" + categoryCode + storedValue);
	    	    }
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
	    
	      
	







