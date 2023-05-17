package com.pet.member.controller;

import java.util.HashMap;


import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pet.member.dto.MemberDTO;
import com.pet.member.service.MemberService;

@Controller
public class MemberController {
	
	@Autowired MemberService service;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value="/join.go")
	   public String joinForm() {
		
	      return "joinForm";      
	   }

	   @RequestMapping(value="/overlayid.ajax")
	   @ResponseBody
	   public HashMap<String, Object> overlayid(@RequestParam String userID){
		   logger.info("overlayid : "+userID);
		   
	      return service.overlayid(userID);      
	   }
	   
	   @RequestMapping(value="/overlaypw.ajax")
	   @ResponseBody
	   public HashMap<String, Object> overlaypw(@RequestParam String changeuserPW,HttpSession session){
		   
		   
		   HashMap<String, Object> map = new HashMap<String, Object>();
		   String userPW = (String) session.getAttribute("userPW");
		   logger.info(changeuserPW);
		   logger.info("{}"+ session.getAttribute("userPW"));
		   
		   BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();			
		   boolean isMatched = encoder.matches(changeuserPW, userPW);
		   logger.info("?"+isMatched);
		  
		   if(isMatched == true) {
			   map.put("overlaypw", isMatched);
		   }
				   		   		   		   
	      return map;      
	   }
	   
	   @RequestMapping(value="/overlaynowpw.ajax")
	   @ResponseBody
	   public HashMap<String, Object> overlaynowpw(@RequestParam String nowuserPW,HttpSession session){
		   
		   logger.info(nowuserPW);		   		   
		   
		   HashMap<String, Object> map = new HashMap<String, Object>();		   
		   
		   String userPW = (String) session.getAttribute("userPW");

		   logger.info("{}"+ session.getAttribute("userPW"));		   		   
		   
		   BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();			
		   boolean isMatched = encoder.matches(nowuserPW, userPW);
		   logger.info("?"+isMatched);
		  
		   if(isMatched == true) {
			   map.put("overlaynowpw", isMatched);
		   }
				   		   		   		   
	      return map;      
	   }
	   
	   @RequestMapping(value="/overlaynickname.ajax")
	   @ResponseBody
	   public HashMap<String, Object> overlaynickname(@RequestParam String userNickname){
		   logger.info("overlaynickname : "+userNickname);
		   
	      return service.overlaynickname(userNickname);      

	   }
	   
	   @RequestMapping(value="/join.ajax")
	   @ResponseBody
	   public HashMap<String, Object> join(@RequestParam HashMap<String, String> params){
		   logger.info("params: {}"+params);
		   
		return service.join(params);		   
	   }
	   
	   @RequestMapping(value="/login.go")
	   public String loginForm() {
		   
	      return "loginForm";      
	   }
	   
	   @RequestMapping(value="/login.ajax")
	   @ResponseBody 
	   public HashMap<String, Object> login(@RequestParam String userID, 
			   @RequestParam String userPW,HttpSession session){
		   
		   logger.info(userID+"/"+userPW);
		   
		   MemberDTO dto = service.login(userID);
		   
		   logger.info(dto.getUserPW());
		   		   
		   String encodedPassword = dto.getUserPW();
		   
		   BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		   
		   boolean isMatched = encoder.matches(userPW, encodedPassword);
		   
		   logger.info("똑같에?" +isMatched);
  
		   HashMap<String, Object> map = new HashMap<String, Object>();
		   
		   if(isMatched == true && dto.getUserBlindWhether() == false) {

			   logger.info("dto :" + dto.getUserNickname());			   
			   		   	
			   session.setAttribute("userNickname", dto.getUserNickname());
			   session.setAttribute("userID", dto.getUserID());
			   session.setAttribute("Role", dto.getRole());
			   logger.info("nicik : " +session.getAttribute("userNickname"));
			   logger.info("userID : " +session.getAttribute("userID"));
			   logger.info("Role : " +session.getAttribute("Role"));
			   map.put("success", 1);
			   
		   }else if(isMatched == true && dto.getUserBlindWhether()){
			   
			   map.put("blind", 1);
			   
		   }
		   return map;
	   }		   	  
	   
		@RequestMapping(value = "/logout", method = RequestMethod.GET)
		public String logout(HttpSession session) {
			logger.info("로그아웃 함");
			session.removeAttribute("userNickname");
			session.removeAttribute("userID");
			return "redirect:/";
		}
		
	   @RequestMapping(value="/main.go")
	   public String main(HttpSession session) {  
		   logger.info("id : " + session.getAttribute("userID"));
		return "home";
	   }	
	   
	   @RequestMapping(value="/changememberpw.go")
	   public String changememberpw(HttpSession session, Model model) {  
		   
		   String page = "redirect:/";		
			
			logger.info("닉네임은?"+session.getAttribute("userNickname"));
		   
		   if(session.getAttribute("userNickname") != null) {
			   
				 MemberDTO dto = service.changememberpw(session.getAttribute("userNickname"));				 

				 session.setAttribute("userPW", dto.getUserPW());
				 logger.info("암호는?"+session.getAttribute("userPW"));
				 page = "changememberpw";
			 }		   
		return page;
	   }
	   
	   @RequestMapping(value="/chguserpw.ajax")
	   @ResponseBody
	   public HashMap<String, Object> changememberpwtrue(HttpSession session, @RequestParam String changeuserPW) {
		   
		   HashMap<String, Object> map = new HashMap<String, Object>();
		   
		   if(session.getAttribute("userNickname") != null) {

			   int success =service.changememberpwtrue(session.getAttribute("userNickname"), changeuserPW);
			   map.put("success", success);
		   }
		return map;
	   }
	   
	   @RequestMapping(value="/memberdelete.go")
	   public String memberdelete(HttpSession session) {  
		   
		   String page = "redirect:/";		   

		   if(session.getAttribute("userNickname") != null) {
			   page = "memberdelete";			   
		   }		   
		return page;
	   }
	   
	   @RequestMapping(value="/memberdelete.do")
	   public String memberdeletetrue(HttpSession session) {  
		   
		   String page = "redirect:/";
		   
		   if(session.getAttribute("userNickname") != null) {
			   service.memberdeletetrue(session.getAttribute("userNickname"));
			   session.removeAttribute("userNickname");
			   session.removeAttribute("userID");
			   page = "memberdeletecomplete";
		   }
		   
		return page;
	   }
	   
	   @RequestMapping(value="/myinformation.go")
	   public String myinformation(HttpSession session, Model model) {  
			
			String page = "redirect:/";		
			
			logger.info("닉네임은?"+session.getAttribute("userNickname"));
			
			 if(session.getAttribute("userNickname") != null) {
				 MemberDTO dto = service.myinformation(session.getAttribute("userNickname"));				 
				 model.addAttribute("member",dto);
				 page = "myinformation";
			 }
			
			return page;
		}
	   
	   @RequestMapping(value="/findmemberidpw.go")
	   public String findmemberidForm(@RequestParam String findType, Model model) {
		   model.addAttribute("findType", findType);
	      return "findmemberidpw";      
	   }	  
	   
	   @RequestMapping(value="/findmemberid.ajax")	
	   @ResponseBody
	   public HashMap<String, Object> findmemberid(@RequestParam String userName, 
			   @RequestParam String userEmail, HttpSession session){
		   		   		  
		   logger.info(userName+"/"+userEmail);
		   MemberDTO dto = service.findmemberid(userName, userEmail);
		   
		   logger.info("data {}"+dto);
		   		   
		   HashMap<String, Object> map = new HashMap<String, Object>();
		   
		   map.put("member", dto);
		   
		return  map;
	   }
	   
	   @RequestMapping(value="/findmemberpw.ajax")	
	   @ResponseBody
	   public HashMap<String, Object> findmemberpw(@RequestParam String userName, 
			   @RequestParam String userID, @RequestParam String userEmail, HttpSession session){
		   		   		  
		   logger.info(userName+"/"+userID+"/"+userEmail);		   
		   
		   HashMap<String, Object> map = new HashMap<String, Object>();
		   
		   int success = service.findmemberpw(userName, userID, userEmail);
		   
		   logger.info("findsuccess: "+ success);
		   
		   if(success == 1) {
			   String findpw =(String) service.RandomPassword(userName, userID, userEmail);
			   logger.info("임시비밀번호: "+findpw); 		   			   			   
			   map.put("findpw", findpw);
		   }		   		   		   		  
		return  map;
	   }	   	  
	   
	   @RequestMapping(value="/myinformationupdate.go")
	   public String myinformationupdate(HttpSession session, Model model) {
		   
		   String page = "redirect:/";		
			
			logger.info("닉네임은?"+session.getAttribute("userNickname"));
			
			 if(session.getAttribute("userNickname") != null) {
				 MemberDTO dto = service.myinformation(session.getAttribute("userNickname"));				 
				 model.addAttribute("member",dto);
				 String mdph = dto.getUserContact();
				 int mdphn = Integer.parseInt(mdph.substring(3, 7));
				 logger.info("m"+mdphn);
				 int lstphn = Integer.parseInt(mdph.substring(7));
				 logger.info("s"+lstphn);
				 model.addAttribute("mdphn", mdphn);
				 model.addAttribute("lstphn", lstphn);
				 
				 String Birthdate = dto.getUserBirthdate();
				 int year = Integer.parseInt(Birthdate.substring(0, 4));
				 int month = Integer.parseInt(Birthdate.substring(5, 7));
				 int day = Integer.parseInt(Birthdate.substring(8));
				 model.addAttribute("year", year);
				 model.addAttribute("month", month);
				 model.addAttribute("day", day);
 
				 page = "myinformationupdate";
				 
				 
			 }
	      return page;      
	   }
	   
	   @RequestMapping(value="/updateusername.ajax")	
	   @ResponseBody
	   public HashMap<String, Object> updateusername(HttpSession session, @RequestParam String username){
		
		String usernickname = (String) session.getAttribute("userNickname");
		   
		   return service.updateusername(usernickname, username);		   
	   }
	   
	   @RequestMapping(value="/updateusernickname.ajax")	
	   @ResponseBody
	   public HashMap<String, Object> updateusernickname(HttpSession session, @RequestParam String userNickname){
				   		   
		String nownickname = (String) session.getAttribute("userNickname");								
		 HashMap<String, Object> map = new HashMap<String, Object>();		 
		 map = service.updateusernickname(nownickname, userNickname);
		 session.removeAttribute("userNickname");
		 session.removeAttribute("userID");
		 
		 MemberDTO dto = service.sessionupdatenickname(userNickname);
		 session.setAttribute("userNickname", dto.getUserNickname());
		 session.setAttribute("userID", dto.getUserID());
		   return map;		   
	   }
	   
	   @RequestMapping(value="/updateuseremail.ajax")	
	   @ResponseBody
	   public HashMap<String, Object> updateuseremail(HttpSession session, @RequestParam String useremail){
		   // 세션 변경 해줘야함 
		   String usernickname = (String) session.getAttribute("userNickname");
		   
		   return service.updateuseremail(usernickname, useremail);		   
	   }
	   
	   @RequestMapping(value="/updateuserContact.ajax")	
	   @ResponseBody
	   public HashMap<String, Object> updateuserContact(HttpSession session, @RequestParam String usereContact){
  
		   String usernickname = (String) session.getAttribute("userNickname");
		   
		   return service.updateuserContact(usernickname, usereContact);		   
	   }
	   
	   @RequestMapping(value="/updateuserAge.ajax")	
	   @ResponseBody
	   public HashMap<String, Object> updateuserAge(HttpSession session, @RequestParam String userAge){
  
		   String usernickname = (String) session.getAttribute("userNickname");
		   
		   return service.updateuserAge(usernickname, userAge);		   
	   }
	   
	   @RequestMapping(value="/updateuserBirthdate.ajax")	
	   @ResponseBody
	   public HashMap<String, Object> updateuserBirthdate(HttpSession session, @RequestParam String userBirthdate){
  
		   String usernickname = (String) session.getAttribute("userNickname");
		   
		   return service.updateuserBirthdate(usernickname, userBirthdate);		   
	   }
	   
	   @RequestMapping(value="/updateuseraddress.ajax")	
	   @ResponseBody
	   public HashMap<String, Object> updateuseraddress(HttpSession session, @RequestParam String siID, @RequestParam String guID, @RequestParam String dongID){
  
		   String usernickname = (String) session.getAttribute("userNickname");
		   
		   return service.updateuseraddress(usernickname, siID, guID, dongID);		   
	   }
	   
	   @RequestMapping(value="/updateuserGender.ajax")	
	   @ResponseBody
	   public HashMap<String, Object> updateuserGender(HttpSession session, @RequestParam String userGender){
  
		   String usernickname = (String) session.getAttribute("userNickname");
		   
		   return service.updateuserGender(usernickname, userGender);		   
	   }
	   
	   
	   
	   
}