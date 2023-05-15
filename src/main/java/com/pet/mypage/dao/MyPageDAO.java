package com.pet.mypage.dao;


import java.util.ArrayList;
import java.util.HashMap;

import com.pet.admin.dto.InquiryDTO;
import com.pet.board.dto.BoardDTO;
import com.pet.mypage.dto.MyPageDTO;

public interface MyPageDAO {

	int profileWrite(String userID, String petSize, String petName, int petAge, String petGender, int petNeutered,
			String petIntroduce);

	MyPageDTO findprofile(String userID);
	
	MyPageDTO findprofileAndphoto(String userID, String string, int profileID);

	int petprofileUpdate(String userID, String petSize, String petName, int petAge, String petGender, int petNeutered,
			String petIntroduce);

	int totalCount(String userID);

	ArrayList<BoardDTO> myroutlistCalllist(int cnt, int offset, String userID);
	
	int mybookmarktotalCount(String userID);

	ArrayList<BoardDTO> mybookmarklistCall(int cnt, int offset, String userID);

	int myinquirytotalCount(String userID);

	ArrayList<BoardDTO> myinquirylistCall(int cnt, int offset, String userID);

	int myreporttotalCount(String userID);

	ArrayList<BoardDTO> myreportlistCall(int cnt, int offset, String userID);

	ArrayList<MyPageDTO> myinquiryList(String userID);

	ArrayList<MyPageDTO> findrouteShareList(String userID);

	int metotalCount(HashMap<String, Object> params, String categoryCode, Object storedValue, String userID);

	int metotalCountprocess(HashMap<String, Object> params, Object storedValue, String categoryCode, String userID);

	int metotalCountinquiry(HashMap<String, Object> params, String categoryCode, String userID);

	int metotalCountAll(HashMap<String, Object> params, String categoryCode, Object storedValue, String userID);

	ArrayList<InquiryDTO> meinquirylist(HashMap<String, Object> map, int cnt, int offset, String categoryCode,
			Object storedValue, String userID);

	ArrayList<InquiryDTO> melistinquiry(HashMap<String, Object> params, String categoryCode, int cnt, int offset,
			String userID);

	ArrayList<InquiryDTO> melistinqAll(HashMap<String, Object> params, String categoryCode, Object storedValue, int cnt,
			int offset, String userID);

	ArrayList<InquiryDTO> melistinqprocess(HashMap<String, Object> params, Object storedValue, int cnt, int offset,
			String categoryCode, String userID);

	

	

	

	

	

	

	
	
	
	



	

	

}
