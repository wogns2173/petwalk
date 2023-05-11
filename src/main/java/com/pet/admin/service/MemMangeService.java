package com.pet.admin.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pet.admin.dao.MemManageDAO;
import com.pet.admin.dto.InquiryDTO;
import com.pet.admin.dto.MemManageDTO;

@Service
public class MemMangeService {

	@Autowired MemManageDAO memdao;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public HashMap<String, Object> memlist(HashMap<String, Object> params) {
		
		logger.info("params :"+params);
		
		int page = Integer.parseInt(String.valueOf(params.get("page")));
		
		int cnt = Integer.parseInt(String.valueOf(params.get("cnt")));
		
		String searchType = String.valueOf(params.get("searchType"));
		
		String searchText = String.valueOf(params.get("searchText"));
		
		String memProcess = String.valueOf(params.get("memProcess"));
		Object storedValue;
		
		if (memProcess.equals("default")) {
		    storedValue = memProcess; // "default"를 문자열로 저장합니다.
		} else {
		    storedValue = memProcess.equals("true") ? 1 : 0; // "true"일 때는 1로, "false"일 때는 0으로 저장합니다.
		}
		
		logger.info("storedValue :"+storedValue);
		
		logger.info("page :"+page+"/"+"ctn :"+cnt+"/"+"searchType :"+searchType+"/"+"searchText :"+searchText);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int offset = cnt * (page-1);
	      
	    logger.info("offset : " + offset);
	    
	    int total = 0; 
	    
	    if (searchType.equals("default")) {
	        if (memProcess.equals("default")) {
	            // 전체 리스트를 불러옴
	            total = memdao.memTotalCount(params);
	            logger.info("회원 전체 리스트 / memTotalCount");
	        } else {
	        	total = memdao.memTotalCountByProcess(params, storedValue);
	            logger.info("회원 전체 리스트 Boolean / memTotalCountByProcess");
	        }
	    } else if (searchType.equals("userID")) {
	        if (!searchText.isEmpty()) {
	            // 해당 userID를 포함하는 리스트를 불러옴
	            if (memProcess.equals("default")) {
	            	total = memdao.memIDTotalCount(params, searchType, searchText);
	                logger.info("회원 ID 리스트 / memIDTotalCount");
	            } else {
	            	total = memdao.memIDTotalCountByProcess(params, searchType, searchText, storedValue);
	                logger.info("회원 ID 리스트 Boolean / memIDTotalCountByProcess");
	            }
	        }
	    } else if (searchType.equals("userName")) {
	        if (!searchText.isEmpty()) {
	            // 해당 userName을 포함하는 리스트를 불러옴
	            if (memProcess.equals("default")) {
	            	total = memdao.memNameTotalCount(params, searchType, searchText);
	                logger.info("회원 이름 리스트 / memNameTotalCount");
	            } else {
	            	total = memdao.memNameTotalCountByProcess(params, searchType, searchText, storedValue);
	                logger.info("회원 이름 리스트 Boolean / memNameTotalCountByProcess");
	            }
	        }
	    }

	    
	    int range = total%cnt  == 0 ? total/cnt : (total/cnt)+1;
	      
	    logger.info("총게시글 수 : "+ total);
	    logger.info("총 페이지 수 : "+ range);
	    
	    page = page>range ? range:page;
	    
	    map.put("currPage", page);
	    map.put("pages", range);
	    params.put("offset", offset);
	    
	    ArrayList<InquiryDTO> memlist = null;
	    
		/*
		 * if (searchType.equals("default")) { if (memProcess.equals("default")) { // 전체
		 * 리스트를 불러옴 memlist = memdao.memTotalList(params,cnt,offset);
		 * logger.info("회원 전체 리스트 / memTotalCount"); } else { memlist =
		 * memdao.memTotalListByProcess(params,storedValue,cnt,offset);
		 * logger.info("회원 전체 리스트 Boolean / memTotalListByProcess"); } } else if
		 * (searchType.equals("userID")) { if (!searchText.isEmpty()) { // 해당 userID를
		 * 포함하는 리스트를 불러옴 memlist =
		 * memdao.memIDTotalList(params,searchType,searchText,cnt,offset);
		 * logger.info("회원 ID 리스트 / memIDTotalList"); } } else if
		 * (searchType.equals("userName")) { if (!searchText.isEmpty()) { // 해당
		 * userName을 포함하는 리스트를 불러옴 memlist =
		 * memdao.memNameTotalList(params,searchType,searchText,cnt,offset);
		 * logger.info("회원 이름 리스트 / memNameTotalList"); } }
		 */
	    
	    if (searchType.equals("default")) {
	        if (memProcess.equals("default")) {
	            // 전체 리스트를 불러옴
	            memlist = memdao.memTotalList(params, cnt, offset);
	            logger.info("회원 전체 리스트 / memTotalList");
	        } else {
	            memlist = memdao.memTotalListByProcess(params, storedValue, cnt, offset);
	            logger.info("회원 전체 리스트 Boolean / memTotalListByProcess");
	        }
	    } else if (searchType.equals("userID")) {
	        if (!searchText.isEmpty()) {
	            // 해당 userID를 포함하는 리스트를 불러옴
	            if (memProcess.equals("default")) {
	                memlist = memdao.memIDTotalList(params, searchType, searchText, cnt, offset);
	                logger.info("회원 ID 리스트 / memIDTotalList");
	            } else {
	                memlist = memdao.memIDTotalListByProcess(params, searchType, searchText, storedValue, cnt, offset);
	                logger.info("회원 ID 리스트 Boolean / memIDTotalListByProcess");
	            }
	        }
	    } else if (searchType.equals("userName")) {
	        if (!searchText.isEmpty()) {
	            // 해당 userName을 포함하는 리스트를 불러옴
	            if (memProcess.equals("default")) {
	                memlist = memdao.memNameTotalList(params, searchType, searchText, cnt, offset);
	                logger.info("회원 이름 리스트 / memNameTotalList");
	            } else {
	                memlist = memdao.memNameTotalListByProcess(params, searchType, searchText, storedValue, cnt, offset);
	                logger.info("회원 이름 리스트 Boolean / memNameTotalListByProcess");
	            }
	        }
	    }

	    
	    map.put("memlist", memlist);
	    logger.info("memlist :"+memlist);
	    
		return map; 
	}

	public MemManageDTO memdetail(String userID) {
		logger.info("MemManage Detail Service");
		
		return memdao.memdetail(userID);
	}

	public String memprocessupdate(Boolean selectedValue, String userID) {
		logger.info("Inquiry Process Update Service");	
	    logger.info("selectedValue :"+selectedValue+"/"+"userID :"+userID);
	    
		int row = memdao.memprocessupdate(selectedValue,userID);
		
		logger.info("update row :"+row);
		
		return "redirect:/memMangeDetail.go?userID="+userID;	
	}

}
