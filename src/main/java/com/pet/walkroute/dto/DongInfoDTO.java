package com.pet.walkroute.dto;

public class DongInfoDTO {
	private int dongID; 
	private int guID; 
	private String dongName;
	private double lat; 
	private double lng;
	
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
