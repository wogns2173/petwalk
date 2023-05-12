package com.pet.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

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
		 logger.info("repreplist Call"); 
		 model.addAttribute("repreplist",repreplist);
		 
		
		return "reportDetail";
	}
	
	@RequestMapping(value="/reportreplywrite.do", method = RequestMethod.POST)
	public String reportreplywrite(Model model,@RequestParam int reportNum, @RequestParam String reportProcess) {
		logger.info("Report Write Reply Call");
		
		logger.info("reportNum :"+reportNum);
		logger.info("reportProcess :"+reportProcess);
		int reportreplywrite = repservice.reportreplywrite(reportNum,reportProcess);
		model.addAttribute("reportreplywrite",reportreplywrite);
		
		return "redirect:/reportdetail.do?reportNum=" + reportNum;
	}
	
	@RequestMapping(value="/reprepdel.do", method = RequestMethod.GET)
	public String inquiryrepwrite(Model model, @RequestParam int repReplyNum,@RequestParam int reportNum) {
		logger.info("Report Delete Reply Call");
		logger.info("repReplyNum :"+repReplyNum);
		logger.info("reportNum :"+reportNum);
		
		repservice.reprepdel(repReplyNum);
		return "redirect:/reportdetail.do?reportNum=" + reportNum;
	}
	
	@RequestMapping(value="/reprepupdate.go", method = RequestMethod.GET)
	public String reportrepupdateform(Model model, @RequestParam int reportNum, @RequestParam int repReplyNum, @RequestParam String reportProcess) {
		
		logger.info("Report Update Reply Form Call");
		
		logger.info("reportNum :"+reportNum);
		logger.info("repReplyNum :"+repReplyNum);
		logger.info("reportProcess :"+reportProcess);
		model.addAttribute("reportNum", reportNum);
		
		ReportDTO reqdto = repservice.repdetail(reportNum,"repdetail");
		model.addAttribute("rep",reqdto);
		
		ArrayList<ReportDTO> repreplist2 = repservice.repreplist2(reportNum);
		model.addAttribute("repreplist", repreplist2);
		
		
		ReportDTO repreplist  = repservice.repreplist(reportNum, repReplyNum, reportProcess);
		logger.info("Report Update List Call");
		logger.info("reportNum : " + repreplist.getReportNum());
		logger.info("reportProcess :" +repreplist.getReportProcess());
		model.addAttribute("reportreply",repreplist.getReportProcess());
		model.addAttribute("repreplist2",repreplist);
		
		return "reportrepUpdate";		
	}

	@RequestMapping(value="/reportreplyupdate.do", method = RequestMethod.POST)
	public String inquiryrepupdate(Model model,@RequestParam HashMap<String, String> params) {
		
		logger.info("Report Update Reply Call");
		logger.info("reportNum :"+params);
		
		return repservice.reprepupdate(params);
	}
	
	@RequestMapping(value="/reportwrite.go")
	public String reportwriteform() {
		logger.info("Report Write Page 이동");
		
		return"reportWrite";
	}
	
	@RequestMapping(value = "/reportwrite.do", method = RequestMethod.POST)
	public String reportWrite(MultipartFile photo, @RequestParam HashMap<String, String> params) {
			
		logger.info("params:{}",params);
	
		
		return repservice.repWrite(photo,params);
	}
}