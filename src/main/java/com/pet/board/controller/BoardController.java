package com.pet.board.controller;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.pet.board.dto.boardDTO;
import com.pet.board.service.BoardService;

@Controller
public class BoardController {
	
	@Autowired BoardService service;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value = "/board")
	public String home(Model model) {
		System.out.println("board controller");
		logger.info("list call");
		ArrayList<boardDTO> B_02list = service.B_02list();
		
		model.addAttribute("B_02list", B_02list);
		return "boardList";
	}
	
	@RequestMapping(value = "/boardB_02list.do")
	public String boardInfoList(Model model) {
		logger.info("지식공유게시판 리스트 컨트롤러 완료");
		ArrayList<boardDTO> B_02list = service.B_02list();
		model.addAttribute("B_02list", B_02list);
		return "boardInfoList";
	}
	
	@RequestMapping(value = "/boardWrite.go", method=RequestMethod.GET)
	public String boardWriteForm(Model model) {
		logger.info("writeForm");
		return "boardWrite";
	}
	
	@RequestMapping(value = "/boardWrite.do")
	public String boardWrite(Model model,@RequestParam HashMap<String, String> params) {
		logger.info("write.do:"+params);
		return service.boardWrite(params);
	}
	
}