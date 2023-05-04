package com.pet.walkroute.dao;

import java.util.ArrayList;

import com.pet.walkroute.dto.MateFindDTO;

public interface MateFindDAO {

	ArrayList<MateFindDTO> dong();

	ArrayList<MateFindDTO> mateList(String dong);

	ArrayList<MateFindDTO> siList();

	ArrayList<MateFindDTO> guList(String siID);

	ArrayList<MateFindDTO> dongList(String guID);

}
