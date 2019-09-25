package com.spring_web.bbs.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring_web.bbs.repository.LoginDAO;

@Service("loginService")
public class LoginServiceImpl implements LoginService{
	@Autowired
	LoginDAO loginDAO;
	
	
}
