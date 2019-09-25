package com.spring_web.bbs.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.spring_web.bbs.vo.BoardListVO;
import com.spring_web.bbs.vo.CommentVO;
import com.spring_web.bbs.vo.UserVO;

public interface BoardListService {
	
	public List<BoardListVO> getBoardListService(int boardType) throws Exception;
	
	public BoardListVO getReadService(int boardNo,int boardType) throws Exception;

	public boolean loginCheckService(UserVO vo, HttpSession session) throws Exception;
	
	public UserVO memberInfoService(String userId) throws Exception;
	
	public void logoutService(HttpSession session) throws Exception;

	public void insertService(BoardListVO vo, int boardType) throws Exception;

	public void deleteService(int boardNo, int boardType) throws Exception;

	public void updateService(BoardListVO vo, int boardType) throws Exception;

	public List<CommentVO> getCommentListService(int boardNo,int boardType) throws Exception;

	public void insertCommentService(CommentVO vo, int boardNo, HttpSession session) throws Exception;
	
	public void updateCommentService(CommentVO vo) throws Exception;
	
	public void deleteCommentService(int commentNo, HttpSession session) throws Exception;

	public boolean joinCheckService(UserVO vo) throws Exception;

	public void countViewService(int boardNo,int boardType) throws Exception;

	public List<BoardListVO> searchService(String searchName, int searchType) throws Exception;

	public void memberUpdateService(UserVO vo) throws Exception;

	public void memberDeleteService(UserVO vo, String userPw) throws Exception;

	public List<BoardListVO> getBestListService(int boardType) throws Exception;

	public UserVO findUserService(UserVO vo, HttpSession session) throws Exception;
}
