package com.pet.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pet.admin.dto.InquiryDTO;
import com.pet.admin.dto.ReportDTO;
import com.pet.admin.service.ReportService;

@Controller
public class ReportController {
	
	@Autowired ReportService repservice;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value = "/reportList.go")
	public String ReportListCall(Model model) {
		
		logger.info("Report List Page 이동");
		
		return "reportList";
	}
	
	@RequestMapping(value="/replist.ajax")
	@ResponseBody
	public HashMap<String, Object> ReportList(@RequestParam HashMap<String,Object> params) {
		
		logger.info("ReportList List Call");
		logger.info("params :"+params);
		
		return repservice.replist(params);
		
	}
	
	@RequestMapping(value="/reportdetail.do")
	public String inquirydetail(Model model , @RequestParam int reportNum) {
		logger.info("Report Detail Call");
		
		
		ReportDTO reqdto = repservice.repdetail(reportNum,"repdetail");
	
		
		model.addAttribute("rep",reqdto);
		
		
		 ArrayList<ReportDTO> repreplist = repservice.inqreplist2(reportNum);
		 logger.info("repreplist Call"); model.addAttribute("repreplist",repreplist);
		 
		
		return "reportDetail";
	}
}