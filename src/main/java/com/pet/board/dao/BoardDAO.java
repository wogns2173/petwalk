package com.pet.board.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.pet.board.dto.BoardDTO;

public interface BoardDAO {

	ArrayList<BoardDTO> B_02list();

	//int boardWrite(String userID,String boardName, String boardDetail, String categoryCode);
	
	
	void boardbHit(String boardNum);

	BoardDTO boardDetail(String boardNum);

	int boardWrite(BoardDTO dto);

	void fileWrite(String categoryCode, String oriPhotoname, String serPhotoname, int boardNum);

	String findFile(String boardNum);

	int boardDelete(String boardNum);

	int boardUpdate(HashMap<String, String> params);

	int photoDelete(String serPhotoname);

	int totalCount();

	ArrayList<BoardDTO> list(int cnt, int offset);


}
