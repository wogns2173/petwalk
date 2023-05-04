package com.pet.walkroute.controller;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pet.walkroute.dao.MateFindDAO;
import com.pet.walkroute.dto.MateFindDTO;
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
		return mateList;
	}
	
	@RequestMapping(value = "/matefind/write.go")
	public String writeGo(Model model) {
		
		return "walkMateListWrite";
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
	
}