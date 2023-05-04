package com.pet.admin.service;

import java.util.ArrayList;
import java.util.HashMap;

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
			inqdao.upHit(boardNum); // 조회수 증가
		}
		return inqdao.inqdetail(boardNum);
	
	}

	public InquiryDTO inqreplist(int boardNum, int replyNum) {
		logger.info("Inquiry Reply List Service");
		return inqdao.inqreplist(boardNum, replyNum);
	}

	public int inqreplywrite(int boardNum, String content) {
		logger.info("Inquiry Reply Write Service");

		return inqdao.inqrepwrite(boardNum, content);
	}

	public int inqrepdel(int replyNum) {
		logger.info("Inquiry Reply Delete Service");
		
		return inqdao.inqrepdel(replyNum);
	}

	public String update(HashMap<String, String> params) {
		logger.info("Inquiry Reply Update Service");
		logger.info("params :"+ params);
		
		int row = inqdao.inqrepupdate(params);
		
		logger.info("update row :"+row);
		
		return "redirect:/inquirydetail.do?boardNum="+params.get("boardNum");	
		
	}

	public ArrayList<InquiryDTO> inqreplist2(int boardNum) {
		return inqdao.inqreplist2(boardNum);
	}
}







