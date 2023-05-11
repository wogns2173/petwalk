package com.pet.admin.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.pet.admin.dto.ReportDTO;

public interface ReportDAO {

	int repTotalCountList(HashMap<String, Object> map, int cnt, int offset, String categoryCode, Object storedValue);

	int repTotalCountListByProcess(HashMap<String, Object> params, Object storedValue, int cnt, int offset,
			String categoryCode);

	int repTotalCategoryCountCode(HashMap<String, Object> params, String categoryCode, int cnt, int offset);

	int repTotalCategoryAll(HashMap<String, Object> params, String categoryCode, Object storedValue, int cnt,
			int offset);

	ArrayList<ReportDTO> repList(HashMap<String, Object> map, int cnt, int offset, String categoryCode,
			Object storedValue);

	ArrayList<ReportDTO> repListByProcess(HashMap<String, Object> params, Object storedValue, int cnt, int offset,
			String categoryCode);

	ArrayList<ReportDTO> repCategoryCodeList(HashMap<String, Object> params, String categoryCode, int cnt, int offset);

	ArrayList<ReportDTO> repAllList(HashMap<String, Object> params, String categoryCode, Object storedValue, int cnt,
			int offset);

	ReportDTO repDetail(int reportNum);


	

	
}
