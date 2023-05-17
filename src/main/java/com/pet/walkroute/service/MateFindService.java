package com.pet.walkroute.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pet.walkroute.dao.MateFindDAO;
import com.pet.walkroute.dto.MateFindDTO;
import com.pet.walkroute.dto.MateListDetailDTO;
import com.pet.walkroute.dto.MessageDTO;

@Service
public class MateFindService {
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MateFindDAO dao;
	
	public ArrayList<MateFindDTO> dong() {
		// TODO Auto-generated method stub
		return dao.dong();
	}

	public ArrayList<MateFindDTO> mateList(String dong) {
		return dao.mateList(dong);
	}

	public ArrayList<MateFindDTO> siList() {
		return dao.siList();
	}

	public ArrayList<MateFindDTO> guList(String siID) {
		return dao.guList(siID);
	}

	public ArrayList<MateFindDTO> dongList(String guID) {
		return dao.dongList(guID);
	}

	public MateListDetailDTO detail(String mateWalkNum, String flag) {
		if(flag.equals("detail")) {
			dao.upHit(mateWalkNum);
		}
		return dao.detail(mateWalkNum);
	}

	public ArrayList<MateListDetailDTO> coordinate(int walkNum) {
		return dao.coordinate(walkNum);
	}

	public int mateInsert(HashMap<String, Object> params) {
		return dao.mateInsert(params);
	}

	public ArrayList<MessageDTO> messageSendList(String sendID) {
		return dao.messageSendList(sendID);
	}
	
	public ArrayList<MessageDTO> messageReceiveList(String receiveID) {
		return dao.messageReceiveList(receiveID);
	}
	
	public ArrayList<MessageDTO> messageHistory(String mateWalkNum) {
		return dao.messageHistory(mateWalkNum);
	}

	public int messageSend(HashMap<String, Object> params) {
		return dao.messageSend(params);
	}

}
