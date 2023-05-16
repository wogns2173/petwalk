package com.pet.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;

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
import com.pet.admin.dto.NoticeDTO;
import com.pet.admin.service.NoticeService;

@Controller
public class NoticeController {
	
	@Autowired NoticeService notservice;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value = "/noticelist.go")
	public String notice() {
		logger.info("Notice List Page 이동");
		return "noticeList";
	}
	
	@RequestMapping(value="/noticelist.ajax")
	@ResponseBody
	public HashMap<String, Object> noticeList(@RequestParam HashMap<String,Object> params) {
		logger.info("Notice List Call");
		
		return notservice.notlist(params);
	}
	
	@RequestMapping(value="/noticedetail.do")
	public String inquirydetail(Model model , @RequestParam int boardNum, HttpServletRequest request) {
		logger.info("Notice Detail Call");
		logger.info("boardNum :"+boardNum);
		
		NoticeDTO noticedto = notservice.noticedetail(boardNum,"noticedetail");
	
		
		model.addAttribute("notice",noticedto);
		
		ArrayList<NoticeDTO> noticereplist = notservice.noticereplist2(boardNum);
		logger.info("noticereplist Call");
		model.addAttribute("noticereplist",noticereplist);
		
		HttpSession session = request.getSession();
		String userID = (String) session.getAttribute("userID");
	    model.addAttribute("userID", userID);
		
		return "noticeDetail";
	}
	
	@RequestMapping(value="/noticewrite.go")
	public ModelAndView noticewriteform(HttpSession session) {
		logger.info("notice write page 이동");
		
		String role = (String) session.getAttribute("Role");
		ModelAndView modelAndView = new ModelAndView();
		
	    if (role != null && role.equals("admin")) {
	        modelAndView.setViewName("noticeWrite");
	        return modelAndView; 
	    } else {
	        String errorMessage = "관리자만 입장 가능합니다.";
	        String script = String.format("<script>alert('%s'); history.go(-1); </script>", errorMessage);
	        modelAndView.setViewName("inlineScript");
	        modelAndView.addObject("script", script);
	        return modelAndView; 
	    }
	
	}
	
	@RequestMapping(value = "/noticewrite.do", method = RequestMethod.POST)
	public String noticeWrite(MultipartFile photo, @RequestParam HashMap<String, String> params, HttpSession session) {
			
		String userID = (String) session.getAttribute("userID");
		
		logger.info("params:{}",params);
		logger.info("userID :"+userID);
		
		return notservice.noticeWrite(photo,params,userID);
	}
	
	@RequestMapping(value="/noticereplywrite.do", method = RequestMethod.POST)
	public String noticereplywrite(Model model,@RequestParam int boardNum, @RequestParam String content, HttpSession session) {
		
		logger.info("Nocice Write Reply Call");
		
		String userID = (String) session.getAttribute("userID");
		
		logger.info("boardNum :"+boardNum+"/"+"content :"+content+"/"+"userID :"+userID);

		int noticereplywrite = notservice.noticereplywrite(boardNum,content,userID);
		model.addAttribute("noticereplywrite",noticereplywrite);
		
		return "redirect:/noticedetail.do?boardNum=" + boardNum;
	}
	
	@RequestMapping(value="/noticerepdel.do", method = RequestMethod.GET)
	public String noticerepwrite(Model model, @RequestParam int replyNum,@RequestParam int boardNum) {
		logger.info("Notice Delete Reply Call");
		logger.info("replyNum :"+replyNum);
		logger.info("boardNum :"+boardNum);
		
		notservice.notrepdel(replyNum);
		return "redirect:/noticedetail.do?boardNum="+boardNum;
	}
	
	@RequestMapping(value="/noticerepupdate.go", method = RequestMethod.GET)
	public String noticerepupdateform(Model model, @RequestParam int boardNum, @RequestParam int replyNum, @RequestParam String commentDetail) {
		
		
		logger.info("Notice Update Reply Form Call");
		
		logger.info("boardNum :"+boardNum);
		logger.info("replyNum :"+replyNum);
		logger.info("commentDetail :"+commentDetail);
		model.addAttribute("replyNum", replyNum);
		
		NoticeDTO notdto = notservice.noticedetail(boardNum,"noticedetail");
		model.addAttribute("notice",notdto);
		
		ArrayList<NoticeDTO> noticereplist2 = notservice.noticereplist2(boardNum);
		model.addAttribute("noticereplist", noticereplist2);
		
		NoticeDTO noticereplist = notservice.noticereplist(boardNum, replyNum, commentDetail);
		logger.info("Notice Update List Call");
		logger.info("boardNum : " + noticereplist.getBoardNum());
		logger.info("commentDetail :" +noticereplist.getCommentDetail());
		model.addAttribute("noticerep",noticereplist.getCommentDetail());
		model.addAttribute("noticereplist2",noticereplist);
		
		return "noticerepupdate";		
	}
	
	@RequestMapping(value="/reportreplyupdate.do", method = RequestMethod.GET)
	public String noticerepupdate(Model model,@RequestParam HashMap<String, String> params) {
		
		logger.info("Notice Update Reply Call");
		logger.info("boardNum :"+params);
		
		return notservice.noticerepupdate(params);
	}
		
	@RequestMapping(value="/updateBlind.ajax")
	@ResponseBody
	public void noticeBlindUpdate(@RequestParam("boardNum") int boardNum, @RequestParam("blind") int blind) {
		
		logger.info("noticeBlindUpdate");
		logger.info("boardNum :"+boardNum+"/"+"blind :"+blind);
		
		int row = notservice.noticeBlindUpdate(boardNum,blind);
		logger.info("updateProcess :"+row);
	
	}
}