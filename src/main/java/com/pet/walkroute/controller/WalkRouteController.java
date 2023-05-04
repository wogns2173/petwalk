package com.pet.walkroute.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.pet.walkroute.dto.routeListDTO;
import com.pet.walkroute.service.WalkRouteService;

import jdk.nashorn.internal.parser.JSONParser;

@Controller
public class WalkRouteController {
	
	@Autowired WalkRouteService service;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value = "/walkroute/routedraw")
	public String home(Model model) {
		model.addAttribute("msg", "routeshare");
		return "routeDraw";
	}
	
	@RequestMapping(value = "/walkroute/line.ajax")
	@ResponseBody
	public String lineStore(@RequestParam HashMap<String, String> list) {
		ObjectMapper mapper = new ObjectMapper();
		JSONParser parser = new JSONParser(null, null, false);
       // Object obj = parser.parse(list.get("list[lineList]"));
		logger.info("list : "+list);
		logger.info("list : lineList : " + list.get("list[lineList]"));
		logger.info("list : lineList type? : " + list.get("list[lineList]").getClass());
		//List<routeListDTO> lineList = Arrays.asList(mapper.readValue(list.get("list[lineList]"), routeListDTO[].class));
		logger.info("list : subject : " + list.get("list[subject]"));
		logger.info("list : content : " + list.get("list[content]"));
		return "map";
	}
}
