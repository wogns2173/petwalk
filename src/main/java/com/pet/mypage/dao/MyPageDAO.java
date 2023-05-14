package com.pet.mypage.dao;


import java.util.ArrayList;

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

	

	

	

	

	
	
	
	



	

	

}
