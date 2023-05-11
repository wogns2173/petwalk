package com.pet.walkroute.dao;

import java.util.HashMap;

public interface RouteShareDAO {

	String isAdmin(String userID);

	int write(HashMap<String, Object> params);

}
