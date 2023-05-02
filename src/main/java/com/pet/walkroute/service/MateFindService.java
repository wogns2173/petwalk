package com.pet.walkroute.service;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pet.walkroute.dao.MateFindDAO;

@Service
public class MateFindService {
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MateFindDAO dao;
	
	public ArrayList<MateFindDAO> dong() {
		// TODO Auto-generated method stub
		return dao.dong();
	}

}
