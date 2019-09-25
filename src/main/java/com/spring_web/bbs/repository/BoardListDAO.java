package com.spring_web.bbs.repository;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.spring_web.bbs.vo.BoardListVO;
import com.spring_web.bbs.vo.CommentVO;
import com.spring_web.bbs.vo.UserVO;

public interface BoardListDAO {
	
	public List<BoardListVO> getBoardListdao(int boardType) throws Exception;
	
	public BoardListVO getReadDao(int boardNo, int boardType) throws Exception;

	public boolean loginCheck(UserVO vo) throws Exception;

	public UserVO memberInfo(String userId) throws Exception;

	public void logout(HttpSession session) throws Exception;

	public void insertDao(BoardListVO vo, int boardType) throws Exception;

	public void updateDao(BoardListVO vo, int boardType) throws Exception;
	
	public void deleteDao(int boardNo, int boardType) throws Exception;

	public List<CommentVO> getCommentDao(int boardNo,int boardType) throws Exception;
	
	public void insertCommentDao(CommentVO vo) throws Exception;
	
	public void updateCommentDao(CommentVO vo) throws Exception;
	
	public void deleteCommentDao(int commentNo) throws Exception;

	public boolean joinCheckDao(UserVO vo) throws Exception;

	public void CountViewDao(int boardNo, int boardType) throws Exception;

	public List<BoardListVO> searchDao(String searchName, int searchType) throws Exception;

	public void memberUpdateDao(UserVO vo) throws Exception;
	
	public void memberDeleteDao(String userId) throws Exception;

	public List<BoardListVO> getBestListdao(int boardType) throws Exception;

	public UserVO findUserCheck(UserVO vo, HttpSession session) throws Exception;
}
