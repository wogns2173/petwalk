package com.pet.admin.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pet.admin.dao.ReportDAO;
import com.pet.admin.dto.InquiryDTO;
import com.pet.admin.dto.ReportDTO;

@Service
public class ReportService {

	@Autowired ReportDAO repdao;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public HashMap<String, Object> replist(HashMap<String, Object> params) {
		
		  logger.info("params :"+params);
	      
	      int page = Integer.parseInt(String.valueOf(params.get("page")));
	      
	      int cnt = Integer.parseInt(String.valueOf(params.get("cnt")));
	      
	      String categoryCode = String.valueOf(params.get("categoryCode"));
	      	      
	      String searchType = String.valueOf(params.get("searchType"));
			
	      String searchText = String.valueOf(params.get("searchText"));
	      
	      String repProcess = String.valueOf(params.get("repProcess"));
	      Object storedValue;

	      if (repProcess.equals("default")) {
			    storedValue = repProcess; // "default"를 문자열로 저장합니다.
			} else {
			    storedValue = repProcess.equals("true") ? 1 : 0; // "true"일 때는 1로, "false"일 때는 0으로 저장합니다.
			}
	      
	      logger.info("storedValue :"+storedValue);
	      
	      logger.info("page :"+page+"/"+"ctn :"+cnt+"/"+"searchType :"+searchType+"/"+"searchText :"+searchText);
	      
	      HashMap<String, Object> map = new HashMap<String, Object>();
	      
	      int offset = cnt * (page-1);
	      
	      logger.info("offset : " + offset);
	      
	      // 만들 수 있는 총 페이지 수 : 전체 게시글의 수 / 페이지당 보여줄 수 있는 수
	      int total = 0;
	      
	      if (categoryCode.equals("default")) {
	    	    if (repProcess.equals("default")) {
	    	    	total = repdao.repTotalCountList(map, cnt, offset, categoryCode,storedValue);
	    	        logger.info("전체 신고 리스트 / repTotalCountList");
	    	    } else {
	    	    	total = repdao.repTotalCountListByProcess(params, storedValue, cnt, offset,categoryCode);
	    	        logger.info("처리 여부 리스트 / repTotalCountListByProcess" + storedValue);
	    	    }
	    	} else {
	    	    if (repProcess.equals("default")) {
	    	    	total = repdao.repTotalCategoryCountCode(params, categoryCode, cnt, offset);
	    	        logger.info("선택한 신고 리스트 / repTotalCategoryCountCodeList" + categoryCode);
	    	    } else {
	    	    	total = repdao.repTotalCategoryAll(params, categoryCode, storedValue, cnt, offset);
	    	        logger.info("선택한 신고, 처리여부 리스트 / repTotalCategoryAll" + categoryCode + storedValue);
	    	    }
	    	}
	    	
	    
      
	      int range = total%cnt  == 0 ? total/cnt : (total/cnt)+1;
	      
	      logger.info("총게시글 수 : "+ total);
	      logger.info("총 페이지 수 : "+ range);
	      
	      page = page>range ? range:page;
	      
	      map.put("currPage", page);
	      map.put("pages", range);
	      params.put("offset", offset);
	      
	      ArrayList<ReportDTO> replist = null;
	      
	      if (categoryCode.equals("default")) {
	    	    if (repProcess.equals("default")) {
	    	    	replist = repdao.repList(map, cnt, offset, categoryCode,storedValue);
	    	        logger.info("전체 신고 리스트 / repList");
	    	    } else {
	    	    	replist = repdao.repListByProcess(params, storedValue, cnt, offset,categoryCode);
	    	        logger.info("처리 여부 리스트 / repListByProcess" + storedValue);
	    	    }
	    	} else {
	    	    if (repProcess.equals("default")) {
	    	    	replist = repdao.repCategoryCodeList(params, categoryCode, cnt, offset);
	    	        logger.info("선택한 신고 리스트 / repCategoryCodeList" + categoryCode);
	    	    } else {
	    	    	replist = repdao.repAllList(params, categoryCode, storedValue, cnt, offset);
	    	        logger.info("선택한 신고, 처리여부 리스트 / repAllList" + categoryCode + storedValue);
	    	    }
	    	}
	    
	      logger.info("params : " + params);
	      
	      map.put("replist", replist);
	      logger.info("replist :"+replist);
	      return map;
	    	}

	public ReportDTO repdetail(int reportNum, String string) {

		logger.info("repdetail service call");
		
		return repdao.repDetail(reportNum);
	}

	public ArrayList<ReportDTO> inqreplist2(int reportNum) {
		
		return repdao.inqreplist2(reportNum);
	}
	}
	
	

		

	
