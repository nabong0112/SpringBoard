package com.spring_web.bbs.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Repository;

import com.spring_web.bbs.vo.BoardListVO;
import com.spring_web.bbs.vo.CommentVO;
import com.spring_web.bbs.vo.UserVO;

@Repository("boardListDAO")
public class BoardListDAOImpl implements BoardListDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	private String namespace = "org.mapper.boardMapper";

	// 회원가입
	@Override
	public boolean joinCheckDao(UserVO vo) throws Exception {
		
		try {
			sqlSession.insert(namespace + ".join", vo);
			return true;
		}catch(DuplicateKeyException e){
			return false;
		}
		
		}
	
	//회원체크
		@Override
		public UserVO findUserCheck(UserVO vo, HttpSession session)throws Exception {
			
				return sqlSession.selectOne(namespace + ".findId", vo);
		}
	
	// 회원 로그인 체크
	@Override
	public boolean loginCheck(UserVO vo) throws Exception {

		if (sqlSession.selectOne(namespace + ".loginCheck", vo) == null) {

			return false;
		} else {
			return true;
		}
	}

	// 회원 정보 불러오기
	@Override
	public UserVO memberInfo (String userId) throws Exception {
		
		return sqlSession.selectOne(namespace + ".myPage", userId);
	}

	// 회원정보 수정 , 탈퇴 여기에 넣기
	@Override
	public void memberUpdateDao(UserVO vo) throws Exception {
		
		
	}
	
	@Override
	public void memberDeleteDao(String userId) throws Exception {
		
		
	}

	// 로그아웃
	@Override
	public void logout(HttpSession session) throws Exception {

	}

	// 게시글 목록
	@Override
	public List<BoardListVO> getBoardListdao(int boardType) throws Exception {
		System.out.println("getBoardListdao Call");
		
		Map<String, Object>boardMap = new HashMap<>();
		
		boardMap.put("boardType", boardType);

		return sqlSession.selectList(namespace + ".boardList", boardMap);
	}
	
	//조회수 제일 높은순 세개고르기
		@Override
		public List<BoardListVO> getBestListdao(int boardType) throws Exception  {
			
			Map<String, Object>boardMap = new HashMap<>();
			
			boardMap.put("boardType", boardType);
			
			return sqlSession.selectList(namespace + ".bestList", boardMap);
		}

	// 게시글 상세보기
	@Override
	public BoardListVO getReadDao(int boardNo, int boardType) throws Exception {
		System.out.println("getReadDao Call");
		
		Map<String, Object>boardMap = new HashMap<>();
		
		boardMap.put("boardNo", boardNo);
		boardMap.put("boardType", boardType);
		
		return sqlSession.selectOne(namespace + ".getRead", boardMap);
	}
	
	//조회수 증가시키기
	@Override
	public void CountViewDao(int boardNo, int boardType) throws Exception {
		
		Map<String, Object>boardMap = new HashMap<>();
		boardMap.put("boardNo", boardNo);
		boardMap.put("boardType", boardType);
		sqlSession.update(namespace + ".countView", boardMap);
	}

	// 게시글 작성
	@Override
	public void insertDao(BoardListVO vo, int boardType) throws Exception {
		
		Map<String, Object>boardMap = new HashMap<>();
		boardMap.put("boardTitle", vo.getBoardTitle());
		boardMap.put("boardText", vo.getBoardText());
		boardMap.put("boardUser", vo.getBoardUser());
		boardMap.put("boardType", boardType);
		sqlSession.insert(namespace + ".insertBoard", boardMap);
	}

	// 게시글 수정
	@Override
	public void updateDao(BoardListVO vo, int boardType) throws Exception {
		Map<String, Object>boardMap = new HashMap<>();
		boardMap.put("boardNo", vo.getBoardNo());
		boardMap.put("boardTitle", vo.getBoardTitle());
		boardMap.put("boardText", vo.getBoardText());
		boardMap.put("boardUser", vo.getBoardUser());
		boardMap.put("boardType", boardType);
		sqlSession.update(namespace + ".updateBoard", boardMap);
	}

	// 게시글 삭제
	@Override
	public void deleteDao(int boardNo, int boardType) throws Exception {
		Map<String, Object>boardMap = new HashMap<>();
		
		boardMap.put("boardNo", boardNo);
		boardMap.put("boardType", boardType);
		
		sqlSession.delete(namespace + ".deleteBoard", boardMap);
	}

	// 댓글 불러오기
	@Override
	public List<CommentVO> getCommentDao(int boardNo, int boardType) throws Exception {

		Map<String, Object>boardMap = new HashMap<>();
		
		boardMap.put("boardNo", boardNo);
		boardMap.put("boardType", boardType);
		
		return sqlSession.selectList(namespace + ".getComment", boardMap);
	}

	// 댓글 작성
	@Override
	public void insertCommentDao(CommentVO vo) throws Exception {
		// String userId = (String)session.getAttribute("userId");
		sqlSession.insert(namespace + ".insertComment", vo);
	}

	// 댓글 수정
	@Override
	public void updateCommentDao(CommentVO vo) throws Exception {

		sqlSession.update(namespace + ".updateComment", vo);
	}

	// 댓글 삭제
	@Override
	public void deleteCommentDao(int commentNo)  throws Exception{

		sqlSession.delete(namespace + ".deleteComment", commentNo);
	}
	
	//검색
	@Override
	public List<BoardListVO> searchDao(String searchName, int searchType)  throws Exception{
		
		Map<String, Object>searchMap = new HashMap<>();
		
		searchMap.put("searchName", searchName);
		searchMap.put("boardType", searchType);
		
			return sqlSession.selectList(namespace + ".search", searchMap);		
		
	}
	

	

}
