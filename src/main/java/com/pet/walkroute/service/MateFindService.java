package com.pet.walkroute.service;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pet.walkroute.dao.MateFindDAO;
import com.pet.walkroute.dto.MateFindDTO;

@Service
public class MateFindService {
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MateFindDAO dao;
	
	public ArrayList<MateFindDTO> dong() {
		// TODO Auto-generated method stub
		return dao.dong();
	}

	public ArrayList<MateFindDTO> mateList(String dong) {
		return dao.mateList(dong);
	}

	public ArrayList<MateFindDTO> siList() {
		return dao.siList();
	}

	public ArrayList<MateFindDTO> guList(String siID) {
		return dao.guList(siID);
	}

	public ArrayList<MateFindDTO> dongList(String guID) {
		return dao.dongList(guID);
	}

}
