package com.pet.walkroute.dto;

import java.sql.Date;

public class RouteShareDTO {
	private int walkRouteNum;
	private String userID;
	private int walkNum;
	private String siID;
	private String guID;
	private String dongID;
	private String walkRouteName;
	private String walkRouteDetail;
	private int walkRoutebHit;
	private Date walkRouteWriteDate;
	private String walkRouteType;
	private boolean walkRouteBlind;
	private int recommendation;
	
	public int getWalkRouteNum() {
		return walkRouteNum;
	}
	public void setWalkRouteNum(int walkRouteNum) {
		this.walkRouteNum = walkRouteNum;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public int getWalkNum() {
		return walkNum;
	}
	public void setWalkNum(int walkNum) {
		this.walkNum = walkNum;
	}
	public String getSiID() {
		return siID;
	}
	public void setSiID(String siID) {
		this.siID = siID;
	}
	public String getGuID() {
		return guID;
	}
	public void setGuID(String guID) {
		this.guID = guID;
	}
	public String getDongID() {
		return dongID;
	}
	public void setDongID(String dongID) {
		this.dongID = dongID;
	}
	public String getWalkRouteName() {
		return walkRouteName;
	}
	public void setWalkRouteName(String walkRouteName) {
		this.walkRouteName = walkRouteName;
	}
	public String getWalkRouteDetail() {
		return walkRouteDetail;
	}
	public void setWalkRouteDetail(String walkRouteDetail) {
		this.walkRouteDetail = walkRouteDetail;
	}
	public int getWalkRoutebHit() {
		return walkRoutebHit;
	}
	public void setWalkRoutebHit(int walkRoutebHit) {
		this.walkRoutebHit = walkRoutebHit;
	}
	public Date getWalkRouteWriteDate() {
		return walkRouteWriteDate;
	}
	public void setWalkRouteWriteDate(Date walkRouteWriteDate) {
		this.walkRouteWriteDate = walkRouteWriteDate;
	}
	public String getWalkRouteType() {
		return walkRouteType;
	}
	public void setWalkRouteType(String walkRouteType) {
		this.walkRouteType = walkRouteType;
	}
	public boolean isWalkRouteBlind() {
		return walkRouteBlind;
	}
	public void setWalkRouteBlind(boolean walkRouteBlind) {
		this.walkRouteBlind = walkRouteBlind;
	}
	public int getRecommendation() {
		return recommendation;
	}
	public void setRecommendation(int recommendation) {
		this.recommendation = recommendation;
	}
	
}
