package com.pet.walkroute.dto;

import java.sql.Date;

public class RouteListDTO {
	private int walkNum;
	private String userID;
	private String walkName;
	private String walkDetail;
	private Date walkDate;
	private int mapOrder;
	private Double lat;
	private Double lng;
	
	public int getWalkNum() {
		return walkNum;
	}
	public void setWalkNum(int walkNum) {
		this.walkNum = walkNum;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getWalkName() {
		return walkName;
	}
	public void setWalkName(String walkName) {
		this.walkName = walkName;
	}
	public String getWalkDetail() {
		return walkDetail;
	}
	public void setWalkDetail(String walkDetail) {
		this.walkDetail = walkDetail;
	}
	public Date getWalkDate() {
		return walkDate;
	}
	public void setWalkDate(Date walkDate) {
		this.walkDate = walkDate;
	}
	public int getMapOrder() {
		return mapOrder;
	}
	public void setMapOrder(int mapOrder) {
		this.mapOrder = mapOrder;
	}
	public Double getLat() {
		return lat;
	}
	public void setLat(Double lat) {
		this.lat = lat;
	}
	public Double getLng() {
		return lng;
	}
	public void setLng(Double lng) {
		this.lng = lng;
	}
	
	
}
