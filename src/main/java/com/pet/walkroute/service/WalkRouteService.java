package com.pet.walkroute.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pet.walkroute.dao.WalkRouteDAO;
import com.pet.walkroute.dto.RouteListDTO;
import com.pet.walkroute.dto.DongInfoDTO;
import com.pet.walkroute.dto.WalkRouteVO;

@Service
public class WalkRouteService {
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired WalkRouteDAO dao;
	
	public ArrayList<DongInfoDTO> dong() {
		return dao.dong();
	}

	public String routeStore(WalkRouteVO vo, String id) {
		RouteListDTO dto = new RouteListDTO();
		dto.setWalkName(vo.getSubject());
		dto.setWalkDetail(vo.getContent());
		dto.setUserID(id);
		dao.routeListStore(dto);
		int walkNum = dto.getWalkNum();
		logger.info("walkNum : " + walkNum);
		
		double[] latArray = vo.getLatArray();
		double[] lngArray = vo.getLngArray();
		HashMap<String, Object> map = new HashMap<String, Object>();
		for(int i=0; i < latArray.length; i++) {
			map.put("walkNum", walkNum);
			map.put("mapOrder", i+1);
			map.put("lat", latArray[i]);
			map.put("lng", lngArray[i]);
			
			dao.coordinateStore(map);
			
			map.clear();
		}
		return "성공";
	}

	public ArrayList<RouteListDTO> routeList(int mineOrBookmark, String id) {
		ArrayList<RouteListDTO> list = null;
		if(mineOrBookmark == 1) {
			list = dao.routeList(id);
		}else {
			
		}
		return list;
	}
	
	public ArrayList<RouteListDTO> routeList(String id) {
		ArrayList<RouteListDTO> list = dao.routeList(id);
		return list;
	}

	public ArrayList<RouteListDTO> routeBring(String walkNum) {
		ArrayList<RouteListDTO> list = dao.coordinateBring(walkNum);
		for(int i=0; i<list.size(); i++) {
			logger.info("lat : " + list.get(i).getLat());
		}
		logger.info("list size() : " + list.size());
		return list;
	}
}
