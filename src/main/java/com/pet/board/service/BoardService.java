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
	
	public ArrayList<BoardDTO> B_02list() {
		logger.info("Service B_02list");
		return dao.B_02list();
	}
	
	public HashMap<String, Object> B_03List(int page, int cnt) {
		logger.info(page+"페이지 보여줘");
		logger.info("한페이지에"+cnt+" 개씩 보여줄거야");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		int offset = (page-1)*cnt;
		
		int total = dao.totalCount();
		int range = total%cnt == 0?total/cnt:(total/cnt)+1;
		logger.info("전체 게시물 수: "+total);
		logger.info("총 페이지:" +range);
		
		page = page > range ? range : page;
		
		map.put("currPage", page);
		map.put("pages", range);
		
		ArrayList<BoardDTO> list = dao.list(cnt,offset);
		map.put("list", list);
		return map;
	}

/*
	public String boardWrite(String userID, String boardName
			, String boardDetail, String categoryCode, String photo
			,HttpSession session) {
		logger.info("Service boardWrite!");
		if(userID != null) {
			logger.info("write.do:"+boardName+"/"+boardDetail+"/"+categoryCode+"/"+photo);
			
			}
		return dao.boardWrite(userID,boardName,boardDetail,categoryCode);
	}
*/
/*
	public int boardWrite(boardDTO dto) {
		return dao.boardWrite(dto);
	}
*/
	public String boardWrite(MultipartFile photo, HashMap<String, String> params) {
		
		String page = "redirect:/board";

		//1. 게시글만 작성
		BoardDTO dto = new BoardDTO();
		
		
		dto.setCategoryCode(params.get("categoryCode"));
		dto.setBoardName(params.get("boardName"));
		dto.setBoardDetail(params.get("boardDetail"));
		
		logger.info(dto.getBoardDetail() + "/" + dto.getCategoryCode() + "/" + dto.getBoardName());
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
		return page;
	}


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

	public BoardDTO boardDetail(String boardNum,String flag) {
		logger.info("Service boardDetail!");
		if(flag.equals("boardDetail")) {
			dao.boardbHit(boardNum);
		}
		BoardDTO dto = new BoardDTO();
		dto = dao.boardDetail(boardNum);
		logger.info("board Detail dto: " + dto);
		logger.info("사진 블라인드 처리 여부:"+dto.isPhotoBlindWhether());
		//logger.info("detail dao 로 이동"+boardNum);
		return dto;
	}

	public void boardDelete(String boardNum) {
		String serPhotoname = dao.findFile(boardNum);
		logger.info("photo name:"+serPhotoname);
		
		int row = dao.boardDelete(boardNum);
		logger.info("delete row:"+row);
		
		if(serPhotoname != null && row >0) {
			File file = new File("C:/img/petwork/"+serPhotoname);
			if(file.exists()) {
				file.delete();
			}
		}
	}

	public String boardUpdate(MultipartFile photo, HashMap<String, String> params) {
		int row = dao.boardUpdate(params);
		String categoryCode = params.get("categoryCode");
		logger.info("code : " + categoryCode);
		int boardNum = Integer.parseInt(params.get("boardNum"));
		String serPhotoname = params.get("serPhotoname");
		logger.info("update row: "+row);
		
		if(photo != null && !photo.getOriginalFilename().equals("")) {
			fileSave(categoryCode,photo,boardNum);
			if(photo.getName() != null) {
				photoDelete(serPhotoname, categoryCode, boardNum);
			}
		}
		
		String page = row>0? "redirect:/board" : "redirect:/boardDetail.do?boardNum="+boardNum;
		logger.info("update page:"+page);
		
		return page;
	}

	public String photoDelete(String serPhotoname,String categoryCode,int boardNum) {
		String page ="redirect:/boardUpdate.go?boardNum="+boardNum+"&categoryCode="+categoryCode;
		
/*		File delFile = new File("C:/img/petwork/"+serPhotoname);
		if(delFile.exists()) {
			delFile.delete();
			int row = dao.photoDelete(serPhotoname);
			logger.info("photo del:"+row);
		}

*/
		int row = dao.photoDelete(serPhotoname);
		if (serPhotoname != null && row > 0) {
	        File sourceFile = new File("C:/img/petwork/" + serPhotoname);
	        if (sourceFile.exists()) {
	            File destFile = new File("C:/img/delpetwork/" + serPhotoname);
	            if (sourceFile.renameTo(destFile)) {
	                logger.info("File moved successfully.");
	            } else {
	                logger.info("Failed to move file.");
	            }
	        }
	    }
		return page;
	}



	

}
