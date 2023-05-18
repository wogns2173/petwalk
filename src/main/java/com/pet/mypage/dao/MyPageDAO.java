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

	int myreviewtotalCount(String userID);

	ArrayList<BoardDTO> myreviewlistCall(int cnt, int offset, String userID);

	int otroutesharetotalCount(String userID);
	
	ArrayList<BoardDTO> otroutesharelistCall(int cnt, int offset, String userID);

	int otreviewtotalCount(String userID);

	ArrayList<BoardDTO> otreviewlistCall(int cnt, int offset, String userID);

	int deletemr(String id);

	int deletemr(String walkNum, String userID);
	
	int application(String mateWalkNum, String userID);

	int cancel(String mateWalkNum, String userID);

	ArrayList<BoardDTO> applicantlist(String mateWalkNum);

	

	

	

	

	

	

	

	

	

	

	
	
	
	



	

	

}
