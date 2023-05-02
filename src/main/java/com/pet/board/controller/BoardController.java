package com.pet.board.controller;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.pet.board.dao.boardDAO;
import com.pet.board.dto.boardDTO;
import com.pet.board.service.BoardService;

@Controller
public class BoardController {
	
	@Autowired BoardService service;
	@Autowired boardDAO dao;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value = "/board")
	public String home(Model model) {
		logger.info("list call");
		ArrayList<boardDTO> B_02list = service.B_02list();
		
		model.addAttribute("B_02list", B_02list);
		return "boardList";
	}
	
	@RequestMapping(value = "/boardB_02list.do")
	public String boardInfoList(Model model) {
		logger.info("boardB_02list.do");
		ArrayList<boardDTO> B_02list = service.B_02list();
		model.addAttribute("B_02list", B_02list);
		return "boardInfoList";
	}
	
	@RequestMapping(value = "/boardWrite.go", method=RequestMethod.GET)
	public String boardWriteForm(Model model) {
		logger.info("writeForm");
		return "boardWrite";
	}

/*
	@RequestMapping(value = "/boardWrite.do")
	public String boardWrite(Model model,@RequestParam("boardName")String boardName
			,@RequestParam("boardDetail")String boardDetail
			,@RequestParam("categoryCode")String categoryCode
			,@RequestParam("photo") String photo
			,HttpSession session) {
		logger.info("controller boardWrite.do!");
		String userID = (String) session.getAttribute("loginId");
		logger.info(userID);
		
		return service.boardWrite(photo,userID,boardName,boardDetail,categoryCode,session);
	}
*/
	
	@RequestMapping(value = "/boardWrite.do", method = RequestMethod.POST)
	public String boardWrite(MultipartFile photo, 
			@RequestParam HashMap<String, String> params) {
		logger.info("params:{}",params);
		/* String categoryCode = params.get("categoryCode");
		 String boardName = params.get("boardName");
		 String boardDetail = params.get("boardDetail");
		 logger.info(categoryCode+"/"+boardName+"/"+boardDetail);
		 */
		
		return service.boardWrite(photo,params);
	}
	
	@RequestMapping(value = "/boardDetail.do")
	public String boardDetail(Model model, @RequestParam String boardNum) {
		logger.info("controller boardDetail: "+boardNum);
		boardDTO dto = service.boardDetail(boardNum);
		logger.info("dto :"+dto);
		model.addAttribute("dto", dto);
		
		return "boardDetail";
	}
}