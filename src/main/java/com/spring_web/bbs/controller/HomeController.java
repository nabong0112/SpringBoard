package com.spring_web.bbs.controller;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring_web.bbs.service.BoardListService;
import com.spring_web.bbs.service.BoardListServiceImpl;
import com.spring_web.bbs.vo.BoardListVO;
import com.spring_web.bbs.vo.CommentVO;
import com.spring_web.bbs.vo.PagingVO;
import com.spring_web.bbs.vo.UserVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	//아 redirect는 jsp를 직접 불러오기때문에 addObject를 jsp에서 파라메타로 받아와야됨 주소창ㅇ에 값이 안보여어
	//redirect를 안하면은 컨트롤러에서 넘어가는거라 

	@Autowired
	BoardListService boardListService;
	
	// 아이디&비밀번호 찾기 폼
			@RequestMapping(value = "/findUser", method = { RequestMethod.POST, RequestMethod.GET })
			public ModelAndView findUser(ModelAndView mv) throws Exception {
				
				mv.setViewName("missingUser");
				return mv;

			}
	
	// 아이디&비밀번호 찾기 체크 아 왜 .do를쓰라는지알겠ㄷㄻㅇㄴㄻㅇ러ㅏㅣ;ㄴ어ㅏㅣ;
		@RequestMapping(value = "/findUserCheck", method = { RequestMethod.POST, RequestMethod.GET })
		public ModelAndView findUser(@ModelAttribute UserVO vo,ModelAndView mv,HttpSession session) throws Exception {
			
			if(boardListService.findUserService(vo,session) == null) {
				mv.setViewName("missingUser");
				mv.addObject("msg", "noQuestion");
				System.out.println("결과 없음");
				return mv;
			}else {
				mv.setViewName("missingUser");
				mv.addObject("msg", "yesQuestion");
				mv.addObject("find",boardListService.findUserService(vo,session));
				System.out.println("결과 있음");
				return mv;
			}	

		}

	// 회원가입 폼
	@RequestMapping(value = "/joinform", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView joinform(ModelAndView mv) throws Exception {

		mv.setViewName("joinform");
		
		return mv;

	}

	// 회원가입 체크 넣어야됨
	@RequestMapping(value = "/joinCheck", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView joinCheck(@ModelAttribute UserVO vo,ModelAndView mv) throws Exception {
		boolean check = boardListService.joinCheckService(vo);
		
		if(check == false) {
			mv.setViewName("joinform");
			mv.addObject("msg", "overlepId");
			System.out.println("회원가입 실패");
			return mv;
		}else {
			mv.setViewName("login");
			mv.addObject("msg", "join");
			System.out.println("회원가입 성공");
			return mv;
		}

	}

	// 로그인창
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView login(ModelAndView mv,HttpSession session) throws Exception {
		

		if(session.getAttribute("userId") != null) {
			mv.setViewName("main");
			mv.addObject("msg", "이미 로그인");
		}else {
			mv.setViewName("login");
		}
		return mv;

	}

	// 로그인 체크
	@RequestMapping(value = "/loginCheck", method = RequestMethod.POST)
	public ModelAndView loginCheck(@ModelAttribute UserVO vo, HttpSession session, ModelAndView mv) throws Exception {
		boolean check = boardListService.loginCheckService(vo, session);
		
		if (check == true) {
			mv.setViewName("redirect:main");
			mv.addObject("msg", "ok");
			System.out.println("로그인 하셨습니다");
			return mv;

		} else {
			mv.setViewName("login");
			mv.addObject("msg", "no");
			System.out.println("로그인 실패");
			return mv;
		}
	}

	//회원 정보
	@RequestMapping(value = "/userInfo", method = { RequestMethod.GET})
	public ModelAndView userInfo(HttpSession session, ModelAndView mv) throws Exception{
		
		String userId = (String)session.getAttribute("userId");
		
		if(userId == null) {
			String msg ="NoUserInfo";
			mv.setViewName("login");
			mv.addObject("msg", msg);
		} else {
		mv.setViewName("userInfo");
		mv.addObject("info", boardListService.memberInfoService(userId));
		}
		return mv;

	}
	
	//회원 정보 수정 & 탈퇴 확인 페이지 이동
	@RequestMapping(value = "/changeUserInfo", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView changeUserInfo(@RequestParam("userId") String userId, HttpSession session, ModelAndView mv) throws Exception{
		
		if(userId != session.getAttribute("userId")) {
			String msg ="NoUserInfo";
			mv.setViewName("login");
			mv.addObject("msg", msg);
		} else {
		mv.setViewName("userInfoUpdate");
		mv.addObject("info", boardListService.memberInfoService(userId));
		}
		return mv;

	}
	
	//회원 정보 수정
		@RequestMapping(value ="/updateUser", method = {RequestMethod.POST})
		public String updateUser() throws Exception {
			
			return "redirect:main";
			
		}
	
	
	//회원 탈퇴
	@RequestMapping(value ="/deleteUser", method = {RequestMethod.POST})
	public String deleteUser() throws Exception {
		
		
		
		return "redirect:main";
		
	}

	// 로그아웃
	@RequestMapping(value = "/logout", method = { RequestMethod.POST, RequestMethod.GET })
	public String logout(HttpSession session, ModelAndView mv) throws Exception {

		boardListService.logoutService(session);
		mv.setViewName("main");
		mv.addObject("msg", "logout");

		System.out.println("로그아웃 하셨습니다");

		return "redirect:main";
	}

	// 검색기능
	@RequestMapping(value = "/search", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView search(@RequestParam("searchName") String searchName,@RequestParam(defaultValue="1") int curPage,
			@RequestParam("searchType") int searchType, ModelAndView mv) throws Exception {

		List<BoardListVO> searchList = boardListService.searchService(searchName, searchType);
		PagingVO paging = new PagingVO(3,7,searchList.size() ,curPage);
		
		System.out.println("검색결과 갯수 : " + searchList.size() + "개");
		System.out.println("총 페이지 개수 : "+paging.getPageCount());
		  System.out.println("페이지 시작 숫자  : "+paging.getStartPage());
		  System.out.println("페이지 마지막 숫자  : "+paging.getEndPage());
		  System.out.println("Pre 표시 여부  : "+paging.isPre());
		  System.out.println("Next 표시 여부   : "+paging.isNext());
		  System.out.println("글 범위 시작 번호   : "+paging.getStartWriting());
		  System.out.println("글 범위 끝 번호   : "+paging.getEndWriting());
		  System.out.println("현재 페이지 위치   : "+paging.getCurPage());
		  if(paging.isPre())
			   System.out.print(" Pre ");
			  for(int i = paging.getStartPage(); i <= paging.getEndPage();i++)
			  {
			   System.out.print(" "+i+" ");
			  }
			  if(paging.isNext())
			   System.out.print(" Next ");
		mv.addObject("searchList", searchList);
		mv.addObject("searchType", searchType);
		mv.addObject("page", paging);
		mv.addObject("curPage", curPage);
		mv.setViewName("search");

		return mv;
	}

	// 게시판 메인
	@RequestMapping(value = "/main", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView main(ModelAndView mv, HttpSession session,@RequestParam(defaultValue="1") int curPage) throws Exception {
		int boardType = 0;
		List<BoardListVO> boardList = boardListService.getBoardListService(boardType);
		PagingVO paging = new PagingVO(5,7,boardList.size() ,curPage);
		System.out.println("공지사항 갯수 : " + boardList.size() + "개");
		if(curPage > paging.getEndPage()) {
			curPage = 1;
			mv.setViewName("redirect:main");
		}
		mv.addObject("listboard", boardList); // boardlist에 있는 데이터 저장
		mv.addObject("page", paging);
		mv.addObject("curPage", curPage);
		mv.setViewName("main"); // 뷰를 main으로 설정

		return mv; // boardlist전달
	}
	@RequestMapping(value = "/TipBoard", method = {RequestMethod.POST,RequestMethod.GET} )
	public ModelAndView Tip_board(ModelAndView mv, HttpSession session) throws Exception  {
		int boardType = 1;
		List<BoardListVO> boardList = boardListService.getBoardListService(boardType);
		List<BoardListVO> bestList = boardListService.getBestListService(boardType);
		System.out.println("팁게시글 갯수 : " + boardList.size() + "개");

		mv.addObject("listboard", boardList); // boardlist에 있는 데이터 저장
		mv.addObject("bestboard", bestList);
		mv.setViewName("Tip_board");
		return mv; // boardlist전달
	}
	@RequestMapping(value = "/QuestionBoard", method = {RequestMethod.POST,RequestMethod.GET} )
	public ModelAndView Question_board(ModelAndView mv, HttpSession session) throws Exception  {
		int boardType = 2;
		List<BoardListVO> boardList = boardListService.getBoardListService(boardType);
		List<BoardListVO> bestList = boardListService.getBestListService(boardType);
		System.out.println("질문게시글 갯수 : " + boardList.size() + "개");

		mv.addObject("listboard", boardList); // boardlist에 있는 데이터 저장
		mv.addObject("bestboard", bestList);
		mv.setViewName("Question_board"); // 뷰를 설정

		return mv; // boardlist전달
	}
	
	@RequestMapping(value = "/FreeBoard", method = {RequestMethod.POST,RequestMethod.GET} )
	public ModelAndView Free_board(ModelAndView mv, HttpSession session) throws Exception  {
		int boardType = 3;
		List<BoardListVO> boardList = boardListService.getBoardListService(boardType);
		List<BoardListVO> bestList = boardListService.getBestListService(boardType);
		System.out.println("자유게시글 갯수 : " + boardList.size() + "개");

		mv.addObject("listboard", boardList); // boardlist에 있는 데이터 저장
		mv.addObject("bestboard", bestList);
		mv.setViewName("Free_board"); // 뷰를 설정

		return mv; // boardlist전달
	}

	// 글 상세보기 Post_R, Comment_R
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public ModelAndView read(@RequestParam("boardNo") int boardNo,@RequestParam("boardType") int boardType, ModelAndView mv, HttpSession session)
			throws Exception {

		System.out.println("글 번호" + boardNo + "번의 상세내용 페이지 부르러 간다");
		System.out.println(boardListService.getReadService(boardNo, boardType));

		if (session.getAttribute("userId") != null) {
			boardListService.countViewService(boardNo, boardType);
		}

		// setAttribute와 똑같음!! jsp에서 불러올땐 list.하고 불러오면 된드아
		mv.addObject("list", boardListService.getReadService(boardNo, boardType));
		mv.addObject("commentList", boardListService.getCommentListService(boardNo, boardType));
		mv.addObject("boardType",boardType);
		mv.setViewName("read");

		return mv;

	}

	// 글 작성 화면 Post_C
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public ModelAndView write(HttpSession session, ModelAndView mv) throws Exception {
		String msg = "NoWriteUser";
		if (session.getAttribute("userId") == null) {
			mv.setViewName("redirect:login");
			mv.addObject("msg",msg);
			return mv;
		} else {
			mv.setViewName("writeform");
			return mv;
		}
	}

	// 글 추가 Post_C
	@RequestMapping(value = "/writeCheck", method = RequestMethod.POST)
	public ModelAndView writeCheck(@ModelAttribute BoardListVO vo, @RequestParam("boardType") int boardType,
			ModelAndView mv, HttpSession session) throws Exception {
		String msg = "NoWriteUser";
		/*if((String)session.getAttribute("user_id") == null) {
			mv.setViewName("redirect:login");
			mv.addObject("msg",msg);
		}*/
		
		boardListService.insertService(vo, boardType);
		if(boardType == 0){
			mv.setViewName("redirect:main");
			return mv;
		} else if(boardType == 1) {
			mv.setViewName("redirect:TipBoard");
			return mv;
		}else if(boardType == 2) {
			mv.setViewName("redirect:QuestionBoard");
			return mv;
		}else {
			mv.setViewName("redirect:FreeBoard");
			return mv;
		}
	}

	// 글 수정 화면 Post_U
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public ModelAndView update(@RequestParam("boardNo") int boardNo, HttpSession session, ModelAndView mv,@RequestParam("boardType") int boardType) throws Exception {
		if (session.getAttribute("userId") == null) {
			mv.setViewName("redirect:main");
			return mv;
		}
		mv.addObject("list", boardListService.getReadService(boardNo, boardType));
		mv.addObject("boardType", boardType);
		mv.setViewName("updateform");
		return mv;
	}

	// 글 수정 확인 Post_U
	@RequestMapping(value = "/updateCheck", method = RequestMethod.POST)
	public ModelAndView updateCheck(@ModelAttribute BoardListVO vo ,@RequestParam("boardType") int boardType, ModelAndView mv) throws Exception {
		
		boardListService.updateService(vo, boardType);
		System.out.println("수정 완료");
		mv.setViewName("redirect:read?boardNo="+vo.getBoardNo()+"&boardType="+boardType);
		return mv;
	}

	// 글 삭제 Post_D
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String deleteCheck(@RequestParam("boardNo") int boardNo, HttpSession session,@RequestParam("boardType") int boardType) throws Exception {
		String userId = (String) session.getAttribute("userId");
		boardListService.deleteService(boardNo, boardType);
		if (userId == null) {
			System.out.println("작성자 :  + /*vo.getBoard_user()*/ , 삭제자 : " + userId);
			return "redirect:main";
		}else if(boardType == 0){
			System.out.println("삭제 완료");
			return "redirect:main";
		} else if(boardType == 1) {
			System.out.println("삭제 완료");
			return "redirect:TipBoard";
		}else if(boardType == 2) {
			System.out.println("삭제 완료");
			return "redirect:QuestionBoard";
		}else {
			System.out.println("삭제 완료");
			return "redirect:FreeBoard";
		}
		
	}

	// 댓글 추가 Comment_C
	@RequestMapping(value = "/comment", method = RequestMethod.POST)
	public String insertComment(@ModelAttribute CommentVO vo, @RequestParam("boardNo") int boardNo, HttpSession session,@RequestParam("boardType") int boardType,
			ModelAndView mv) throws Exception {
		/*
		 * String userId = (String) session.getAttribute("userId"); String alert = null;
		 * if (userId == null) { alert = "insertCommentError"; mv.addObject("alert",
		 * alert); return "login"; } else {
		 */
		
		boardListService.insertCommentService(vo, boardNo, session);

		System.out.println("댓글 작성 완료");
		return "redirect:read?boardNo=" + boardNo+"&boardType="+boardType;
	}

	// 댓글 수정 Comment_U
	@RequestMapping(value = "/updateComment", method = RequestMethod.GET)
	public String updateCommentCheck(@ModelAttribute CommentVO vo, @RequestParam("boardNo") int boardNo,@RequestParam("boardType") int boardType,
			HttpSession session) throws Exception {
		String userId = (String) session.getAttribute("userId");
		boardListService.updateCommentService(vo);
		if (userId != vo.getCommentUser()) {
			System.out.println("작성자 : " + vo.getCommentUser() + " , 수정자 : " + userId);
			return "redirect:main";
		}
		System.out.println("댓글 수정 완료");
		return "redirect:read?boardNo=" + boardNo+"&boardType="+boardType;
	}

	// 댓글 삭제 Comment_D
	@RequestMapping(value = "/deleteComment", method = RequestMethod.GET)
	public String deleteCommentCheck(@RequestParam("boardNo") int boardNo, @RequestParam("commentNo") int commentNo, @RequestParam("boardType") int boardType
			,HttpSession session) throws Exception {
		String userId = (String) session.getAttribute("userId");
		boardListService.deleteCommentService(commentNo, session);
		if (userId == null) {
			System.out.println("삭제자 : " + userId);
			return "redirect:main";
		}else {
		System.out.println("댓글 삭제 완료");
		
		return "redirect:read?boardNo=" + boardNo+"&boardType="+boardType;
		}
	}

	

}
