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


	public ArrayList<RouteShareDTO> list() {
		return dao.list();
	}
	
}
