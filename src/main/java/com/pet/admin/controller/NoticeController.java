package com.pet.admin.controller;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class NoticeController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value = "/notice")
	public String home(Locale locale, Model model) {
		model.addAttribute("msg", "notice");
		return "home";
	}
	
}