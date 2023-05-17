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
	public String list(@RequestParam String walkRouteType, Model model) {
		model.addAttribute("walkRouteType", walkRouteType);
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
		logger.info("flag : " + params.get("flag"));
		String userID = String.valueOf(session.getAttribute("userID"));
		params.put("userID", userID);
		routeShareService.write(userID, params);
		String page = "공유";
		if(String.valueOf(session.getAttribute("Role")).equals("user")) {
			page="share";
		} else {
			page="recommend";
		}
		return "redirect:/routeshare/list?walkRouteType="+page;
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
	
	@RequestMapping(value = "/routeshare/listBring.ajax" )
	@ResponseBody
	public HashMap<String, Object> listBringAjax(
			@RequestParam String page, @RequestParam String cnt, @RequestParam String walkRouteType, HttpSession session) {
		logger.info("role : " + String.valueOf(session.getAttribute("Role")));
		return routeShareService.list(Integer.parseInt(page),Integer.parseInt(cnt), walkRouteType);
	}
	
	@RequestMapping(value = "/routeshare/detail.go")
	public String detailGo(@RequestParam String walkRouteNum, Model model) {
		logger.info("walkRouteNum : " + walkRouteNum);
		RouteShareDTO dto = routeShareService.detail(Integer.parseInt(walkRouteNum));
		ArrayList<RouteListDTO> list = walkRouteService.routeBring(String.valueOf(dto.getWalkNum()));
		
		model.addAttribute("coordinate", list);
		model.addAttribute("list", dto);
		
		logger.info("dto : " + dto);
		logger.info("list : " + list);
		return "routeShareDetail";
	}
	
	@RequestMapping(value = "/routeshare/recommend.ajax", produces="application/text; charset=UTF-8")
	@ResponseBody
	public String rocommendAjax(@RequestParam String walkRouteNum, HttpSession session) {
		String userID = String.valueOf(session.getAttribute("userID"));
		return routeShareService.recommend(walkRouteNum, userID);
	}
	
	@RequestMapping(value = "/routeshare/bookmark.ajax", produces="application/text; charset=UTF-8")
	@ResponseBody
	public String bookrmarkAjax(@RequestParam String walkNum, HttpSession session) {
		String userID = String.valueOf(session.getAttribute("userID"));
		return routeShareService.bookmark(walkNum, userID);
	}
	
	@RequestMapping(value = "/routeshare/delete.do")
	public String deleteDo(@RequestParam String walkRouteNum, Model model) {
		routeShareService.delete(walkRouteNum);
		return "redirect:/routeshare/list";
	}
	
	@RequestMapping(value = "/routeshare/update.go")
	public String updateDo(@RequestParam String walkRouteNum, Model model) {
		logger.info("walkRouteNum : " + walkRouteNum);
		RouteShareDTO dto = routeShareService.detail(Integer.parseInt(walkRouteNum));
		ArrayList<RouteListDTO> list = walkRouteService.routeBring(String.valueOf(dto.getWalkNum()));
		
		model.addAttribute("dto", dto);
		model.addAttribute("list", list);
		logger.info("dto : " + dto);
		logger.info("list : " + list);
		return "routeShareUpdate";
	}
	
	@RequestMapping(value = "/routeshare/addressFilter.ajax")
	@ResponseBody
	public HashMap<String, Object> addressFilterAjax(@RequestParam HashMap<String, Object> params) {
		logger.info("params: " + params);
		return routeShareService.addressFilter(params);
	}
	
	@RequestMapping(value = "/routeshare/subjectOrIdFilter.ajax")
	@ResponseBody
	public HashMap<String, Object> subjectOrIdFilterAjax(@RequestParam HashMap<String, Object> params) {
		logger.info("params: " + params);
		return routeShareService.subjectOrIdFilter(params);
	}
}