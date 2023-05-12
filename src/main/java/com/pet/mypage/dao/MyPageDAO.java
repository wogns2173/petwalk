package com.pet.mypage.dao;


import java.util.ArrayList;

import com.pet.mypage.dto.MyPageDTO;

public interface MyPageDAO {

	int profileWrite(String userID, String petSize, String petName, int petAge, String petGender, int petNeutered,
			String petIntroduce);

	MyPageDTO findprofile(String userID);
	
	MyPageDTO findprofileAndphoto(String userID, String string, int profileID);

	int petprofileUpdate(String userID, String petSize, String petName, int petAge, String petGender, int petNeutered,
			String petIntroduce);

	ArrayList<MyPageDTO> findrouteDrawList(String userID);

	ArrayList<MyPageDTO> myinquiryList(String userID);

	ArrayList<MyPageDTO> findrouteShareList(String userID);

	

	
	
	
	



	

	

}
