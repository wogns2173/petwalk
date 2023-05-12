package com.pet.walkroute.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.pet.walkroute.dto.RouteShareDTO;

public interface RouteShareDAO {

	String isAdmin(String userID);

	int write(HashMap<String, Object> params);

	String siID(String siName);

	String guID(String guName);

	String dongID(String dongName);

	int totalCount();

	ArrayList<RouteShareDTO> list(int cnt, int offset);

	RouteShareDTO detail(int walkRouteNum);

}
