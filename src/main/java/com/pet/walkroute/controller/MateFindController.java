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

import com.pet.walkroute.dao.MateFindDAO;
import com.pet.walkroute.service.MateFindService;


@Controller
public class MateFindController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired MateFindService service;
	
	@RequestMapping(value = "/matefind/list")
	public String home(Locale locale, Model model) {
		ArrayList<MateFindDAO> dong = service.dong();
		logger.info("dong : " + dong);
		model.addAttribute("list",dong);
		
		return "walkMateList";
	}
	
}