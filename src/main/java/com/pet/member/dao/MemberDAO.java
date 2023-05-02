package com.pet.member.dao;

import java.util.HashMap;

public interface MemberDAO {

	int overlay(String userID);

	int join(HashMap<String, String> params);

	int login(String userID, String userPW);

}
