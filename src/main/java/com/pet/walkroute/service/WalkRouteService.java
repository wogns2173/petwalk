package com.pet.walkroute.service;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pet.walkroute.dao.WalkRouteDAO;
import com.pet.walkroute.dto.WalkRouteDTO;

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
}
