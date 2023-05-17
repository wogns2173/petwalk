package com.pet.walkroute.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;

import com.pet.walkroute.dto.RouteShareDTO;

public interface RouteShareDAO {

	String isAdmin(String userID);

	int write(HashMap<String, Object> params);

	String siID(String siName);

	String guID(String guName);

	String dongID(String dongName);

	int totalCount();

	ArrayList<RouteShareDTO> list(String walkRouteType, int cnt, int offset);

	RouteShareDTO detail(int walkRouteNum);

	String isRecommend(String walkRouteNum);

	String isBookmark(String walkNum, String userID);

	int recommendDo(@Param("walkRouteNum")String walkRouteNum, @Param("userID")String userID);

	int bookmarkDo(@Param("walkNum")String walkNum, @Param("userID")String userID);

	int recommendCancel(@Param("walkRouteNum")String walkRouteNum, @Param("userID")String userID);

	int bookmarkCancel(@Param("walkNum")String walkNum, @Param("userID")String userID);

	int delete(String walkRouteNum);

	int addressFiterCount(HashMap<String, Object> params);

	ArrayList<RouteShareDTO> addressFilterlist(HashMap<String, Object> params);

	int idFiterCount(HashMap<String, Object> params);

	int subjectFiterCount(HashMap<String, Object> params);

	ArrayList<RouteShareDTO> idFilterlist(HashMap<String, Object> params);

	ArrayList<RouteShareDTO> subjectFilterlist(HashMap<String, Object> params);

	int update(HashMap<String, Object> params);

}
