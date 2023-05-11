package com.pet.walkroute.dto;

public class WalkRouteVO {
	
	private double[] latArray;
	private double[] lngArray;
	private String subject;
	private String content;
	
	public double[] getLatArray() {
		return latArray;
	}
	public void setLatArray(double[] latArray) {
		this.latArray = latArray;
	}
	public double[] getLngArray() {
		return lngArray;
	}
	public void setLngArray(double[] lngArray) {
		this.lngArray = lngArray;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
}
