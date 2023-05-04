package com.pet.admin.dto;

import java.sql.Date;

public class InquiryDTO {

	private int boardNum;
	private String categoryCode;
	private String userID;
	private String boardName;
	private String boardDetail;
	private int boardbHit;
	private Date boardWriteDate;
	private boolean noticeWhether;
	private boolean boardBlindWhether;
	private boolean process;
	
	private String commentDetail;
	private Date commentWriteDate;
	private boolean commentBlindWhether;
	private int replyNum;
	
	public int getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}
	public String getCategoryCode() {
		return categoryCode;
	}
	public void setCategoryCode(String categoryCode) {
		this.categoryCode = categoryCode;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getBoardName() {
		return boardName;
	}
	public void setBoardName(String boardName) {
		this.boardName = boardName;
	}
	public String getBoardDetail() {
		return boardDetail;
	}
	public void setBoardDetail(String boardDetail) {
		this.boardDetail = boardDetail;
	}
	public int getBoardbHit() {
		return boardbHit;
	}
	public void setBoardbHit(int boardbHit) {
		this.boardbHit = boardbHit;
	}
	public Date getBoardWriteDate() {
		return boardWriteDate;
	}
	public void setBoardWriteDate(Date boardWriteDate) {
		this.boardWriteDate = boardWriteDate;
	}
	public boolean isNoticeWhether() {
		return noticeWhether;
	}
	public void setNoticeWhether(boolean noticeWhether) {
		this.noticeWhether = noticeWhether;
	}
	public boolean isBoarddBlindWhether() {
		return boardBlindWhether;
	}
	public void setBoradBlindWhether(boolean boradBlindWhether) {
		this.boardBlindWhether = boradBlindWhether;
	}

	public String getCommentDetail() {
		return commentDetail;
	}
	public void setCommetnDetail(String commetnDetail) {
		this.commentDetail = commetnDetail;
	}
	public Date getCommentWriteDate() {
		return commentWriteDate;
	}
	public void setCommentWriteDate(Date commentWriteDate) {
		this.commentWriteDate = commentWriteDate;
	}
	public boolean isCommentBlindWhether() {
		return commentBlindWhether;
	}
	public void setCommentBlindWhether(boolean commentBlindWhether) {
		this.commentBlindWhether = commentBlindWhether;
	}
	public int getReplyNum() {
		return replyNum;
	}
	public void setReplyNum(int replyNum) {
		this.replyNum = replyNum;
	}
	public void setCommentDetail(String commentDetail) {
		this.commentDetail = commentDetail;
	}
	public boolean isProcess() {
		return process;
	}
	public void setProcess(boolean process) {
		this.process = process;
	}
	
	

}
