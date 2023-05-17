package com.pet.walkroute.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.util.JSONPObject;

public class WebSocketHandler extends TextWebSocketHandler {
	//세션 리스트
    private ArrayList<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
    //세션과 유저 매핑
    private HashMap<String, Object> userMap = new HashMap<String, Object>();

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    //클라이언트가 연결 되었을 때 실행
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        sessionList.add(session);
        logger.info("{} 연결됨", session.getId()); 
    }

    //클라이언트가 웹소켓 서버로 메시지를 전송했을 때 실행
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        logger.info("{}로 부터 {} 받음", session.getId(), message.getPayload());
        
        //모든 유저에게 메세지 출력
    	for(WebSocketSession sess : sessionList) {
			logger.info("보내야 될사람 : " + sess.getId());
			logger.info("session.getId() : " + session.getId());
			sess.sendMessage(new TextMessage(message.getPayload()));
        }
        
    }
        
    //클라이언트 연결을 끊었을 때 실행
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        sessionList.remove(session);
        logger.info("{} 연결 끊김.", session.getId());
    }
	
}
