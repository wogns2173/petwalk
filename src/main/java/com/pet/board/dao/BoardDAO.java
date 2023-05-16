package com.pet.board.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.pet.admin.dto.InquiryDTO;
import com.pet.board.dto.BoardDTO;

public interface BoardDAO {

	ArrayList<BoardDTO> boardList();

	//int boardWrite(String userID,String boardName, String boardDetail, String categoryCode);
	
	
	void boardbHit(String boardNum);

	BoardDTO boardDetail(String boardNum);

	int boardWrite(BoardDTO dto);

	void fileWrite(String categoryCode, String oriPhotoname, String serPhotoname, int boardNum);

	//String findFile(String boardNum);

	int boardDelete(String boardNum);

	int boardUpdate(HashMap<String, String> params);

	int photoDelete(String serPhotoname);

	int totalCount(String categoryCode);

	ArrayList<BoardDTO> list(int cnt, int offset,String categoryCode
			,String boardSearch,String search);

	BoardDTO boardDetailPhotoDel(String boardNum);

	ArrayList<BoardDTO> boardNameSearch(int cnt, int offset, String categoryCode, String boardSearch, String search);

	ArrayList<BoardDTO> boardNicknamesearch(int cnt, int offset, String categoryCode, String boardSearch,
			String search);

	ArrayList<BoardDTO> boarduserIDsearch(int cnt, int offset, String categoryCode, String boardSearch, String search);

	int boardRepWrite(int boardNum, String content, String userID);

	BoardDTO boardRepList(String boardNum, int replyNum);

	ArrayList<BoardDTO> boardRepList2(String boardNum);

	int boardRepUpdate(HashMap<String, String> params);

	int boardRepDel(int replyNum);

	BoardDTO findPhotoBlindWhether(String boardNum);

	int boardNameSearchTotal(String categoryCode, String search);

	int boardNicknamesearchTotal(String categoryCode, String search);

	int boarduserIDsearchTotal(String categoryCode, String search);

	int boardPhotoCount(String boardNum);

	ArrayList<BoardDTO> boardPhotoList(int cnt, int offset, String categoryCode, String boardSearch, String search);

	ArrayList<BoardDTO> boardPhotoNameSearch(int cnt, int offset, String categoryCode, String boardSearch,
			String search);

	ArrayList<BoardDTO> boardPhotoNicknamesearch(int cnt, int offset, String categoryCode, String boardSearch,
			String search);

	ArrayList<BoardDTO> boardPhotouserIDsearch(int cnt, int offset, String categoryCode, String boardSearch,
			String search);

	//void boardbHitDown(String boardNum);


	//ArrayList<BoardDTO> photoboardList();


}
