package com.pet.admin.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.pet.admin.dto.NoticeDTO;

public interface NoticeDAO {

	int noticeAllTotal(HashMap<String, Object> params);

	int noticeSearchTotal(HashMap<String, Object> params, String searchText);

	ArrayList<NoticeDTO> noticeAllList(HashMap<String, Object> params, int cnt, int offset);

	ArrayList<NoticeDTO> noticeSearchList(HashMap<String, Object> params, String searchText, int cnt, int offset);

	NoticeDTO noticeDetail(int boardNum);

	int noticeWrite(NoticeDTO noticedto);

	void fileWrite(String categoryCode, String oriPhotoname, String serPhotoname, int boardNum);

	void upHit(int boardNum);

	int noticerepwrite(int boardNum, String content, String userID);

	ArrayList<NoticeDTO> noticereplist2(int boardNum);

	int noticerepdel(int replyNum);

	NoticeDTO noticereplist(int boardNum, int replyNum, String commentDetail);

	int noticerepupdate(HashMap<String, String> params);

	int noticeBlindUpdate(int boardNum, int blind);

}
