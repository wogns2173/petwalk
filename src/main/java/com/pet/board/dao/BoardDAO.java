package com.pet.board.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.pet.board.dto.boardDTO;

public interface boardDAO {

	ArrayList<boardDTO> B_02list();

	//int boardWrite(String userID,String boardName, String boardDetail, String categoryCode);
	
	
	void boardbHit(String boardNum);

	boardDTO boardDetail(String boardNum);

	int boardWrite(boardDTO dto);

	void fileWrite(int boardNum, String oriPhotoname, String serPhotoname);


}
