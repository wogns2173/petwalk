package com.pet.walkroute.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.pet.walkroute.dto.RouteListDTO;
import com.pet.walkroute.dto.DongInfoDTO;

public interface WalkRouteDAO {

	ArrayList<DongInfoDTO> dong();

	int routeListStore(RouteListDTO dto);

	int coordinateStore(HashMap<String, Object> map);

	ArrayList<RouteListDTO> routeList(String id);

	ArrayList<RouteListDTO> coordinateBring(String walkNum);

}
