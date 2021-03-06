package com.dolbommon.dbmon.board;

public class NoticeBoardVO {

	private int no;
	private String userid;
	private String subject;
	private String content;
	private int hit;
	private String writedate;
	private String ip;
	
	private String filename1;
	private String filename2;
	
	private String filenames[] = new String[2];
	
	private String delfile[];
	private int nextNo;
	private int preNo;
	private String nextSubject;
	private String preSubject;
	private String expose;
	
	//페이징
	private int nowPage = 1;	//현재 페이지
	private int totalRecord;	//총 레코드 수
	private int totalPage;	//총 페이지 수
	private int onePageRecord = 10;	//한 페이지에 표시할 레코드 수
	private int onePageNumCount = 10;	//한번에 표시할 페이지 번호 숫자
	private int startPageNum = 1;	//페이지 번호의 시작페이지
	private int lastPageRecordCount = 20;	//마지막 페이지의 선택 레코드 수
	private int currentPageRecord = nowPage*onePageRecord;
		
	//검색어
	private String searchKey;
	private String searchWord;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public String getWritedate() {
		return writedate;
	}
	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getFilename1() {
		return filename1;
	}
	public void setFilename1(String filename1) {
		this.filename1 = filename1;
	}
	public String getFilename2() {
		return filename2;
	}
	public void setFilename2(String filename2) {
		this.filename2 = filename2;
	}
	public String[] getFilenames() {
		return filenames;
	}
	public void setFilenames(String[] filenames) {
		this.filenames = filenames;
		this.filename1 = filenames[0];
		this.filename2 = filenames[1];	
	}
	public String[] getDelfile() {
		return delfile;
	}
	public void setDelfile(String[] delfile) {
		this.delfile = delfile;
	}
	public int getNextNo() {
		return nextNo;
	}
	public void setNextNo(int nextNo) {
		this.nextNo = nextNo;
	}
	public int getPreNo() {
		return preNo;
	}
	public void setPreNo(int preNo) {
		this.preNo = preNo;
	}
	public String getNextSubject() {
		return nextSubject;
	}
	public void setNextSubject(String nextSubject) {
		this.nextSubject = nextSubject;
	}
	public String getPreSubject() {
		return preSubject;
	}
	public void setPreSubject(String preSubject) {
		this.preSubject = preSubject;
	}
	public String getExpose() {
		return expose;
	}
	public void setExpose(String expose) {
		this.expose = expose;
	}
	//페이징
	public int getNowPage() {
		return nowPage;
	}
	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
		currentPageRecord = nowPage*onePageRecord;
		//시작페이지 번호 계산
		startPageNum = (nowPage-1)/onePageNumCount*onePageNumCount+1;	
	}
	public int getTotalRecord() {
		return totalRecord;
	}
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
		
		//총 페이지 수 구하기
		totalPage = (int)Math.ceil((double)totalRecord/onePageRecord);
		
		//마지막 페이지에서 선택할 레코드 수
		if(nowPage==totalPage && totalRecord%onePageRecord!=0) {
			lastPageRecordCount = totalRecord%onePageRecord;
		}else {
			lastPageRecordCount = onePageRecord;
		}	
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getOnePageRecord() {
		return onePageRecord;
	}
	public void setOnePageRecord(int onePageRecord) {
		this.onePageRecord = onePageRecord;
	}
	public int getOnePageNumCount() {
		return onePageNumCount;
	}
	public void setOnePageNumCount(int onePageNumCount) {
		this.onePageNumCount = onePageNumCount;
	}
	public int getStartPageNum() {
		return startPageNum;
	}
	public void setStartPageNum(int startPageNum) {
		this.startPageNum = startPageNum;
	}
	public int getLastPageRecordCount() {
		return lastPageRecordCount;
	}
	public void setLastPageRecordCount(int lastPageRecordCount) {
		this.lastPageRecordCount = lastPageRecordCount;
	}
	public int getCurrentPageRecord() {
		return currentPageRecord;
	}
	public void setCurrentPageRecord(int currentPageRecord) {
		this.currentPageRecord = currentPageRecord;
	}
	public String getSearchKey() {
		return searchKey;
	}
	public void setSearchKey(String searchKey) {
		this.searchKey = searchKey;
	}
	public String getSearchWord() {
		return searchWord;
	}
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}
}
