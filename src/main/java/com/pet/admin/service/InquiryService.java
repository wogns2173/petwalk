package com.pet.admin.service;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pet.admin.dao.InquiryDAO;
import com.pet.admin.dto.InquiryDTO;

@Service
public class InquiryService {

	@Autowired InquiryDAO inqdao;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());

	

	public ArrayList<InquiryDTO> inqlist() {
		logger.info("Inquiry list service");
		return inqdao.inqlist();
	}

	public InquiryDTO inqdetail(int boardNum, String flag) {
		logger.info("Inquiry detail service");
		if(flag.equals("inqdetail")) {
			inqdao.upHit(boardNum); // 조회주 증가
		}
		return inqdao.inqdetail(boardNum);
	
	}



}
