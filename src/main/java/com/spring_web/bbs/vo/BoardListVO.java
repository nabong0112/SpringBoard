package com.spring_web.bbs.vo;

public class BoardListVO {
	int boardNo;
	String boardTitle;
	String boardText;
	String boardUser;
	String boardTime;
	int boardCount;
	String boardDateTime;
	
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	public String getBoardText() {
		return boardText;
	}
	public void setBoardText(String boardText) {
		this.boardText = boardText;
	}
	public String getBoardUser() {
		return boardUser;
	}
	public void setBoardUser(String boardUser) {
		this.boardUser = boardUser;
	}
	public String getBoardTime() {
		return boardTime;
	}
	public void setBoardTime(String boardTime) {
		this.boardTime = boardTime;
	}
	public int getBoardCount() {
		return boardCount;
	}
	public void setBoardCount(int boardCount) {
		this.boardCount = boardCount;
	}
	public String getBoardDateTime() {
		return boardDateTime;
	}
	public void setBoardDateTime(String boardDateTime) {
		this.boardDateTime = boardDateTime;
	}
	@Override
	public String toString() {
		return "BoardListVO [BoardNo=" + boardNo + ", boardTitle=" + boardTitle + ", boardText=" + boardText
				+ ", boardUser=" + boardUser + ", boardTime=" + boardTime + ", boardView=" + boardCount + "]";
	}
}
