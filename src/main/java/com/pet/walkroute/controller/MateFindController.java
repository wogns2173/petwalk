package com.pet.walkroute.controller;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pet.walkroute.dao.MateFindDAO;
import com.pet.walkroute.dto.MateFindDTO;
import com.pet.walkroute.dto.MateListDetailDTO;
import com.pet.walkroute.dto.MessageDTO;
import com.pet.walkroute.service.MateFindService;


@Controller
public class MateFindController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired MateFindService service;
	
	@RequestMapping(value = "/matefind/marker")
	public String marker(Model model) {
		ArrayList<MateFindDTO> dong = service.dong();
		logger.info("dong : " + dong);
		model.addAttribute("list",dong);
		
		return "walkMateList";

	}
	
	@RequestMapping(value = "/matefind/list")
	public String list(Model model) {
		ArrayList<MateFindDTO> dong = service.dong();
		logger.info("dong : " + dong);
		model.addAttribute("list",dong);
		
		return "walkMateList";
	}
	
	@RequestMapping(value = "/matefind/markerlist.ajax")
	@ResponseBody
	public ArrayList<MateFindDTO> markerList(@RequestParam String dong) {
		logger.info("param : " + dong);
		ArrayList<MateFindDTO> mateList = service.mateList(dong);
		for (int i = 0; i < mateList.size(); i++) {	
			logger.info("walkNum : " + mateList.get(i).getMateWalkNum());
		}
		return mateList;
	}
	
	@RequestMapping(value = "/matefind/write.go")
	public String writeGo(Model model) {
		
		return "walkMateListWrite";
	}
	
	@RequestMapping(value = "/matefind/write.do")
	public String writeDo(@RequestParam HashMap<String, Object> params, HttpSession session) {
		logger.info("params : " + params);
		logger.info("userID : " + session.getAttribute("userID"));
		params.put("userID", session.getAttribute("userID"));
		service.mateInsert(params);
		return "redirect:/matefind/list";
	}
	
	@RequestMapping(value = "/matefind/silist.ajax")
	@ResponseBody
	public ArrayList<MateFindDTO> siList() {
		ArrayList<MateFindDTO> siList = service.siList();
		return siList;
	}
	
	@RequestMapping(value = "/matefind/gulist.ajax")
	@ResponseBody
	public ArrayList<MateFindDTO> guList(@RequestParam String siID) {
		ArrayList<MateFindDTO> guList = service.guList(siID);
		return guList;
	}
	
	@RequestMapping(value = "/matefind/donglist.ajax")
	@ResponseBody
	public ArrayList<MateFindDTO> dongList(@RequestParam String guID) {
		ArrayList<MateFindDTO> dongList = service.dongList(guID);
		return dongList;

	}
	
	@RequestMapping(value = "/matefind/listDetail.do")
	public String listDetail(@RequestParam String mateWalkNum, Model model) {
		String flag = "detail";
		logger.info(mateWalkNum, flag);
		MateListDetailDTO list = service.detail(mateWalkNum, flag);
		logger.info("walkNum : " + list.getWalkNum());
		ArrayList<MateListDetailDTO> coordinate = service.coordinate(list.getWalkNum());
		logger.info("list" + list);
		logger.info("coordinate : " + coordinate);
		model.addAttribute("list", list);
		model.addAttribute("coordinate", coordinate);
		logger.info("lat : " + coordinate.get(0).getLat());
		logger.info("lng : " + coordinate.get(0).getLng());
		return "walkMateListDetail";
	}
	
	@RequestMapping(value = "/matefind/message.go")
	public String messageGo(@RequestParam String userID,@RequestParam String mateWalkNum, Model model, HttpSession session) {
		logger.info("receiveID : " + userID);
		logger.info("mateWalkNum : " + mateWalkNum);
		logger.info("sendID : " + String.valueOf(session.getAttribute("userID")));
		model.addAttribute("receiveID", userID);
		model.addAttribute("mateWalkNum", mateWalkNum);
		
		return "messageList";
	}
	
	@RequestMapping(value = "/matefind/messageListSender.ajax")
	@ResponseBody
	public ArrayList<MessageDTO> massageListSenderAjax(@RequestParam String sendID) {
		ArrayList<MessageDTO> messageList = service.messageSendList(sendID);
		return messageList;

	}
	
	@RequestMapping(value = "/matefind/messageListReceiver.ajax")
	@ResponseBody
	public ArrayList<MessageDTO> massageListReceiverAjax(@RequestParam String receiveID) {
		ArrayList<MessageDTO> messageList = service.messageReceiveList(receiveID);
		return messageList;

	}
	
	@RequestMapping(value = "/matefind/messageHistory.ajax")
	@ResponseBody
	public ArrayList<MessageDTO> messageHistoryAjax(@RequestParam String mateWalkNum) {
		logger.info("mateWalkNum : " + mateWalkNum);
		ArrayList<MessageDTO> messageList = service.messageHistory(mateWalkNum);
		return messageList;

	}
	
	@RequestMapping(value = "/matefind/messageSend.ajax")
	@ResponseBody
	public String messageSendAjax(@RequestParam HashMap<String, Object> params, HttpSession session) {
		logger.info("params : " + params);
		String sendID = String.valueOf(session.getAttribute("userID"));
		service.messageSend(params);
		return "success";

	}
}