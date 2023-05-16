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

import com.pet.admin.dao.ReportDAO;
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
		
		return repdao.repreplist2(reportNum);
	}

	public int reportreplywrite(int reportNum, String reportProcess, String userID) {
		logger.info("Report Reply Write Service Call");
		logger.info("userID :"+userID);
		
		return repdao.reprepwrite(reportNum,reportProcess, userID);
	}

	public int reprepdel(int repReplyNum) {
		
		logger.info("Report Reply Delete Service Call");
		return repdao.reprepdelte(repReplyNum);
	}

	public ArrayList<ReportDTO> repreplist2(int reportNum) {
		
		return repdao.repreplist2(reportNum);
	}

	public ReportDTO repreplist(int reportNum, int repReplyNum, String reportProcess) {
		logger.info("Report Reply List Service");
		return repdao.repreplist(reportNum, repReplyNum, reportProcess);
	}


	public String reprepupdate(HashMap<String, String> params) {
		logger.info("Report Reply Update");
		logger.info("params :"+params);
		
		int row = repdao.reprepupdate(params);
		
		logger.info("update row :"+row);
		
		return "redirect:/reportdetail.do?reportNum=" + params.get("reportNum"); 
	}

	public String repWrite(MultipartFile photo, HashMap<String, String> params, String userID, int boardNum) {
		
		String page = "redirect:/boardDetail.do?boardNum="+boardNum;

		//1. 게시글만 작성
		ReportDTO repdto = new ReportDTO();
		logger.info("userID :"+userID);
		
		repdto.setCategoryCode(params.get("categoryCode"));
		repdto.setReportName(params.get("reportName"));
		repdto.setReportDetail(params.get("reportDetail"));
		repdto.setUserID(userID);
		
		logger.info(repdto.getReportDetail() + "/" + repdto.getCategoryCode() + "/" + repdto.getReportName());
		int row = repdao.reportWrite(repdto);
		logger.info("writeupdate row:"+row);
		int reportNum = repdto.getReportNum();
		String categoryCode = repdto.getCategoryCode();
		logger.info("categoryCode: "+categoryCode+"/"+"reportNum :"+reportNum);
				
	
		//첨부파일 같이 업로드 
		if(!photo.getOriginalFilename().equals("")) {
			logger.info("파일 업로드 작업");
			fileSave(categoryCode,photo,reportNum);
		}
		return page;
	}

	private void fileSave(String categoryCode, MultipartFile photo, int reportNum) {
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
			repdao.fileWrite(categoryCode, oriPhotoname, serPhotoname, reportNum);
			logger.info("사진 저장 완료");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public String processupdate(int processValue, int reportNum) {
		logger.info("Report Process Update Service");	
	    logger.info("processValue :"+processValue+"/"+"reportNum :"+reportNum);
	    
		int row = repdao.repprocessupdate(processValue,reportNum);
		
		logger.info("update row :"+row);
		
		return "redirect:/reportdetail.do?reportNum="+reportNum;	
	}
}
	
	

		

	
