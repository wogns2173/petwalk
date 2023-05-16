package com.pet.main.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.annotation.SessionScope;

@Controller
public class MainController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value = "/")
	public String home(Model model, HttpSession session) {
		
		model.addAttribute("msg", "main");
		return "home";
	}
	
	@RequestMapping(value = "adminPage.go")
	public String adminPage(Model model, HttpSession session) {
		
		String Role = (String) session.getAttribute("Role");
		String page = "redirect:/";
		logger.info(Role);
		if(Role.equals("admin")) {
			page = "adminPage";
		}
					
		
		return page;
	}
	
	@RequestMapping(value = "/matefind/popup", method = RequestMethod.GET)
	public String popup(Locale locale, Model model) {		
				
		return "popup";
	}
}