package com.pet.walkroute.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pet.walkroute.dao.RouteShareDAO;


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
	
}
