package com.pet.admin.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.pet.admin.dto.InquiryDTO;

public interface ReportDAO {

	int reptotalCount(HashMap<String, Object> params);

	int reptotalCountcategory(HashMap<String, Object> params, String categoryCode);

	int reptotalCountprocess(HashMap<String, Object> params, Boolean process);

	int reptotalSearch(HashMap<String, Object> params, String search);

	int reptotalCountAll(HashMap<String, Object> params, String categoryCode, Boolean process);

	ArrayList<InquiryDTO> reportlist(HashMap<String, Object> params, int cnt, int offset);

	ArrayList<InquiryDTO> reportcategorycode(HashMap<String, Object> params, String categoryCode, int cnt, int offset);

	ArrayList<InquiryDTO> reportprocess(HashMap<String, Object> params, Boolean process, int cnt, int offset);

	ArrayList<InquiryDTO> reportsearch(HashMap<String, Object> params, String search, int cnt, int offset);

	ArrayList<InquiryDTO> reportlistAll(HashMap<String, Object> params, String categoryCode, Boolean process, int cnt,
			int offset);

	
}
