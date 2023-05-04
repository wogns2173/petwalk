package com.pet.member.dao;

import java.util.HashMap;

public interface MemberDAO {

	int overlayid(String userID);

	int join(HashMap<String, String> params);

	int login(String userID, String userPW);

	int memberdelete(Object attribute);

	int overlaynickname(String userNickname);

}
