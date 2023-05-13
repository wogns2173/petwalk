package com.pet.walkroute.service;

import java.util.ArrayList;
import java.util.HashMap;

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
			params.put("walkRouteType", "공유");
		}
		else {
			params.put("walkRouteType", "추천");
		}
		
		return dao.write(params);
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

	public HashMap<String, Object> list(int page, int cnt) {
		logger.info(page+" 페이지 보여줘");
		logger.info("한 페이지에 "+cnt+" 개씩 보여줄거야");
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
				
		ArrayList<RouteShareDTO> list = dao.list(cnt, offset);
		map.put("list", list);
		return map;
	}


	public RouteShareDTO detail(int walkRouteNum) {
		return dao.detail(walkRouteNum);
	}


	public int bookmark(String walkNum, String userID) {
		
		return dao.bookmark(walkNum,userID);
		
	}


	
}
