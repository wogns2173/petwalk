package com.pet.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import org.springframework.web.servlet.ModelAndView;

import com.pet.admin.dto.InquiryDTO;
import com.pet.admin.dto.ReportDTO;
import com.pet.admin.service.ReportService;

@Controller
public class ReportController {
	
	@Autowired ReportService repservice;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value = "/reportList.go")
	public ModelAndView ReportListCall(Model model,HttpSession session) {
		
		logger.info("Report List Page 이동");
		
		ModelAndView modelAndView = new ModelAndView();
		
		String userID = (String) session.getAttribute("userID");
	    String role = (String) session.getAttribute("Role");
	    if (role != null && role.equals("admin")  && userID != null) {
	        modelAndView.setViewName("reportList");
	        return modelAndView; 
	    } else {
	        String errorMessage = "관리자만 입장 가능합니다.";
	        String script = String.format("<script>alert('%s'); history.go(-1); </script>", errorMessage);
	        modelAndView.setViewName("inlineScript");
	        modelAndView.addObject("script", script);
	        return modelAndView; 
	    }
	}
	
	@RequestMapping(value="/replist.ajax")
	@ResponseBody
	public HashMap<String, Object> ReportList(@RequestParam HashMap<String,Object> params) {
		
		logger.info("ReportList List Call");
		logger.info("params :"+params);
		
		return repservice.replist(params);
		
	}
	
	@RequestMapping(value="/reportdetail.do")
	public String inquirydetail(Model model ,@RequestParam int reportNum, HttpServletRequest request) {
		logger.info("Report Detail Call");
		
		
		ReportDTO reqdto = repservice.repdetail(reportNum,"repdetail");
	
		
		model.addAttribute("rep",reqdto);
		
		
		ArrayList<ReportDTO> repreplist = repservice.inqreplist2(reportNum);
	    logger.info("repreplist Call"); 
		model.addAttribute("repreplist",repreplist);
		 
		HttpSession session = request.getSession();
		String role = (String) session.getAttribute("Role");
		model.addAttribute("Role", role);
			
		String userID = (String) session.getAttribute("userID");
		model.addAttribute("userID", userID);
		
		return "reportDetail";
	}
	
	@RequestMapping(value="/reportreplywrite.do", method = RequestMethod.POST)
	public String reportreplywrite(Model model,@RequestParam int reportNum, @RequestParam String reportProcess, HttpSession session) {
		logger.info("Report Write Reply Call");
		
		String userID = (String) session.getAttribute("userID");
		
		logger.info("userID :"+userID);	
		logger.info("reportNum :"+reportNum);
		logger.info("reportProcess :"+reportProcess);
		int reportreplywrite = repservice.reportreplywrite(reportNum,reportProcess,userID);
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
		logger.info("repReplyNum :" +repreplist.getRepReplyNum());
		model.addAttribute("reportreply",repreplist.getReportProcess());
		model.addAttribute("repreplist2",repreplist);
		
		return "reportrepUpdate";		
	}

	@RequestMapping(value="/reportreplyupdate.do")
	public String inquiryrepupdate(Model model,@RequestParam HashMap<String, String> params) {
		
		logger.info("Report Update Reply Call");
		logger.info("reportNum :"+params);
		
		return repservice.reprepupdate(params);
	}
	
	@RequestMapping(value="/reportwrite.go", method = RequestMethod.GET)
	public ModelAndView reportwriteform(Model model, HttpSession session, @RequestParam HashMap<String, String> params) {
		logger.info("Report Write Page 이동");
		logger.info("params :"+params);
		
		String userID = (String) session.getAttribute("userID");
		String reportID = params.get("userID");
		int boardNum =Integer.parseInt(params.get("boardNum"));
		
		logger.info("reportID :"+reportID+"/"+"boardNum :"+boardNum+"/"+"userID :"+userID);
		
		model.addAttribute("boardNum",boardNum);
		model.addAttribute("reportID",reportID);
	    ModelAndView modelAndView = new ModelAndView();

	    if (userID == null) {
	        String alertMessage = "로그인이 필요합니다.";
	        String script = String.format("<script>alert('%s'); history.go(-1);</script>", alertMessage);
	        modelAndView.setViewName("inlineScript");
	        modelAndView.addObject("script", script);
	    } else {
	        modelAndView.setViewName("reportWrite");
	    }
	    
	    return modelAndView;
	}
	
	@RequestMapping(value = "/reportwrite.do", method = RequestMethod.POST)
	public String reportWrite(MultipartFile photo, @RequestParam HashMap<String, String> params, HttpSession session) {
		
		String userID = (String) session.getAttribute("userID");
		
		logger.info("params:{}",params);
		logger.info("userID :"+userID);
		
		String reportID = params.get("reportID");
		int boardNum = Integer.parseInt(params.get("boardNum"));
		
		logger.info("reportID :"+reportID+"/"+"boardNum :"+boardNum);
		return repservice.repWrite(photo,params,userID,boardNum);
	}
	
	@RequestMapping(value="/reportprocess.go", method = RequestMethod.POST)
	public String reportprocessupdate(@RequestParam boolean selectedValue, @RequestParam int reportNum) {
		
		logger.info("Report Process Update Call");
		logger.info("selectedValue :"+selectedValue+"/"+"boardNum :"+reportNum);
		
		int processValue = selectedValue ? 1 : 0;
	
		return repservice.processupdate(processValue,reportNum);
	}
}