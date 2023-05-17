package com.pet.walkroute.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.pet.walkroute.dto.MateFindDTO;
import com.pet.walkroute.dto.MateListDetailDTO;
import com.pet.walkroute.dto.MessageDTO;

public interface MateFindDAO {

	ArrayList<MateFindDTO> dong();

	ArrayList<MateFindDTO> mateList(String dong);

	ArrayList<MateFindDTO> siList();

	ArrayList<MateFindDTO> guList(String siID);

	ArrayList<MateFindDTO> dongList(String guID);

	int upHit(String mateWalkNum);

	MateListDetailDTO detail(String mateWalkNum);

	ArrayList<MateListDetailDTO> coordinate(int walkNum);

	int mateInsert(HashMap<String, Object> params);

	ArrayList<MessageDTO> messageSendList(String sendID);
	
	ArrayList<MessageDTO> messageReceiveList(String receiveID);

	ArrayList<MessageDTO> messageHistory(String mateWalkNum);

	int messageSend(HashMap<String, Object> params);

}
