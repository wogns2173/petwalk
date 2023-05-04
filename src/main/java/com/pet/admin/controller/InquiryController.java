package com.pet.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
		
		ArrayList<InquiryDTO> inqreplist = inqservice.inqreplist2(boardNum);
		logger.info("inqreplist Call");
		model.addAttribute("inqreplist",inqreplist);
		
		return "inquiryDetail";
	}
	
	
	@RequestMapping(value="/inquirywrite.go")
	public String inquirywriteform() {
		logger.info("inquiry write page 이동");
		return"inquiryWrite";
	}
	
	@RequestMapping(value="/inquiryreplywrite.do", method = RequestMethod.POST)
	public String inquiryreplywrite(Model model,@RequestParam int boardNum, @RequestParam String content) {
		logger.info("Inquiry Write Reply Call");
		
		logger.info("boardNum :"+boardNum);
		logger.info("content :"+content);
		int inqreplywrite = inqservice.inqreplywrite(boardNum,content);
		model.addAttribute("inqreplywrite",inqreplywrite);
		
		return "redirect:/inquirydetail.do?boardNum=" + boardNum;
	}
	
	@RequestMapping(value="/inqrepdel.do", method = RequestMethod.GET)
	public String inquiryrepwrite(Model model, @RequestParam int replyNum,@RequestParam int boardNum) {
		logger.info("Inquiry Delete Reply Call");
		logger.info("replyNum :"+replyNum);
		logger.info("boardNum :"+boardNum);
		
		inqservice.inqrepdel(replyNum);
		return "redirect:/inquirydetail.do?boardNum="+boardNum;
	}
	
	@RequestMapping(value="/inqrepupdate.go", method = RequestMethod.GET)
	public String inquiryrepupdateform(Model model, @RequestParam int boardNum, @RequestParam int replyNum) {
		
		logger.info("Inquiry Update Reply Form Call");
		
		logger.info("boardNum :"+boardNum);
		logger.info("replyNum :"+replyNum);
		model.addAttribute("replyNum", replyNum);
		
		InquiryDTO inqdto = inqservice.inqdetail(boardNum,"inqdetail");
		model.addAttribute("inq",inqdto);
		
		ArrayList<InquiryDTO> inqreplist2 = inqservice.inqreplist2(boardNum);
		model.addAttribute("inqreplist", inqreplist2);
		
		InquiryDTO inqreplist = inqservice.inqreplist(boardNum, replyNum);
		logger.info("inqreplist Call");
		logger.info("boardNum : " + inqreplist.getBoardNum());
		model.addAttribute("inqreplist2",inqreplist);
		
		return "inquiryrepupdate";		
	}

	@RequestMapping(value="/inquiryreplyupdate.do", method = RequestMethod.GET)
	public String inquiryrepupdate(Model model,@RequestParam HashMap<String, String> params) {
		
		logger.info("Inquiry Update Reply Call");
		logger.info("boardNum :"+params);
		
		return inqservice.update(params);
	}
	

}