package com.pet.walkroute.dto;

import java.sql.Date;

public class MateFindDTO {
	private int dongID; 
	private int guID; 
	private String dongName;
	private double lat; 
	private double lng;
	
	private int mateWalkNum;
	private String userID;
	private int walkNum;
	private int siID;
	private String mateName;
	private String mateDetail;
	private String matebHit;
	private Date petWalkDate;
	private Date mateWriteDate;
	private String state;
	private boolean mateBlindWhether;
	
	private String siName;
	private String guName;
	
	public String getSiName() {
		return siName;
	}
	public void setSiName(String siName) {
		this.siName = siName;
	}
	public String getGuName() {
		return guName;
	}
	public void setGuName(String guName) {
		this.guName = guName;
	}
	public int getMateWalkNum() {
		return mateWalkNum;
	}
	public void setMateWalkNum(int mateWalkNum) {
		this.mateWalkNum = mateWalkNum;
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
	public int getSiID() {
		return siID;
	}
	public void setSiID(int siID) {
		this.siID = siID;
	}
	public String getMateName() {
		return mateName;
	}
	public void setMateName(String mateName) {
		this.mateName = mateName;
	}
	public String getMateDetail() {
		return mateDetail;
	}
	public void setMateDetail(String mateDetail) {
		this.mateDetail = mateDetail;
	}
	public String getMatebHit() {
		return matebHit;
	}
	public void setMatebHit(String matebHit) {
		this.matebHit = matebHit;
	}
	public Date getPetWalkDate() {
		return petWalkDate;
	}
	public void setPetWalkDate(Date petWalkDate) {
		this.petWalkDate = petWalkDate;
	}
	public Date getMateWriteDate() {
		return mateWriteDate;
	}
	public void setMateWriteDate(Date mateWriteDate) {
		this.mateWriteDate = mateWriteDate;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public boolean isMateBlindWhether() {
		return mateBlindWhether;
	}
	public void setMateBlindWhether(boolean mateBlindWhether) {
		this.mateBlindWhether = mateBlindWhether;
	}
	public int getDongID() {
		return dongID;
	}
	public void setDongID(int dongID) {
		this.dongID = dongID;
	}
	public int getGuID() {
		return guID;
	}
	public void setGuID(int guID) {
		this.guID = guID;
	}
	public String getDongName() {
		return dongName;
	}
	public void setDongName(String dongName) {
		this.dongName = dongName;
	}
	public double getLat() {
		return lat;
	}
	public void setLat(double lat) {
		this.lat = lat;
	}
	public double getLng() {
		return lng;
	}
	public void setLng(double lng) {
		this.lng = lng;
	}
}
