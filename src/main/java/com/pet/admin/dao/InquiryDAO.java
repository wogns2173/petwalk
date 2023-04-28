package com.pet.admin.dao;

import java.util.ArrayList;

import com.pet.admin.dto.InquiryDTO;

public interface InquiryDAO {

	InquiryDTO inqdetail = null;

	ArrayList<InquiryDTO> inqlist();

	InquiryDTO inqdetail(int boardNum);

	void upHit(int boardNum);

}
