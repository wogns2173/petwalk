package com.pet.walkroute.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pet.walkroute.dao.WalkRouteDAO;
import com.pet.walkroute.dto.RouteListDTO;
import com.pet.walkroute.dto.WalkRouteDTO;
import com.pet.walkroute.dto.WalkRouteVO;

@Service
public class WalkRouteService {
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired WalkRouteDAO dao;
	
	public ArrayList<WalkRouteDTO> dong() {
		return dao.dong();
	}

	public ArrayList<String> insert(ArrayList<String> list) {
		for(String latlng : list) {
			String[] asd = latlng.split("/");
			logger.info("lng : " + asd[0] + "/" + "lat : " + asd[1]);
		}
		return null;
	}

	public String routeStore(WalkRouteVO vo) {
		RouteListDTO dto = new RouteListDTO();
		dto.setWalkName(vo.getSubject());
		dto.setWalkDetail(vo.getContent());
		
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
}
