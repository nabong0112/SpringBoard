package com.spring_web.bbs.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.spring_web.bbs.service.BoardListServiceImpl;
import com.spring_web.bbs.vo.BoardListVO;

public class BoardController {
	@Autowired
	BoardListServiceImpl boardListService;
	
	@RequestMapping(value = "/", method=RequestMethod.GET)
	public ModelAndView home(ModelAndView mv) {
		
		List<BoardListVO> boardlist = null;
		try {
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		for(int i = 0; i <boardlist.size(); i++) {
			System.out.println("");
		}
		
		mv.addObject("listboard", boardlist);
		mv.setViewName("main/mainview");
		
		return mv;
	}
}
