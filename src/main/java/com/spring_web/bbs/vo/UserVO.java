package com.spring_web.bbs.vo;

public class UserVO {
	String userId;
	String userPw;
	String userName;
	String joinTime;
	String userIdQustion;
	String userIdAnswer;
	String userJender;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPw() {
		return userPw;
	}
	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getJoinTime() {
		return joinTime;
	}
	public void setJoinTime(String joinTime) {
		this.joinTime = joinTime;
	}
	public String getUserIdQustion() {
		return userIdQustion;
	}
	public void setUserIdQustion(String userIdQustion) {
		this.userIdQustion = userIdQustion;
	}
	public String getUserIdAnswer() {
		return userIdAnswer;
	}
	public void setUserIdAnswer(String userIdAnswer) {
		this.userIdAnswer = userIdAnswer;
	}
	public String getUserJender() {
		return userJender;
	}
	public void setUserJender(String userJender) {
		this.userJender = userJender;
	}
}
