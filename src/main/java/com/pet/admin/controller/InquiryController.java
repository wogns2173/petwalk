package com.pet.admin.controller;

import java.util.ArrayList;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.pet.admin.dto.InquiryDTO;
import com.pet.admin.service.InquiryService;



// 문의 관련 요청을 처리하는 컨트롤러

@Controller
public class InquiryController {
	
	@Autowired InquiryService inqservice;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	
	@RequestMapping(value = "/inquiry")

	public String inquirylist(Locale locale, Model model) {
		logger.info("inquiry List Call");
		System.out.println("list call");
		ArrayList<InquiryDTO> inqlist = inqservice.inqlist();
		
		model.addAttribute("inqlist" ,inqlist);
		logger.info("inqlist :"+inqlist.size());
		
		return "inquiryList";

	}
	
	@RequestMapping(value="/inquirydetail.do")
	public String inquirydetail(Model model , @RequestParam int boardNum) {
		logger.info("lnquiry Detail Call");
		
		InquiryDTO inqdto = inqservice.inqdetail(boardNum,"inqdetail");
		model.addAttribute("inq",inqdto);
		
		return "inquiryDetail";
	}
	
	@RequestMapping(value="/inquirywrite.go")
	public String inquirywriteform() {
		logger.info("inquiry write page 이동");
		return"inquiryWrite";
	}
	
	
}