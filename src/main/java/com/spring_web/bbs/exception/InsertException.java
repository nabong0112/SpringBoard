package com.spring_web.bbs.exception;

import org.springframework.web.bind.annotation.ExceptionHandler;

public class InsertException extends RuntimeException{
	
	private static final long serialVersionUID = 1L;
	
	public InsertException() {
		super("InsertDAOException Occurs");
	}
	
	public InsertException(String msg) {
		super(msg);
	}
	
	@ExceptionHandler(InsertException.class)
	public String handleInsertDAOException() {
		return "error/error";
	}
}
