package com.pet.admin.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.pet.admin.dto.InquiryDTO;
import com.pet.board.dto.BoardDTO;

public interface InquiryDAO {

	/* ArrayList<InquiryDTO> inqlist(); */

	InquiryDTO inqdetail(int boardNum);

	void upHit(int boardNum);

	InquiryDTO inqreplist(int boardNum, int replyNum, String commentDetail);

	int inqrepwrite(int boardNum, String content);

	int inqrepdel(int replyNum);

	int inqrepupdate(HashMap<String, String> params);

	ArrayList<InquiryDTO> inqreplist2(int boardNum);

	int boardWrite(InquiryDTO inqdto);

	void fileWrite(String categoryCode, String oriPhotoname, String serPhotoname, int boardNum);

	int totalCount(HashMap<String, Object> params);

	int totalCountinquiry(HashMap<String, Object> params, String categoryCode);

	int totalCountprocess(HashMap<String, Object> params, Boolean process);

	int totalCountAll(HashMap<String, Object> params, String categoryCode, Boolean process);

	/* ArrayList<InquiryDTO> inquirylist(int offset, String categoryCode); */

	ArrayList<InquiryDTO> listinqprocess(HashMap<String, Object> params, Boolean process, int cnt, int offset);

	ArrayList<InquiryDTO> listinqAll(HashMap<String, Object> params, String categoryCode, Boolean process, int cnt, int offset);

	ArrayList<InquiryDTO> listinquiry(HashMap<String, Object> params, String categoryCode, int cnt, int offset);

	ArrayList<InquiryDTO> inquirylist(HashMap<String, Object> params, int cnt, int offset);

	int inqprocessupdate(Boolean selectedValue, int boardNum);


		
	
		
	
		
	
		
	}
	



	

	


