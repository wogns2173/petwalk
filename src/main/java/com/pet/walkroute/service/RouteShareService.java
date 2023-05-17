package com.pet.walkroute.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pet.walkroute.dao.RouteShareDAO;
import com.pet.walkroute.dto.RouteShareDTO;


@Service
public class RouteShareService {
	
	@Autowired RouteShareDAO dao;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	

	public int write(String userID, HashMap<String, Object> params) {
		if(dao.isAdmin(String.valueOf(params.get("userID"))).equals("user")) {
			params.put("walkRouteType", "share");
		}
		else {
			params.put("walkRouteType", "recommend");
		}
		
		int row = 0;
		if(String.valueOf(params.get("flag")).equals("insert")) {
			row = dao.write(params);
		}
		else {
			row = dao.update(params);
		}
		return row;
	}


	public HashMap<String, String> sigudong(HashMap<String, Object> params) {
		HashMap<String, String> sigudong = new HashMap<String, String>();
		String siName = String.valueOf(params.get("siGuDong[siName]")); 
		String guName = String.valueOf(params.get("siGuDong[guName]"));
		String dongName = String.valueOf(params.get("siGuDong[dongName]"));
		
		sigudong.put("siID", dao.siID(siName));
		sigudong.put("guID", dao.guID(guName));
		sigudong.put("dongID", dao.dongID(dongName));
		
		return sigudong;
	}

	public HashMap<String, Object> list(int page, int cnt, String walkRouteType) {
		logger.info(page+" 페이지 보여줘");
		logger.info("한 페이지에 "+cnt+" 개씩 보여줄거야");
		logger.info("walkRouteType : " + walkRouteType);
		HashMap<String, Object> map = new HashMap<String, Object>();		

		// 1page = offset : 0
		// 2page = offset : 5
		// 3page = offset : 10
		int offset = (page-1)*cnt;
		
		// 만들 수 있는 총 페이지 수 
		// 전체 게시물 / 페이지당 보여줄 수
		int total = dao.totalCount();
		int range = total%cnt == 0 ? total/cnt : (total/cnt)+1;
		logger.info("전체 게시물 수 : "+total);
		logger.info("총 페이지 수 : "+range);
		
		page = page > range ? range : page;
		
		map.put("currPage", page);
		map.put("pages", range);
		//map.put("walkRouteType", walkRouteType);
				
		ArrayList<RouteShareDTO> list = dao.list(walkRouteType ,cnt, offset);
		map.put("list", list);
		return map;
	}


	public RouteShareDTO detail(int walkRouteNum) {
		return dao.detail(walkRouteNum);
	}


	public String recommend(String walkRouteNum, String userID) {
		String msg = "추천 취소";
		if(dao.isRecommend(walkRouteNum) == null) {
			dao.recommendDo(walkRouteNum, userID);
			msg = "추천 성공!";
		}
		else {
			dao.recommendCancel(walkRouteNum, userID);
		}
		return msg;
	}


	public String bookmark(String walkNum, String userID) {
		String msg = "즐겨찾기 실패";
		
		 String ID = dao.isBookmark(walkNum,userID); 
		
		if(ID == null) {			
			dao.bookmarkDo(walkNum, userID);
			msg = "즐겨찾기 성공";
		}
		else {
			dao.bookmarkCancel(walkNum, userID);
			msg = "즐겨찾기 취소";
		}
		return msg;
	}


	public String delete(String walkRouteNum) {
		dao.delete(walkRouteNum);
		return "삭제 완료 ㅎ";
	}


	public HashMap<String, Object> addressFilter(HashMap<String, Object> params) {
		HashMap<String, Object> map = new HashMap<String, Object>();		
		int page = Integer.parseInt(String.valueOf(params.get("page")));
		int cnt = Integer.parseInt(String.valueOf(params.get("cnt")));
		int offset = (page-1)*cnt;
		params.remove("cnt");
		params.put("cnt", cnt);
		params.put("offset", Integer.parseInt(String.valueOf(offset)));
		params.put("siID", String.valueOf(params.get("list[siName]")));
		params.put("guID", String.valueOf(params.get("list[guName]")));
		params.put("dongID", String.valueOf(params.get("list[dongName]")));
		logger.info("siID : " + params.get("siId") + " / guID : " + params.get("guId") + "/ dongId : " + params.get("dongId"));
		int total = dao.addressFiterCount(params);
		int range = total%cnt == 0 ? total/cnt : (total/cnt)+1;
		logger.info("전체 게시물 수 : "+total);
		logger.info("총 페이지 수 : "+range);
		
		page = page > range ? range : page;
		
		map.put("currPage", page);
		map.put("pages", range);
				
		ArrayList<RouteShareDTO> list = dao.addressFilterlist(params);
		map.put("list", list);
		return map;
	}


	public HashMap<String, Object> subjectOrIdFilter(HashMap<String, Object> params) {
		HashMap<String, Object> map = new HashMap<String, Object>();		
		int page = Integer.parseInt(String.valueOf(params.get("page")));
		int cnt = Integer.parseInt(String.valueOf(params.get("cnt")));
		int offset = (page-1)*cnt;
		params.remove("cnt");
		params.put("cnt", cnt);
		params.put("offset", Integer.parseInt(String.valueOf(offset)));
		
		int total = 0;
		int range = 0;
		ArrayList<RouteShareDTO> list = null;
		if(String.valueOf(params.get("list[isID]")).equals("아이디")) {
			logger.info("아이디 호출");
			params.put("userID", params.get("list[input]"));
			total = dao.idFiterCount(params);
			range = total%cnt == 0 ? total/cnt : (total/cnt)+1;
			list = dao.idFilterlist(params);
		} else {
			logger.info("제목 호출");
			params.put("walkRouteName", params.get("list[input]"));
			total = dao.subjectFiterCount(params);
			range = total%cnt == 0 ? total/cnt : (total/cnt)+1;
			list = dao.subjectFilterlist(params);
		}
		
		page = page > range ? range : page;
		
		logger.info("전체 게시물 수 : "+total);
		logger.info("총 페이지 수 : "+range);
		
		map.put("currPage", page);
		map.put("pages", range);
		map.put("list", list);
		
		return map;
	}


	


	
}
