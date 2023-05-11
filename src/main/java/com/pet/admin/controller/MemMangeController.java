package com.pet.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pet.admin.dto.InquiryDTO;
import com.pet.admin.dto.MemManageDTO;
import com.pet.admin.service.MemMangeService;

@Controller
public class MemMangeController {
	
	@Autowired MemMangeService memservice;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value = "/memManageList.go")
	public String memList() {
		logger.info("memManageList page 이동");
		
		return "memManageList";
	}

	@RequestMapping(value="/memlist.ajax")
	@ResponseBody
	public HashMap<String, Object> memManagelist(@RequestParam HashMap<String,Object> params) {
		logger.info("memManage List Call");
		
		return memservice.memlist(params);
	}
	
	@RequestMapping(value = "/memMangeDetail.go")
	public String memmemMangeDetail(Model model , @RequestParam String userID) {
		
		logger.info("memManage Detail Page 이동");
		logger.info("userID :"+userID);
		
		MemManageDTO memdto = memservice.memdetail(userID);
		
		model.addAttribute("mem",memdto);
		
		return "memManageDetail";
	}
	
	@RequestMapping(value="/memManageProcess.go", method = RequestMethod.POST)
	public String memManageProcess(@RequestParam Boolean selectedValue, @RequestParam String userID) {
		
		logger.info("memManage Process Update Call");
		logger.info("selectedValue :"+selectedValue+"/"+"boardNum :"+userID);
	
		return memservice.memprocessupdate(selectedValue,userID);
	}
}