package com.pet.admin.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pet.admin.dao.ReportDAO;
import com.pet.admin.dto.InquiryDTO;

@Service
public class ReportService {

	@Autowired ReportDAO repdao;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public HashMap<String, Object> replist(HashMap<String, Object> params) {
		
			logger.info("params :"+params);
	      
	      int page = Integer.parseInt(String.valueOf(params.get("page")));
	      String categoryCode = String.valueOf(params.get("categoryCode"));
	      Boolean process = Boolean.valueOf(String.valueOf(params.get("process")));
	      int cnt = Integer.parseInt(String.valueOf(params.get("cnt")));
	      String search = String.valueOf(params.get("search"));
	      
	      logger.info("categoryCode :"+categoryCode+"/"+"process :"+process);
	      logger.info(page + "를 선택된 문의 방식이" +categoryCode+"때만 보여줘");
	      logger.info("한페이지에 " + cnt +"개씩 보여줄 것 ");
	      logger.info("searchText :"+search);
	      
	      HashMap<String, Object> map = new HashMap<String, Object>();
	      
	      // 1페이지  offset 0
	      // 2페이지 offset 5
	      // 3 페이지 offset 10
	      int offset = cnt * (page-1);
	      
	      logger.info("offset : " + offset);
	      
	      // 만들 수 있는 총 페이지 수 : 전체 게시글의 수 / 페이지당 보여줄 수 있는 수
	      int total = 0;
	      
	     if(search.equals("default")){
	         if(categoryCode.equals("default") && process.equals(Boolean.valueOf("default"))) {
	         // 전체 보여주기
	         total = repdao.reptotalCount(params);
	         logger.info("totalCount");
	        
	         }else if(!(categoryCode.equals("default")) && process.equals(Boolean.valueOf("default"))){
	        	 params.put("categoryCode", categoryCode);
			     logger.info("params :"+params);
	            // 신고 필터링만 선택 된 경우 
	            total = repdao.reptotalCountcategory(params,categoryCode);
	            logger.info("totalCountinquiry");           
	         }else if(categoryCode.equals("default") && !process.equals(Boolean.valueOf("default"))){
	            // 처리 여부 필터링만 선택 된 경우
	            total = repdao.reptotalCountprocess(params,process);
	            logger.info("totalCountprocess");
	         }else{
	            // 문의,처리 필터링이 선택 된 경우 
	            total = repdao.reptotalCountAll(params,categoryCode,process);
	            logger.info("totalCountAll");
	         }
	     }else{
		        	// 검색 기능
		        total = repdao.reptotalSearch(params,search);
		        logger.info("reptotalSearch");
		 }
	    
	      
	      int range = total%cnt  == 0 ? total/cnt : (total/cnt)+1;
	      
	      logger.info("총게시글 수 : "+ total);
	      logger.info("총 페이지 수 : "+ range);
	      
	      page = page>range ? range:page;
	      
	      map.put("currPage", page);
	      map.put("pages", range);
	      
	      ArrayList<InquiryDTO> replist = null;
	      
	      
	      params.put("offset", offset);
	      
	      
	      logger.info("params : " + params);
	      
	      if(search.equals("default")){
		         if(categoryCode.equals("default") && process.equals(Boolean.valueOf("default"))) {
		         // 전체 보여주기
		        	 replist = repdao.reportlist(params,cnt,offset);
			         logger.info("inquirylist");
		         }else if(!(categoryCode.equals("default")) && process.equals(Boolean.valueOf("default"))){
		        	// 문의 필터링만 선택 된 경우 
		        	 replist = repdao.reportcategorycode(params,categoryCode,cnt,offset);
			         logger.info("listinquiry");         
		         }else if(categoryCode.equals("default") && !process.equals(Boolean.valueOf("default"))){
		            // 처리 여부 필터링만 선택 된 경우
		        	 replist = repdao.reportprocess(params,process,cnt,offset);
			         logger.info("listprocess");
		         }else{
		            // 문의,처리 필터링이 선택 된 경우 
		        	 replist = repdao.reportlistAll(params,categoryCode,process,cnt,offset);
			         logger.info(".listAll");
		         }
		
			  }else {
			    	// 검색 기능
		        	 replist = repdao.reportsearch(params,search,cnt,offset);
		        	 logger.info("listsearchText");
		      }
		      map.put("replist", replist);
		      logger.info("replist :"+replist);
		      return map;
	      
	}
}


		
	
