package com.pet.mypage.controller;



import java.util.ArrayList;
import java.util.HashMap;

import javax.mail.Session;
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
import org.springframework.web.context.annotation.RequestScope;
import org.springframework.web.multipart.MultipartFile;


import com.pet.mypage.dto.MyPageDTO;
import com.pet.mypage.service.MyPageService;


@Controller
public class MyPageController {
	
	@Autowired MyPageService service;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
			
	@RequestMapping(value="/profile.go")
	   public String profile(HttpSession session, Model model) {
		
		String page = "redirect:/";	
		
		 if(session.getAttribute("userID") != null) {
			 String userID = (String) session.getAttribute("userID");
			 
			 // 반려견 정보
			 MyPageDTO dto = service.findprofileAndphoto(userID);				 
			 model.addAttribute("pet", dto);
			 
			 page = "profile";
		 }
		  
		  
	      return page;      
	   }
	
	@RequestMapping(value="/petprofileWrite.go")
	   public String petprofileWrite() {
		   		
	      return "profileWrite";      
	   }
	
	@RequestMapping(value="/petprofilecreate.ajax")
	@ResponseBody
	   public HashMap<String, Object> petprofilecreate(@RequestParam HashMap<String, String> params, MultipartFile photo, HttpSession session){
		
		   logger.info("{}",params);
		   logger.info("{}",photo);
		   
		   
	      return service.petprofilecreate(params, photo, session);      
	   }
	
	
	@RequestMapping(value="/petprofileUpdate.go")
	   public String petprofileUpdate(HttpSession session, Model model) {
		
		String page = "redirect:/";	
		
		 if(session.getAttribute("userID") != null) {
			 String userID = (String) session.getAttribute("userID");
			 MyPageDTO dto = service.findprofileAndphoto(userID);				 
			 model.addAttribute("pet", dto);
			 
			 page = "profileUpdate";
		 }
		   		
	      return page;      
	   }
	
	@RequestMapping(value="/petprofileUpdate.ajax")
	@ResponseBody
	   public HashMap<String, Object> petprofileUpdate(@RequestParam HashMap<String, String> params, MultipartFile photo, HttpSession session){		
		
		   logger.info("{}",params);
		   logger.info("{}",photo);
		   
		   
		   return service.petprofileUpdate(params, photo, session);      
	   }
	
	@RequestMapping(value="/petphoto.ajax")
	@ResponseBody
	   public HashMap<String, Object> petphoto(MultipartFile photo, HttpSession session){		
				   
		   logger.info("{}",photo);		   
		   
		   return service.petphoto(photo, session);      
	   }
	
	@RequestMapping(value="/otherprofile.go")
	   public String otherprofile(@RequestParam String userID, Model model) {
		
			String page = "otherprofile";	
					 
			 MyPageDTO dto = service.findprofileAndphoto(userID);				 
			 model.addAttribute("pet", dto);
			 
			 model.addAttribute("userID", userID);
			 

		  		  
	      return page;      
	   }
	
	@RequestMapping(value="/myroutlistCall.ajax", method= RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object>myroutlistCall(
			HttpSession session,
			@RequestParam String page,
			@RequestParam String cnt){
		logger.info("옴?");
		
		return service.myroutlistCall(Integer.parseInt(page),Integer.parseInt(cnt),session);
	}
	
	@RequestMapping(value="/mybookmarklistCall.ajax", method= RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object>mybookmarklistCall(
			HttpSession session,
			@RequestParam String page,
			@RequestParam String cnt){
		logger.info("옴?");
		
		return service.mybookmarklistCall(Integer.parseInt(page),Integer.parseInt(cnt),session);
	}
	
	@RequestMapping(value="/myreviewlistCall.ajax", method= RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object>myreviewlistCall(
			HttpSession session,
			@RequestParam String page,
			@RequestParam String cnt){
		logger.info("옴?");
		
		return service.myreviewlistCall(Integer.parseInt(page),Integer.parseInt(cnt),session);
	}
	
	
	@RequestMapping(value="/myinquirylistCall.ajax", method= RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object>myinquirylistCall(
			HttpSession session,
			@RequestParam String page,
			@RequestParam String cnt){
		logger.info("옴?");
		
		return service.myinquirylistCall(Integer.parseInt(page),Integer.parseInt(cnt),session);
	}
	
	@RequestMapping(value="/myreportlistCall.ajax", method= RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object>myreportlistCall(
			HttpSession session,
			@RequestParam String page,
			@RequestParam String cnt){
		logger.info("옴?");
		
		return service.myreportlistCall(Integer.parseInt(page),Integer.parseInt(cnt),session);
	}
	
	@RequestMapping(value="/otroutesharelistCall.ajax", method= RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object>otroutesharelistCall(			
			@RequestParam String page,
			@RequestParam String cnt,
			@RequestParam String userID){
		
		logger.info("제발" + userID);
					
		return service.otroutesharelistCall(Integer.parseInt(page),Integer.parseInt(cnt),userID);
	}
	
	@RequestMapping(value="/otreviewlistCall.ajax", method= RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object>otreviewlistCall(
			@RequestParam String page,
			@RequestParam String cnt,
			@RequestParam String userID){
		logger.info("옴?");
		
		return service.otreviewlistCall(Integer.parseInt(page),Integer.parseInt(cnt),userID);
	}
	
	@RequestMapping(value="/deletemr.ajax", method= RequestMethod.GET)
	@ResponseBody
	public HashMap<String, Object>deletemr(
			@RequestParam(value="delList[]") ArrayList<String> delList,
			HttpSession session){
		logger.info("delList : "+delList);
		
		return service.deletemr(delList, session);
	}	
	
	@RequestMapping(value="/matefind/application.ajax")
	@ResponseBody
	public HashMap<String, Object>application(HttpSession session, @RequestParam String mateWalkNum){
		
		String userID = (String) session.getAttribute("userID");
		
		return service.application(mateWalkNum, userID);
	}
	
	@RequestMapping(value="/matefind/cancel.ajax")
	@ResponseBody
	public HashMap<String, Object>cancel(HttpSession session, @RequestParam String mateWalkNum){
		
		String userID = (String) session.getAttribute("userID");
		
		return service.cancel(mateWalkNum, userID);
	}
	
	@RequestMapping(value="/matefind/applicantlist.ajax")
	@ResponseBody
	public HashMap<String, Object>applicantlist(@RequestParam String mateWalkNum){
				
		return service.applicantlist(mateWalkNum);
	}
}