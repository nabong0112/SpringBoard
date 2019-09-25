package com.spring_web.bbs.service;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring_web.bbs.repository.BoardListDAO;
import com.spring_web.bbs.repository.BoardListDAOImpl;
import com.spring_web.bbs.vo.BoardListVO;
import com.spring_web.bbs.vo.CommentVO;
import com.spring_web.bbs.vo.UserVO;

@Service("boardListService")
@Transactional(rollbackFor = { Exception.class })
public class BoardListServiceImpl implements BoardListService {

	@Autowired
	BoardListDAO boardListDAO;

	/////////////////////////////////////// UserVO////////////////////////////////

	// 회원가입
	@Override
	public boolean joinCheckService(UserVO vo) throws Exception {
		boolean check =	boardListDAO.joinCheckDao(vo);
		System.out.println(check + "Service");
		return check;
	}
	//아이디 비번 찾기
	@Override
	public UserVO findUserService(UserVO vo, HttpSession session) throws Exception {
			
		return boardListDAO.findUserCheck(vo, session);
	}

	// 로그인 체크하기
	@Override
	public boolean loginCheckService(UserVO vo, HttpSession session) throws Exception {
		boolean check = boardListDAO.loginCheck(vo);

		if (check) {
			// 세션 변수 등록
			System.out.println(vo.getUserId());
			session.setAttribute("userId", vo.getUserId());
			session.setAttribute("userPw", vo.getUserPw());
			session.setAttribute("userName", vo.getUserName());
			session.setAttribute("joinTime", vo.getJoinTime());
			session.setAttribute("userIdQustion", vo.getUserIdQustion());
			session.setAttribute("userIdAnswer", vo.getUserIdAnswer());
		}
		return check;
	}

	// 회원 정보
	@Override
	public UserVO memberInfoService(String userId) throws Exception {

		return boardListDAO.memberInfo(userId);

	}

	// 회원 정보 수정
	@Override
	public void memberUpdateService(UserVO vo) throws Exception {
		
		boardListDAO.memberUpdateDao(vo);

	}

	// 회원 정보 탈퇴
	@Override
	public void memberDeleteService(UserVO vo, String userId) throws Exception {
		
		boardListDAO.memberDeleteDao(userId);

	}

	// 로그아웃
	@Override
	public void logoutService(HttpSession session) throws Exception {
		session.invalidate();
	}

	//////////////////////////////// BoardListVO//////////////////////////////

	// 글 불러오기
	@Override
	public List<BoardListVO> getBoardListService(int boardType) throws Exception {
		System.out.println("getBoardListService call");
		
		return boardListDAO.getBoardListdao(boardType);
	}
	
	@Override
	public List<BoardListVO> getBestListService(int boardType) throws Exception {
		return boardListDAO.getBestListdao(boardType);
	}

	// 글 상세
	@Override
	public BoardListVO getReadService(int boardNo, int boardType) throws Exception {
		System.out.println("getReadService call");

		return boardListDAO.getReadDao(boardNo, boardType);
	}

	// 조회수 증가
	@Override
	public void countViewService(int boardNo,int boardType) throws Exception {

		boardListDAO.CountViewDao(boardNo, boardType);

	}

	// 글 추가
	@Override
	public void insertService(BoardListVO vo, int boardType) throws Exception {
		
		// Dao로 전달
		boardListDAO.insertDao(vo, boardType);
	}

	// 글 수정
	@Override
	public void updateService(BoardListVO vo, int boardType) throws Exception {
		/*
		 * String title = vo.getBoardTitle(); String text = vo.getBoardText();
		 * System.out.println(title); System.out.println(text);
		 * 
		 * // 태그 문자 처리(<는 &lt;로 >는 &gt;로 title = title.replace("<", "&lt;"); title =
		 * title.replace(">", "&gt;"); text = text.replace("<", "&lt;"); text =
		 * text.replace(">", "&gt;"); // 공백 문자처리 title = title.replace(" ", "&nbsp;");
		 * text = text.replace(" ", "&nbsp;"); // 줄바꿈 처리 text = text.replace("\n",
		 * "<br>");
		 * 
		 * vo.setBoardTitle(title); vo.setBoardText(text);
		 */
		boardListDAO.updateDao(vo, boardType);
	}

	// 글 삭제
	@Override
	public void deleteService(int boardNo, int boardType) throws Exception {
		boardListDAO.deleteDao(boardNo, boardType);
	}

	// 댓글 상세
	@Override
	public List<CommentVO> getCommentListService(int boardNo, int boardType) throws Exception {
		System.out.println("getCommentListService call");

		return boardListDAO.getCommentDao(boardNo, boardType);
	}

	// 댓글 추가
	@Override
	public void insertCommentService(CommentVO vo, int boardNo, HttpSession session) throws Exception {

		System.out.println("insertCommentService call");

		vo.setBoardNo(boardNo);
		vo.setCommentUser((String) session.getAttribute("userId"));

		boardListDAO.insertCommentDao(vo);

	}

	// 댓글 수정
	@Override
	public void updateCommentService(CommentVO vo) throws Exception {
		System.out.println("updateCommentService call");

		boardListDAO.updateCommentDao(vo);

	}

	// 댓글 삭제
	@Override
	public void deleteCommentService(int commentNo, HttpSession session) throws Exception {
		System.out.println("deleteCommentService call");

		boardListDAO.deleteCommentDao(commentNo);
	}

	// 검색
	@Override
	public List<BoardListVO> searchService(String searchName, int searchType) throws Exception {

		return boardListDAO.searchDao(searchName, searchType);

	}
	
	

	

}
