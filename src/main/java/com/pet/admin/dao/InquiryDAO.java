package com.pet.admin.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.pet.admin.dto.InquiryDTO;

public interface InquiryDAO {

	ArrayList<InquiryDTO> inqlist();

	InquiryDTO inqdetail(int boardNum);

	void upHit(int boardNum);

	InquiryDTO inqreplist(int boardNum, int replyNum);

	int inqrepwrite(int boardNum, String content);

	int inqrepdel(int replyNum);

	int inqrepupdate(HashMap<String, String> params);

	ArrayList<InquiryDTO> inqreplist2(int boardNum);



	

	

}
