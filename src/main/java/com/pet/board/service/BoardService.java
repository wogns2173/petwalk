package com.pet.board.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Clob;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.pet.board.dao.BoardDAO;
import com.pet.board.dto.BoardDTO;

@Service
public class BoardService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired BoardDAO dao;
	
	// 커뮤니티 게시판 메인 이동
	public ArrayList<BoardDTO> boardList() {
		logger.info("Service boardList");
		ArrayList<BoardDTO> boardList= dao.boardList();
		logger.info("Service boardList" + boardList);
		return boardList;
	}
	/*
	public ArrayList<BoardDTO> boardPhotoList() {
		logger.info("service boardPhotoList");
		ArrayList<BoardDTO> photoboardList = dao.photoboardList();
		logger.info("Service boardList" + photoboardList);
		return null;
	}*/
	
	// 커뮤니티 상세 게시판 리스트 (페이징)
	public HashMap<String, Object> list(int page, int cnt,String categoryCode
			,String boardSearch,String search) {
		logger.info(page+"페이지 보여줘");
		logger.info("한페이지에"+cnt+" 개씩 보여줄거야");
		logger.info(categoryCode+"/"+boardSearch+"/"+search);
		HashMap<String, Object> map = new HashMap<String, Object>();
		int offset = (page-1)*cnt;
		logger.info("offset: "+offset);
		
		int total = 0;
		
		if(!categoryCode.equals("") && boardSearch.equals("default") && search.equals("default")) {
			total = dao.totalCount(categoryCode);
		}else if(boardSearch.equals("boardName") && !search.equals("default") && !search.equals("")) {
			logger.info("boardName 으로 검색: "+search);
			total = dao.boardNameSearchTotal(categoryCode,search);
		}else if(boardSearch.equals("userNickname") && !search.equals("")) {
			logger.info("userNickname 으로 검색: "+search);
			total = dao.boardNicknamesearchTotal(categoryCode,search);
		}else if(boardSearch.equals("userID") && !search.equals("")) {
			logger.info("userID 으로 검색: "+search);
			total = dao.boarduserIDsearchTotal(categoryCode,search);
		}else if(!categoryCode.equals("") && boardSearch.equals("default") && search.equals("")){
			total = dao.totalCount(categoryCode);
		}
		
		int range = total%cnt == 0?total/cnt:(total/cnt)+1;
		logger.info("전체 게시물 수: "+total);
		logger.info("총 페이지:" +range);
		
		page = page > range ? range : page;
		
		map.put("currPage", page);
		map.put("pages", range);
		
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		
		if(categoryCode.equals("B_01")) {
			if(!categoryCode.equals("") && boardSearch.equals("default") && search.equals("default")) {
				list= dao.boardPhotoList(cnt,offset,categoryCode,boardSearch,search);
			}else if(boardSearch.equals("boardName") && !search.equals("default") && !search.equals("")) {
				logger.info("boardName 으로 검색: "+search);
				list = dao.boardPhotoNameSearch(cnt,offset,categoryCode,boardSearch,search);
			}else if(boardSearch.equals("userNickname") && !search.equals("")) {
				logger.info("userNickname 으로 검색: "+search);
				list = dao.boardPhotoNicknamesearch(cnt,offset,categoryCode,boardSearch,search);
			}else if(boardSearch.equals("userID") && !search.equals("")) {
				logger.info("userID 으로 검색: "+search);
				list = dao.boardPhotouserIDsearch(cnt,offset,categoryCode,boardSearch,search);
			}else if(!categoryCode.equals("") && boardSearch.equals("default") && search.equals("")){
				list= dao.boardPhotoList(cnt,offset,categoryCode,boardSearch,search);
			}
		}else {
			if(!categoryCode.equals("") && boardSearch.equals("default") && search.equals("default")) {
					list = dao.list(cnt,offset,categoryCode,boardSearch,search);
			}else if(boardSearch.equals("boardName") && !search.equals("default") && !search.equals("")) {
				logger.info("boardName 으로 검색: "+search);
				list = dao.boardNameSearch(cnt,offset,categoryCode,boardSearch,search);
			}else if(boardSearch.equals("userNickname") && !search.equals("")) {
				logger.info("userNickname 으로 검색: "+search);
				list = dao.boardNicknamesearch(cnt,offset,categoryCode,boardSearch,search);
			}else if(boardSearch.equals("userID") && !search.equals("")) {
				logger.info("userID 으로 검색: "+search);
				list = dao.boarduserIDsearch(cnt,offset,categoryCode,boardSearch,search);
			}else if(!categoryCode.equals("") && boardSearch.equals("default") && search.equals("")){
				list = dao.list(cnt,offset,categoryCode,boardSearch,search);
			}
		}
		logger.info("리스트담기 성공!");
		map.put("list", list);
		return map;
	}

	// 글 작성하기
	public String boardWrite(MultipartFile photo, HashMap<String, String> params,HttpSession session,String userID) {
		
		String page = "redirect:/board";
		//1. 게시글만 작성
		BoardDTO dto = new BoardDTO();
		
		
		dto.setCategoryCode(params.get("categoryCode"));
		dto.setBoardName(params.get("boardName"));
		dto.setBoardDetail(params.get("boardDetail"));
		dto.setUserID(userID);
		
		logger.info(dto.getBoardDetail() + "/" + dto.getCategoryCode() + "/" + dto.getBoardName()+"/"+dto.getUserID());
		int row = dao.boardWrite(dto);
		logger.info("writeupdate row:"+row);
		int boardNum = dto.getBoardNum();
		String categoryCode = dto.getCategoryCode();
		logger.info("방금 inset한 categoryCode: "+categoryCode+"/"+boardNum);
				
	
		//첨부파일 같이 업로드 
		if(!photo.getOriginalFilename().equals("")) {
			logger.info("파일 업로드 작업");
			fileSave(categoryCode,photo,boardNum);
		}
		
		//페이지 이동
		switch(params.get("categoryCode")) {
		
		case "B_01":
			page = "redirect:/board";
			break;
		case "B_02":
			page = "redirect:/boardList.go?categoryCode=B_02";
			break;
		case "B_03":
			page = "redirect:/boardList.go?categoryCode=B_03";
			break;
		case "B_04":
			page = "redirect:/boardList.go?categoryCode=B_04";
			break;
		}
		return page;
	}


	// 사진 저장하기
	private void fileSave(String categoryCode, MultipartFile photo, int boardNum) {
		String oriPhotoname = photo.getOriginalFilename();
		String ext = oriPhotoname.substring(oriPhotoname.lastIndexOf("."));
		String serPhotoname = System.currentTimeMillis()+ext;
		logger.info(oriPhotoname+"->"+serPhotoname);
		logger.info("카테고리 코드:"+categoryCode);
	
		try {
			byte[] bytes = photo.getBytes();
			Path path = Paths.get("C:/img/petwork/"+serPhotoname);
			Files.write(path, bytes);
			logger.info(serPhotoname+"save OK");
			dao.fileWrite(categoryCode, oriPhotoname, serPhotoname, boardNum);
			logger.info("사진 저장 완료");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
}
	// 글 상세보기
	public BoardDTO boardDetail(String boardNum,String flag) {
		logger.info("Service boardDetail!");
		if(flag.equals("boardDetail")) {
			logger.info("조회수 증가");
			dao.boardbHit(boardNum);
		}
		// 사진이 저장되어 있는지 없는지 확인
		int row = dao.boardPhotoCount(boardNum);
		logger.info("최초 사진 등록 여부: "+row);
		BoardDTO dto = new BoardDTO();
		logger.info("dto 로 넘어감");
		if(row == 0) {
			dto = dao.boardDetail(boardNum);
		} else {
			dto = dao.findPhotoBlindWhether(boardNum);
			logger.info("findPhotoBlindWhether: "+dto.isPhotoBlindWhether());
			if(dto.isPhotoBlindWhether() == false) {
				logger.info("사진이 있을 경우 디테일");
				logger.info("블라인드 처리 여부: "+dto.isBoardBlindWhether());
				dto = dao.boardDetail(boardNum);
			}else if(dto.isPhotoBlindWhether() == true){ 
				logger.info("사진 블라인드 처리될 경우");
				dto = dao.boardDetailPhotoDel(boardNum);
				logger.info("photonull");
			}
		}

		logger.info("board Detail dto: " + dto);
		logger.info("사진 블라인드 처리 여부:"+dto.isPhotoBlindWhether());
		
		return dto;
	}

	// 글 블라인드 처리하기
	public void boardDelete(String boardNum) {
		//String serPhotoname = dao.findFile(boardNum);
		//logger.info("photo name:"+serPhotoname);
		
		int row = dao.boardDelete(boardNum);
		logger.info("delete row:"+row);
		
	}

	// 글 수정하기
	public String boardUpdate(MultipartFile photo, HashMap<String, String> params,boolean deletePhoto) {
		int row = dao.boardUpdate(params);
		String categoryCode = params.get("categoryCode");
		logger.info("code : " + categoryCode);
		int boardNum = Integer.parseInt(params.get("boardNum"));
		String serPhotoname = params.get("serPhotoname");
		logger.info(serPhotoname);
		logger.info("update row: "+row);
		
		
		// 사진 삭제
		if (deletePhoto == true) { 
			logger.info("사진 삭제");
			logger.info("del serPhotoname: " +serPhotoname);
			row = dao.photoDelete(serPhotoname);
	    }
		// 사진 저장
		if(photo != null && !photo.getOriginalFilename().equals("")) {
			fileSave(categoryCode,photo,boardNum);
				//photoDelete(serPhotoname, categoryCode, boardNum);
		}
		
		String page = row>0? "redirect:/boardList.go?categoryCode="+categoryCode : 
			"redirect:/boardDetail.do?boardNum="+boardNum;
		logger.info("update page:"+page);
		
		return page;
	}


	// 댓글 작성하기
	public int boardRepWrite(int boardNum, String content,String userID) {
		logger.info("Board Reply Write Service");
		return dao.boardRepWrite(boardNum, content, userID);
		
	}

	// 댓글 리스트 1
	public BoardDTO boardRepList(String boardNum, int replyNum) {
		logger.info("board Reply List Service");
		return dao.boardRepList(boardNum, replyNum);
	}
	
	// 댓글 리스트 2
	public ArrayList<BoardDTO> boardRepList2(String boardNum) {
		//dao.boardbHitDown(boardNum);
		return dao.boardRepList2(boardNum);
	}

	// 댓글 수정하기
	public String boardRepUpdate(HashMap<String, String> params) {
		logger.info("Inquiry Reply Update Service");
		logger.info("params :"+ params);
		
		int row = dao.boardRepUpdate(params);
		
		logger.info("update row :"+row);
		
		return "redirect:/boardDetail.do?boardNum="+params.get("boardNum");	
	}

	// 댓글 블라인드 처리하기
	public int boardRepDel(int replyNum) {
		logger.info(" 댓글 삭제 서비스 이동완료");
		return dao.boardRepDel(replyNum);
	}

	





	

}
