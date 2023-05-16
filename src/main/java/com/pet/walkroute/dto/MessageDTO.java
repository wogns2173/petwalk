package com.pet.walkroute.dto;

import java.sql.Date;

public class MessageDTO {
	private String receiveID;
	private String sendID;
	private int mateWalkNum;
	private String messageDetail;
	private Date messageTime;
	
	public String getReceiveID() {
		return receiveID;
	}
	public void setReceiveID(String receiveID) {
		this.receiveID = receiveID;
	}
	public String getSendID() {
		return sendID;
	}
	public void setSendID(String sendID) {
		this.sendID = sendID;
	}
	public int getMateWalkNum() {
		return mateWalkNum;
	}
	public void setMateWalkNum(int mateWalkNum) {
		this.mateWalkNum = mateWalkNum;
	}
	public String getMessageDetail() {
		return messageDetail;
	}
	public void setMessageDetail(String messageDetail) {
		this.messageDetail = messageDetail;
	}
	public Date getMessageTime() {
		return messageTime;
	}
	public void setMessageTime(Date messageTime) {
		this.messageTime = messageTime;
	}
	
}
