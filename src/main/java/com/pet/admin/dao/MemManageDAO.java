package com.pet.admin.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.pet.admin.dto.InquiryDTO;
import com.pet.admin.dto.MemManageDTO;

public interface MemManageDAO {

	int memTotalCount(HashMap<String, Object> params);

	int memIDTotalCount(HashMap<String, Object> params, String searchType, String searchText);

	int memNameTotalCount(HashMap<String, Object> params, String searchType, String searchText);

	int memTotalCountByProcess(HashMap<String, Object> params, Object storedValue);
	
	ArrayList<InquiryDTO> memTotalList(HashMap<String, Object> params, int cnt, int offset);

	ArrayList<InquiryDTO> memIDTotalList(HashMap<String, Object> params, String searchType, String searchText, int cnt, int offset);

	ArrayList<InquiryDTO> memNameTotalList(HashMap<String, Object> params, String searchType, String searchText, int cnt, int offset);

	ArrayList<InquiryDTO> memTotalListByProcess(HashMap<String, Object> params, Object storedValue, int cnt, int offset);

	int memIDTotalCountByProcess(HashMap<String, Object> params, String searchType, String searchText, Object storedValue);

	int memNameTotalCountByProcess(HashMap<String, Object> params, String searchType, String searchText, Object storedValue);

	ArrayList<InquiryDTO> memIDTotalListByProcess(HashMap<String, Object> params, String searchType, String searchText, Object storedValue, int cnt, int offset);

	ArrayList<InquiryDTO> memNameTotalListByProcess(HashMap<String, Object> params, String searchType, String searchText, Object storedValue, int cnt, int offset);

	MemManageDTO memdetail(String userID);

	int memprocessupdate(Boolean selectedValue, String userID);




}
