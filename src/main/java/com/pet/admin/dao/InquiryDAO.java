package com.pet.admin.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.pet.admin.dto.InquiryDTO;

public interface InquiryDAO {

	/* ArrayList<InquiryDTO> inqlist(); */

	InquiryDTO inqdetail(int boardNum);

	void upHit(int boardNum);

	InquiryDTO inqreplist(int boardNum, int replyNum, String commentDetail);

	int inqrepwrite(int boardNum, String content, String userID);

	int inqrepdel(int replyNum);

	int inqrepupdate(HashMap<String, String> params);

	ArrayList<InquiryDTO> inqreplist2(int boardNum);

	int boardWrite(InquiryDTO inqdto);

	void fileWrite(String categoryCode, String oriPhotoname, String serPhotoname, int boardNum);

	int totalCount(HashMap<String, Object> params , String categoryCode, Object storedValue);

	int totalCountinquiry(HashMap<String, Object> params, String categoryCode);

	int totalCountprocess(HashMap<String, Object> params, Object storedValue, String categoryCode);

	int totalCountAll(HashMap<String, Object> params, String categoryCode, Object storedValue);

	/* ArrayList<InquiryDTO> inquirylist(int offset, String categoryCode); */

	ArrayList<InquiryDTO> listinqprocess(HashMap<String, Object> params, Object storedValue, int cnt, int offset, String categoryCode);

	ArrayList<InquiryDTO> listinqAll(HashMap<String, Object> params, String categoryCode, Object storedValue, int cnt, int offset);

	ArrayList<InquiryDTO> listinquiry(HashMap<String, Object> params, String categoryCode, int cnt, int offset);

	ArrayList<InquiryDTO> inquirylist(HashMap<String, Object> params, int cnt, int offset, String categoryCode, Object storedValue);

	int inqprocessupdate(Boolean selectedValue, int boardNum);


		
	
		
	
		
	
		
	}
	



	

	


