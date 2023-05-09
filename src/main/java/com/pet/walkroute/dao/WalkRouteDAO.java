package com.pet.walkroute.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.pet.walkroute.dto.RouteListDTO;
import com.pet.walkroute.dto.WalkRouteDTO;

public interface WalkRouteDAO {

	ArrayList<WalkRouteDTO> dong();

	int routeListStore(RouteListDTO dto);

	int coordinateStore(HashMap<String, Object> map);

}
