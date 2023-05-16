package com.pet.admin.controller;

import java.util.HashMap;

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
import org.springframework.web.servlet.ModelAndView;

import com.pet.admin.dto.MemManageDTO;
import com.pet.admin.service.MemMangeService;

@Controller
public class MemMangeController {
	
	@Autowired MemMangeService memservice;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value = "/memManageList.go")
	public ModelAndView memList(HttpSession session) {
		
		ModelAndView modelAndView = new ModelAndView();
		logger.info("memManageList page 이동");
		
	    String userID = (String) session.getAttribute("userID");
		String role = (String) session.getAttribute("Role");
	    if (role != null && role.equals("admin")  && userID != null) {
	        modelAndView.setViewName("memManageList");
	        return modelAndView; // 수정된 부분: inquiryList로 이동하고 메서드 종료
	    } else {
	        String errorMessage = "관리자만 입장 가능합니다.";
	        String script = String.format("<script>alert('%s'); history.go(-1); </script>", errorMessage);
	        modelAndView.setViewName("inlineScript");
	        modelAndView.addObject("script", script);
	        return modelAndView; // 수정된 부분: 경고창을 표시하고 메서드 종료
	    }

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