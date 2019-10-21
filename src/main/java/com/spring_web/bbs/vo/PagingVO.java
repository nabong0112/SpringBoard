package com.spring_web.bbs.vo;

public class PagingVO {
	public int boardSize = 5; //한 페이지당 글 갯수
	public int pageSize = 7; //한번에 보여줄 페이지 갯수 ( 1 2 3 4 5 6 7 )
	public int writingCount; //총 글의 갯수 이건boardMapper에서 가져와야되겠네
	public int curPage = 1; //현
	int pageCount;
	int startPage;
	int endPage;
	boolean isPre;
	boolean isNext;
	int startWriting;
	int endWriting;
	 
	public int getBoardSize() {
		return boardSize;
	}


	public void setBoardSize(int boardSize) {
		this.boardSize = boardSize;
	}


	public int getPageSize() {
		return pageSize;
	}


	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}


	public int getWritingCount() {
		return writingCount;
	}


	public void setWritingCount(int writingCount) {
		this.writingCount = writingCount;
	}


	public int getCurPage() {
		return curPage;
	}


	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}


	public int getPageCount() {
		return ( (writingCount - 1) / boardSize) + 1;
	}


	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}


	public int getStartPage() {
		return ( ( curPage - 1 ) / pageSize ) * pageSize + 1;
	}


	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}


	public int getEndPage() {
		return Math.min( getStartPage() + pageSize - 1 , getPageCount() );
	}


	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}


	public boolean isPre() {
		return getStartPage() != 1;
	}


	public void setPre(boolean isPre) {
		this.isPre = isPre;
	}


	public boolean isNext() {
		  return getEndPage() < getPageCount();
	}


	public void setNext(boolean isNext) {
		this.isNext = isNext;
	}


	public int getStartWriting() {
		return getEndWriting() - boardSize + 1;
	}


	public void setStartWriting(int startWriting) {
		this.startWriting = startWriting;
	}


	public int getEndWriting() {
		return curPage * boardSize;
	}


	public void setEndWriting(int endWriting) {
		this.endWriting = endWriting;
	}
	
	public PagingVO(int boardSize, int pageSize, int writingCount,  int curPage) {
		  super();
		  this.boardSize = boardSize;
		  this.pageSize = pageSize;
		  this.writingCount = writingCount;
		  this.curPage = curPage;
		  this.startPage = getStartPage();
		  this.endPage = getEndPage();
		  this.startWriting = getStartWriting();
		  this.endWriting = getEndWriting();
		  this.isPre = isPre();
		  this.isNext = isNext();
		  this.pageCount = getPageCount();
		 }

}
