package com.pet.admin.dto;

import java.sql.Date;

public class MemManageDTO {
	
	// 회원정보 DTO
	
	private String userID;
	private int siID;
	private int guID;
	private int dongID;
	private String siName;
	private String guName;
	private String dongName;
	private String userPW;
	private String userNickname;
	private String userName;
	private int userAge;
	private Date userBirthdate;
	private String userGender;
	private String userContact;
	private String userEmail;	
	private String Role;
	private Boolean userBlindWhether;
	private Date userSignup;
	
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public int getSiID() {
		return siID;
	}
	public void setSiID(int siID) {
		this.siID = siID;
	}
	public int getGuID() {
		return guID;
	}
	public void setGuID(int guID) {
		this.guID = guID;
	}
	public int getDongID() {
		return dongID;
	}
	public void setDongID(int dongID) {
		this.dongID = dongID;
	}
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
	public String getDongName() {
		return dongName;
	}
	public void setDongName(String dongName) {
		this.dongName = dongName;
	}
	public String getUserPW() {
		return userPW;
	}
	public void setUserPW(String userPW) {
		this.userPW = userPW;
	}
	public String getUserNickname() {
		return userNickname;
	}
	public void setUserNickname(String userNickname) {
		this.userNickname = userNickname;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public int getUserAge() {
		return userAge;
	}
	public void setUserAge(int userAge) {
		this.userAge = userAge;
	}
	public Date getUserBirthdate() {
		return userBirthdate;
	}
	public void setUserBirthdate(Date userBirthdate) {
		this.userBirthdate = userBirthdate;
	}
	public String getUserGender() {
		return userGender;
	}
	public void setUserGender(String userGender) {
		this.userGender = userGender;
	}
	public String getUserContact() {
		return userContact;
	}
	public void setUserContact(String userContact) {
		this.userContact = userContact;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getRole() {
		return Role;
	}
	public void setRole(String role) {
		Role = role;
	}
	public Boolean getUserBlindWhether() {
		return userBlindWhether;
	}
	public void setUserBlindWhether(Boolean userBlindWhether) {
		this.userBlindWhether = userBlindWhether;
	}
	public Date getUserSignup() {
		return userSignup;
	}
	public void setUserSignup(Date userSignup) {
		this.userSignup = userSignup;
	}
	
}
