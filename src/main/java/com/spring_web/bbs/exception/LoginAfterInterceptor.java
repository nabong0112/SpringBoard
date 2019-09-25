package com.spring_web.bbs.exception;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
//여기는 만약 로그인 세션이 있는 상태에서 회원가입이나 로그인을 한번더 할때 체크해서 메인으로 리다이렉트 해주는 파일
public class LoginAfterInterceptor extends HandlerInterceptorAdapter{
	
	private static final Logger logger = LoggerFactory.getLogger(LoginAfterInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
		
		HttpSession session = request.getSession();
		if(session.getAttribute("user_id") != null) {
			response.sendRedirect(request.getContextPath() + "main");
			return false;
		}
		return true;
	}

}
