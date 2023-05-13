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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pet.walkroute.dto.MateListDetailDTO;
import com.pet.walkroute.dto.RouteListDTO;
import com.pet.walkroute.dto.RouteShareDTO;
import com.pet.walkroute.service.RouteShareService;
import com.pet.walkroute.service.WalkRouteService;

@Controller
public class RouteShareController {
	
	@Autowired WalkRouteService walkRouteService;
	@Autowired RouteShareService routeShareService;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value = "/routeshare/list") 
	public String list() {
		return "routeShareList";
	}
	
	@RequestMapping(value = "/routeshare/bring.go")
	public String bringGo() {
		return "routeShareBring";
	}
	
	@RequestMapping(value = "/routeshare/routelist.ajax")
	@ResponseBody
	public ArrayList<RouteListDTO> listAjax(HttpSession session) {
		String userID = String.valueOf(session.getAttribute("userID"));
		return walkRouteService.routeList(userID);
	}
	
	@RequestMapping(value = "/routeshare/write.go")
	public String writeGo(@RequestParam String walkNum, Model model) {
		logger.info("walkNum : " + walkNum);
		ArrayList<RouteListDTO> list = walkRouteService.routeBring(walkNum);
		model.addAttribute("list", list);
		return "routeShareWrite";
	}
	
	@RequestMapping(value = "/routeshare/routeShareInsert.do")
	public String routeShareInsertDo(@RequestParam HashMap<String, Object> params, HttpSession session) {
		logger.info("params : " + params);
		logger.info("userID : " + session.getAttribute("userID"));
		String userID = String.valueOf(session.getAttribute("userID"));
		params.put("userID", userID);
		routeShareService.write(userID, params);
		return "redirect:/routeshare/list";
	}
	
	@RequestMapping(value = "/routeshare/sigudong.ajax")
	@ResponseBody
	public HashMap<String, String> sigudongAjax(@RequestParam HashMap<String, Object> params) {
		logger.info("params : " + params);
		logger.info("siName : " + params.get("siGuDong[siName]"));
		logger.info("guName : " + params.get("siGuDong[guName]"));
		logger.info("dongName : " + params.get("siGuDong[dongName]"));
		
		return routeShareService.sigudong(params);
	}
	
	@RequestMapping(value = "/routeshare/listBring.ajax")
	@ResponseBody
	public HashMap<String, Object> listBringAjax(@RequestParam String page, @RequestParam String cnt) {
		return routeShareService.list(Integer.parseInt(page),Integer.parseInt(cnt));
	}
	
	@RequestMapping(value = "/routeshare/detail.go")
	public String detailGo(@RequestParam String walkRouteNum, Model model) {
		logger.info("walkRouteNum : " + walkRouteNum);
		RouteShareDTO dto = routeShareService.detail(Integer.parseInt(walkRouteNum));
		ArrayList<RouteListDTO> list = walkRouteService.routeBring(String.valueOf(dto.getWalkNum()));
		
		model.addAttribute("coordinate", list);
		model.addAttribute("list", dto);
		return "routeShareDetail";
	}
	
	@RequestMapping(value = "/routeshare/bookmark.do")
	public String bookmark(@RequestParam String walkNum, HttpSession session, Model model) {
		
		logger.info("walkNum : " + walkNum);
		String userID = (String) session.getAttribute("userID");
		
		int success = routeShareService.bookmark(walkNum, userID);
		model.addAttribute("success",success);
		return "routeShareDetail";
	}
}