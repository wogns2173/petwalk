package com.pet.walkroute.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.pet.walkroute.dto.MateFindDTO;
import com.pet.walkroute.dto.RouteListDTO;

import com.pet.walkroute.dto.WalkRouteVO;

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
	public String lineStore(@RequestBody WalkRouteVO vo, HttpSession session) {
		logger.info("list : "+ vo);
		logger.info("latArray : " + vo.getLatArray());
		for (double lat : vo.getLatArray()) {
			logger.info("lat " + lat);
		}
		logger.info("latArray : " + vo.getLngArray());
		for (double lng : vo.getLngArray()) {
			logger.info("lng " + lng);
		}
		logger.info("content : " + vo.getContent());
		logger.info("subject : " + vo.getSubject());
		//logger.info("latArray : " + list.get("list[latArray]"));
		//logger.info("lngArray : " + list.get("list[lngArray]"));
		
		service.routeStore(vo, String.valueOf(session.getAttribute("userID")));
		return "map";
	}
	
	@RequestMapping(value = "/walkroute/routelist.ajax")
	@ResponseBody
	public ArrayList<RouteListDTO> routeList(@RequestParam int mineOrBookmark, HttpSession session) {
		logger.info("flag : " + mineOrBookmark);
		logger.info("id : " + session.getAttribute("userID"));
		return service.routeList(mineOrBookmark,String.valueOf(session.getAttribute("userID")));
	}
	
	@RequestMapping(value = "/walkroute/bringRoute.ajax")
	@ResponseBody
	public ArrayList<RouteListDTO> walkrouteBring(@RequestParam String walkNum) {
		logger.info("walkNum : " + walkNum);
		return service.routeBring(walkNum);
	}
}
