package com.pet.board.controller;

import java.awt.List;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.servlet.ModelAndView;

import com.pet.board.dto.BoardDTO;
import com.pet.board.service.BoardService;

@Controller
public class BoardController {
	
	@Autowired BoardService service;
	BoardDTO dto = new BoardDTO();
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	// 메인 보드 페이지
	@RequestMapping(value = "/board")
	public String board(Model model) {
		ArrayList<BoardDTO> boardList = service.boardList();
		//ArrayList<BoardDTO> boardPhotoList = service.boardPhotoList();
		model.addAttribute("boardList", boardList);
		//model.addAttribute("boardPhotoList",boardPhotoList);
		return "boardList";
	}
	
	// 카테고리별 보드 리스트 페이지
	@RequestMapping(value = "/boardList.go")
	public String boardInfoList(Model model,@RequestParam String categoryCode) {
		logger.info("categoryCode: "+categoryCode);
		String page = "boardList";
		logger.info(categoryCode);
		if(categoryCode.equals("B_01")) {
			page ="boardPhotoList";
		}else if(categoryCode.equals("B_02")) {
			page ="boardInfoList";
		}else if(categoryCode.equals("B_03")) {
			page ="boardQnaList";
		}else if(categoryCode.equals("B_04")) {
			page = "boardLoseList";
		}
		return page;
	}
	
	// 카테고리별 보드 리스트 보기 ajax
	@RequestMapping(value="/boardList.ajax")
	@ResponseBody
	public HashMap<String, Object> list(@RequestParam String page, @RequestParam String cnt,
			@RequestParam String categoryCode, @RequestParam String boardSearch, @RequestParam String search
			,HttpSession ssesion){
		logger.info("boardList Controller!");
		logger.info("categoryCode: "+categoryCode+"boardSearch:"+boardSearch+"search:"+search);
		
		return service.list(Integer.parseInt(page),Integer.parseInt(cnt),categoryCode,boardSearch,search);
	}
	
	// 글쓰기 페이지 이동
	@RequestMapping(value = "/boardWrite.go", method=RequestMethod.GET)
	public ModelAndView boardWriteForm(Model model,@RequestParam String categoryCode, HttpSession session) {
		logger.info("writeForm");
		//String page = "redirect:/boardList.go?categoryCode="+categoryCode;
		logger.info("write categoryCode: "+categoryCode);
		
		ModelAndView modelAndView = new ModelAndView();
		
		logger.info("{}",session.getAttribute("userID"));
		String userID = (String) session.getAttribute("userID");
		
		if(session.getAttribute("userID") != null) {
			model.addAttribute("categoryCode", categoryCode);
			model.addAttribute("userID",userID);
			modelAndView.setViewName("boardWrite");
		}else {
			String alertMessage = "로그인이 필요합니다.";
			String script = String.format("<script>alert('%s'); history.go(-1);</script>", alertMessage);
			modelAndView.setViewName("inlineScript");
			modelAndView.addObject("script", script);

		}
		
		
		return modelAndView;
	}

	// 글 작성하기
	@RequestMapping(value = "/boardWrite.do", method = RequestMethod.POST)
	public String boardWrite(MultipartFile photo, 
			@RequestParam HashMap<String, String> params, HttpSession session,@RequestParam String userID) {
		logger.info("params:{}",params);
		logger.info("photo : " + photo);
		return service.boardWrite(photo,params,session,userID);
	}
	
	// 글 상세보기
	@RequestMapping(value = "/boardDetail.do")
	public String boardDetail(Model model, @RequestParam String boardNum,HttpSession session) {
		String page= "boardDetail";
		logger.info(boardNum);
		
		BoardDTO dto = service.boardDetail(boardNum,"boardDetail");
		logger.info("dto :"+dto);
		if(dto !=null) {
			model.addAttribute("dto", dto);
			logger.info("dtoUserID: "+dto.getUserID());
		}
		ArrayList<BoardDTO> boardRepList = service.boardRepList2(boardNum);
		logger.info("boardRepList Call");
		model.addAttribute("boardRepList", boardRepList);
		logger.info("photo : "+dto.getSerPhotoname());
		
		String userID = (String) session.getAttribute("userID");
		logger.info(userID);
		
		// 이미 위에서 userID 를 지정해주었기 때문에 setAttribute 는 안해줘도 된다.
		//session.setAttribute("userID", userID);
		
		return page;
	}
	
	// 글 블라인드 처리하기
	@RequestMapping(value = "/boardDelete.do")
	public String boardDelete(@RequestParam String boardNum,@RequestParam String categoryCode) {
		logger.info(boardNum);
		service.boardDelete(boardNum);
		logger.info(categoryCode);
		return "redirect:/boardList.go?categoryCode="+categoryCode;

	}
	
	// 글 수정폼 이동
	@RequestMapping(value = "/boardUpdate.go")
	public String boardUpdate(Model model,@RequestParam String categoryCode,@RequestParam String boardNum
			,HttpSession session) {
		logger.info("update boardNum: "+boardNum);
		logger.info("update categoryCode: "+categoryCode);

		String page = "redirect:/boardList";
		
		
		BoardDTO dto = service.boardDetail(boardNum, "boardUpdate");
		if(dto.isPhotoBlindWhether() == true) {
			logger.info("업데이트 완료");
		}
		
		if(dto != null) {
			page ="boardUpdate";
			model.addAttribute("dto",dto);
		}

		String userID = (String) session.getAttribute("userID");
		
		if(dto != null/* || userID.equals(dto.getUserID())*/) { //작성자와 로그인한 사용자가 같은 경우
			page ="boardUpdate";
			model.addAttribute("dto",dto);
		}

		return page;

	}
	
	// 글 수정하기
	@RequestMapping(value = "/boardUpdate.do")
	public String boardUpdate(MultipartFile photo, 
			@RequestParam HashMap<String, String> params
			,@RequestParam(value = "deletePhoto", defaultValue = "false") boolean deletePhoto) {
		logger.info("update params:{}",params);
		logger.info("update photo: "+photo);
		logger.info("deletePhoto: "+deletePhoto);
		return service.boardUpdate(photo,params,deletePhoto);
	}

	
	// 댓글 작성하기
		@RequestMapping(value="/boardRepWrite.do", method = RequestMethod.POST)
		public String inquiryreplywrite(Model model,@RequestParam int boardNum, @RequestParam String content
				,HttpSession session) {
			logger.info("Board Reply Write Call");
			
			logger.info("boardNum :"+boardNum);
			logger.info("content :"+content);
			
			String userID = (String) session.getAttribute("userID");
			logger.info("userID: "+userID);
			
			int row = service.boardRepWrite(boardNum,content,userID);
			logger.info("reply write row: "+row);
			
			return "redirect:/boardDetail.do?boardNum="+boardNum;
		}
		
	// 댓글 리스트 
	@RequestMapping(value="/boardRepUpdate.go", method = RequestMethod.GET)
	public String inquiryrepupdateform(Model model, @RequestParam String boardNum, @RequestParam int replyNum
			,HttpSession session) {
		
		logger.info("board Reply UpdateForm Call");
		
		logger.info("boardNum :"+boardNum);
		logger.info("replyNum :"+replyNum);
		model.addAttribute("replyNum", replyNum);
		
		BoardDTO dto = service.boardDetail(boardNum,"boardDetail");
		model.addAttribute("dto",dto);
		
		ArrayList<BoardDTO> boardRepList2 = service.boardRepList2(boardNum);
		model.addAttribute("boardRepList", boardRepList2);
		
		BoardDTO boardRepList = service.boardRepList(boardNum, replyNum);
		logger.info("boardReplist Call");
		logger.info("boardNum : " + boardRepList.getBoardNum());
		model.addAttribute("boardRepList2",boardRepList);
		String userID = (String) session.getAttribute("userID");
		
		return "boardRepUpdate";
	}
	
	// 댓글 수정하기
	@RequestMapping(value="/boardRepUpdate.do", method = RequestMethod.GET)
	public String inquiryrepupdate(Model model,@RequestParam HashMap<String, String> params) {
		
		logger.info("boardRepUpdate Reply Call");
		logger.info("boardNum :"+params);
		
		return service.boardRepUpdate(params);
	}
	
	// 댓글 블라인드 처리하기
	@RequestMapping(value="/boardRepDel.do", method = RequestMethod.GET)
	public String inquiryrepwrite(Model model, @RequestParam int replyNum,@RequestParam int boardNum) {
		logger.info("board Delete Reply Call");
		logger.info("replyNum :"+replyNum);
		logger.info("boardNum :"+boardNum);
		
		service.boardRepDel(replyNum);
		return "redirect:/boardDetail.do?boardNum="+boardNum;
	}
	
}