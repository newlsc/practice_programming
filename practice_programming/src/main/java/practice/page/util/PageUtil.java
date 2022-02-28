package practice.page.util;


public class PageUtil {
	
	// 요청 페이지 번호
	private int no;
	// 게시물 총 개수
	private int countList;
	// 한 페이지에 출력할 게시물 수
	private int postNum = 10;
	// 하단 페이징 번호 ([ 게시물 총 갯수 ÷ 한 페이지에 출력할 갯수 ]의 올림)
	private int pageNum;
	// 출력할 게시물
	private int displayPost;
	// 한번에 표시될 페이지 번호의 개수(1 ~ 10, 11 ~ 20, 21 ~ 30.......)
	private int pageNumCount = 10;
	// 표시되는 페이지 번호 중 마지막 번호(11 페이지 선택 시 20이 됨, 22 페이지 선택 시 30이 됨 - 올림 처리됨)
	private int endPageNum;
	// 표시되는 페이지 번호 중 첫번째 번호
	private int startPageNum;
	// 이전, 다음, 맨 앞, 맨 뒤
	private boolean prev;
	private boolean next;
	private int firstPage = 1;
	private int lastPage;

	public void setNo(int no) {
		 this.no = no;
		}
	public void setCountList(int countList) {
		this.countList = countList;
		dataCal();
	}
	public int getCount() {
		return countList;
	}
	public int getPostNum() {
		return postNum;
	}

	public int getPageNum() {
		return pageNum;
	}
	public int getDisplayPost() {
		return displayPost;
	}
	public int getPageNumCount() {
		return pageNumCount;
	}
	public int getEndPageNum() {
		return endPageNum;
	}
	public int getStartPageNum() {
		return startPageNum;
	}
	public boolean getPrev() {
		return prev;
	} 
	public boolean getNext() {
		return next;
	}
	public int getFirstPage() {
		return firstPage;
	}
	public int getLastPage() {
		return lastPage;
	}
		
	// 계산용 메서드
	private void dataCal() {
		// 표시되는 페이지 번호 중 마지막 번호(11 페이지 선택 시 20이 됨, 22 페이지 선택 시 30이 됨 - 올림 처리됨)
		endPageNum = (int)(Math.ceil((double)no / (double)pageNumCount) * pageNumCount);
		// 표시되는 페이지 번호 중 첫번째 번호
		startPageNum = endPageNum - (pageNumCount -1);
		// 마지막 번호 재계산
		int endPageNum_tmp = (int) (Math.ceil(((double)countList) / (double)pageNumCount));
		if (endPageNum > endPageNum_tmp) {
			endPageNum = endPageNum_tmp;
		}
		// 이전, 다음, 맨 뒤
		prev = startPageNum == 1 ? false : true;
		next = endPageNum * pageNumCount >= countList ? false : true;
		lastPage = (int) Math.ceil(countList * 1.0 / postNum);
		// 출력할 게시물
		displayPost = (no - 1) * postNum;
	}

	
	
	
	
}
