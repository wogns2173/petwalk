package com.pet.member.dao;

import java.util.HashMap;

import com.pet.member.dto.MemberDTO;

public interface MemberDAO {

	int overlayid(String userID);
	
	int overlaypw(String encodedPassword);

	int join(HashMap<String, String> params);

	MemberDTO login(String userID);

	int memberdelete(Object attribute);		

	MemberDTO memberdetail(Object attribute);

	MemberDTO findmemberid(String userName, String userEmail);

	int findmemberpw(String userName, String userID, String userEmail);
	
	void RandomPassword(String userName, String userID, String userEmail, String encodedPassword);

	MemberDTO findloginpw(String userID);

	MemberDTO chkpw(Object attribute);

	Object overlaynickname(Object attribute);

	MemberDTO changememberpw(Object attribute);

	int changememberpwtrue(Object object, String encodedPassword);

	

	



	

}
