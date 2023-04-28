package com.pet.board.dto;

import java.sql.Date;

public class boardDTO {
	private String userID;
	private String categoryCode;
	private String categoryName;
	
	private String boardNum;
	private String boardName;
	private String boardDetail;
	private int boardbHit;
	private Date boardWriteDate;
	private boolean noticeWhether;
	private boolean boardBlindWhether;
	
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getCategoryCode() {
		return categoryCode;
	}
	public void setCategoryCode(String categoryCode) {
		this.categoryCode = categoryCode;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(String boardNum) {
		this.boardNum = boardNum;
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
	public boolean isBoardBlindWhether() {
		return boardBlindWhether;
	}
	public void setBoardBlindWhether(boolean boardBlindWhether) {
		this.boardBlindWhether = boardBlindWhether;
	}
	
	
}
