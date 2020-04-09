package com.yi.handler.paging;

public abstract class Paging {
	
	protected int page; //현재 페이지 번호
	protected int range; //현재 페이지 범위 (각 페이지 범위 시작 번호)
	protected int listCnt; //총 게시물 갯수
	protected int pageCnt; //총 페이지 범위의 갯수
	protected int listSize = 10; //한 페이지 목록의 갯수
	protected int rangeSize = 10; //한 페이지 범위의 갯수
	protected int startList;//게시판 시작 번호
	protected int startPage; //시작 번호
	protected int endPage; //끝 번호
	protected boolean prev; //이전 페이지 여부
	protected boolean next; //다음 페이지 여부
	
	
	public void pageInfo(int page, int range, int listCnt) {
		this.page = page;
		this.range = range;
		this.listCnt = listCnt;
		
		// 전체 페이지수
		this.pageCnt = (int) Math.ceil(listCnt / listSize);

		// 시작 페이지
		this.startPage = (range - 1) * rangeSize + 1;

		// 끝 페이지
		this.endPage = range * rangeSize;

		// 게시판 시작번호
		this.startList = (page - 1) * listSize;

		// 이전 버튼 상태
		this.prev = range == 1 ? false : true;

		// 다음 버튼 상태
		this.next = endPage > pageCnt ? false : true;

		if (this.endPage > this.pageCnt) {
			this.endPage = this.pageCnt;
			this.next = false;
		}

	}
	
	
}
