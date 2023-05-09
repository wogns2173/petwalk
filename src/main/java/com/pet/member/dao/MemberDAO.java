package com.pet.member.dao;


import java.util.HashMap;

import com.pet.member.dto.MemberDTO;

public interface MemberDAO {

	int overlayid(String userID);
	
	int overlaypw(String encodedPassword);


	int join(HashMap<String, String> params);

	MemberDTO login(String userID);

	int memberdelete(Object attribute);		

	MemberDTO myinformation(Object attribute);

	MemberDTO findmemberid(String userName, String userEmail);

	int findmemberpw(String userName, String userID, String userEmail);
	
	void RandomPassword(String userName, String userID, String userEmail, String encodedPassword);

	MemberDTO findloginpw(String userID);

	MemberDTO chkpw(Object attribute);

	Object overlaynickname(Object attribute);

	MemberDTO changememberpw(Object attribute);

	int changememberpwtrue(Object object, String encodedPassword);

	int updateusername(String usernickname, String username);
	
	int updateusernickname(String nownickname, String userNickname);

	int updateuseremail(String usernickname, String useremail);

	int updateuserContact(String usernickname, String usereContact);

	int updateuserAge(String usernickname, String userAge);

	int updateuserBirthdate(String usernickname, String userBirthdate);

	int updateuseraddress(String usernickname, String siID, String guID, String dongID);

	int updateuserGender(String usernickname, String userGender);

	MemberDTO sessionupdatenickname(String userNickname);

	

	

	



	

}