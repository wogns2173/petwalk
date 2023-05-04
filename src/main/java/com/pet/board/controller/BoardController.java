package com.pet.board.controller;

import java.awt.List;
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
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.pet.board.dto.BoardDTO;
import com.pet.board.service.BoardService;

@Controller
public class BoardController {
	
	@Autowired BoardService service;
	BoardDTO dto = new BoardDTO();
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value = "/board")
	public String board(Model model) {
		ArrayList<BoardDTO> B_02list = service.B_02list();
		model.addAttribute("B_02list", B_02list);
		return "boardList";
	}
	
	@RequestMapping(value = "/boardB_02list.do")
	public String boardInfoList(Model model) {
		ArrayList<BoardDTO> B_02list = service.B_02list();
		model.addAttribute("B_02list", B_02list);
		return "boardInfoList";
	}
	
	@RequestMapping(value = "/boardQnaList.go")
	public String boardQnaList(Model model) {
		return "boardQnaList";
	}
	
	@RequestMapping(value="/boardList.ajax")
	@ResponseBody
	public HashMap<String, Object> list(@RequestParam String page, @RequestParam String cnt){
		logger.info("B_03List Controller!");
		return service.B_03List(Integer.parseInt(page),Integer.parseInt(cnt));
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
		String page= "boardDetail";
		logger.info(boardNum);
		BoardDTO dto = service.boardDetail(boardNum,"boardDetail");
		logger.info("dto :"+dto);
		if(dto !=null) {
			model.addAttribute("dto", dto);
		}
		logger.info("photo : "+dto.getSerPhotoname());
		//model.addAttribute("boardNum", boardNum);
		return page;
	}
	
	@RequestMapping(value = "/boardDelete.do")
	public String boardDelete(@RequestParam String boardNum) {
		logger.info(boardNum);
		service.boardDelete(boardNum);
		return "redirect:/board";

	}
	
	@RequestMapping(value = "/boardUpdate.go")
	public String boardUpdate(Model model,@RequestParam String categoryCode,@RequestParam String boardNum
			) {
		logger.info("update boardNum: "+boardNum);
		logger.info("update categoryCode: "+categoryCode);
		String page = "redirect:/board.do";
		
		BoardDTO dto = service.boardDetail(boardNum, "boardUpdate");
		if(dto != null) {
			page ="boardUpdate";
			model.addAttribute("dto",dto);
		}
		return page;

	}
	
	@RequestMapping(value = "/boardUpdate.do")
	public String boardUpdate(MultipartFile photo, 
			@RequestParam HashMap<String, String> params) {
		logger.info("update params:{}",params);
		logger.info("update photo: "+photo);
		return service.boardUpdate(photo,params);
	}

	@RequestMapping(value="/photoDelete.do")
	public String photoDelete(@RequestParam String serPhotoname,@RequestParam String categoryCode,@RequestParam int boardNum) {
		logger.info("delete:"+serPhotoname+"/"+categoryCode+"/"+boardNum);
		String page = service.photoDelete(serPhotoname,categoryCode,boardNum);
		return page;
	}

}