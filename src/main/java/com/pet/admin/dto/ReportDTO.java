package com.pet.admin.dto;

import java.sql.Date;

public class ReportDTO {
	
		// member join
		private String userNickname;
		private String userName;
	
	
		// report dto
		private int reportNum;
		private String userID;
		private String reportName;
		private String reportDetail;
		private String reportPhoto;
		private Date reportDate;
		private boolean reportBlind;
		private int reportidenNum;
		private boolean repProcess;
		private String reportNickName;
		
		// category dto
		private String categoryCode;
		private String categoryName;
		
		// reportreply dto
		private int repReplyNum;
		private String reportProcess;
		
		//photo dto
		private int photoNum;
		private String oriPhotoname;
		private String serPhotoname;
		private Date savaDate;
		private int photoIdenNum;
		private boolean photoBlindWhether;
		
		public int getReportNum() {
			return reportNum;
		}
		public void setReportNum(int reportNum) {
			this.reportNum = reportNum;
		}
		public String getUserID() {
			return userID;
		}
		public void setUserID(String userID) {
			this.userID = userID;
		}
		public String getReportName() {
			return reportName;
		}
		public void setReportName(String reportName) {
			this.reportName = reportName;
		}
		public String getReportDetail() {
			return reportDetail;
		}
		public void setReportDetail(String reportDetail) {
			this.reportDetail = reportDetail;
		}
		public String getReportPhoto() {
			return reportPhoto;
		}
		public void setReportPhoto(String reportPhoto) {
			this.reportPhoto = reportPhoto;
		}
		public Date getReportDate() {
			return reportDate;
		}
		public void setReportDate(Date reportDate) {
			this.reportDate = reportDate;
		}
		public boolean isReportBlind() {
			return reportBlind;
		}
		public void setReportBlind(boolean reportBlind) {
			this.reportBlind = reportBlind;
		}
		public int getReportidenNum() {
			return reportidenNum;
		}
		public void setReportidenNum(int reportidenNum) {
			this.reportidenNum = reportidenNum;
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
		public String getReportProcess() {
			return reportProcess;
		}
		public void setReportProcess(String reportProcess) {
			this.reportProcess = reportProcess;
		}
		public int getPhotoNum() {
			return photoNum;
		}
		public void setPhotoNum(int photoNum) {
			this.photoNum = photoNum;
		}
		public String getOriPhotoname() {
			return oriPhotoname;
		}
		public void setOriPhotoname(String oriPhotoname) {
			this.oriPhotoname = oriPhotoname;
		}
		public String getSerPhotoname() {
			return serPhotoname;
		}
		public void setSerPhotoname(String serPhotoname) {
			this.serPhotoname = serPhotoname;
		}
		public Date getSavaDate() {
			return savaDate;
		}
		public void setSavaDate(Date savaDate) {
			this.savaDate = savaDate;
		}
		public int getPhotoIdenNum() {
			return photoIdenNum;
		}
		public void setPhotoIdenNum(int photoIdenNum) {
			this.photoIdenNum = photoIdenNum;
		}
		public boolean isPhotoBlindWhether() {
			return photoBlindWhether;
		}
		public void setPhotoBlindWhether(boolean photoBlindWhether) {
			this.photoBlindWhether = photoBlindWhether;
		}
		public String getReportNickName() {
			return reportNickName;
		}
		public void setReportNickName(String reportNickName) {
			this.reportNickName = reportNickName;
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
		public boolean isRepProcess() {
			return repProcess;
		}
		public void setRepProcess(boolean repProcess) {
			this.repProcess = repProcess;
		}
		public int getRepReplyNum() {
			return repReplyNum;
		}
		public void setRepReplyNum(int repReplyNum) {
			this.repReplyNum = repReplyNum;
		}
}
