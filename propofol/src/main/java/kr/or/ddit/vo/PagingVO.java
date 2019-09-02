package kr.or.ddit.vo;

import java.io.Serializable;
import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor // 기본생성자
public class PagingVO<T> implements Serializable {

	public PagingVO(int screenSize, int blockSize) {
		super();
		this.screenSize = screenSize;
		this.blockSize = blockSize;
	}

	private int screenSize = 10; // 한 화면에 보여줄 레코드 수
	private int blockSize = 5; // 한번에 보여줄 페이지 블록 수

	private long totalRecord; // 전체 게시글 수
	private long totalPage; // 전체 페이지 수

	private long currentPage; // 현재 선택한 페이지

	private long startRow; // 스크린에서 첫번째 레코드
	private long endRow; // 스크린에서 마지막 레코드

	private long startPage; // 페이지 블럭에서 첫번째 페이지
	private long endPage; // 페이지 블럭에서 마지막 페이지

	private List<T> dataList;// 제네릭, 타입변수
	private List<PortLikeVO> dataList2;// 제네릭, 타입변수

	private String searchType;
	private String searchWord;
	private String manageMentType;
	private String manageMentId;

	private T searchVO;
	private Integer role;
	
	private String mem_id;
	
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	
	public void setRole(Integer role) {
		this.role = role;
	}
	
	public void setSearchVO(T searchVO) {
		this.searchVO = searchVO;
	}

	private String funcName = "paging";

	public void setFuncName(String funcName) {
		this.funcName = funcName;

	}

	/**
	 * totalRecord 와 totalPage를 연산
	 * 
	 * @param totalRecord
	 */
	public void setTotalRecord(long totalRecord) {
		this.totalRecord = totalRecord;
		this.totalPage = (totalRecord + (screenSize - 1)) / screenSize;
	}

	public void setCurrentPage(long currentPage) {
		this.currentPage = currentPage;
		this.endRow = screenSize * currentPage;
		this.startRow = endRow - (screenSize - 1);
		this.endPage = ((currentPage + (blockSize - 1)) / blockSize) * blockSize;
		this.startPage = endPage - (blockSize - 1);

	}

	public void setDataList(List<T> dataList) {
		this.dataList = dataList;
	}
	public void setDataList2(List<PortLikeVO> dataList2) {
		this.dataList2 = dataList2;
	}

	String pattern = "<a href='#' onclick='%s(%d)'>[%s]</a>";

	// @JsonProperty("pagingHTML") 이제는 javaBean 규약을 만족한다.
	public String getPagingHTML() {
		// String pattern = "<a href='?page=%d'>[%s]</a>";
		StringBuffer html = new StringBuffer();
		if (startPage > 1) {
			html.append(String.format(pattern, funcName, (startPage - 1), "이전"));
		}

		endPage = endPage > totalPage ? totalPage : endPage;
		for (long i = startPage; i <= endPage; i++) {
			if (currentPage == i) {
				html.append(i);
			} else {
				html.append(String.format(pattern, funcName, i, i + ""));
			}
		}
		if (endPage < totalPage) {
			html.append(String.format(pattern, funcName, (endPage + 1), "다음"));
		}
		return html.toString();
	}

	// String bootstrapPtrn = "<li %s><a href='#' onclick='%s'> %s </a></li>";
	//
	//// @JsonProperty("pagingHTMLForBS")
	// public String getPagingHTMLForBS() {
	// StringBuffer html = new StringBuffer();
	// html.append("<nav>");
	// html.append("<ul class='pagination justify-content-center'>");
	//
	// html.append(String.format(bootstrapPtrn,
	// (startPage>1?"":"class='disabled'"),
	// startPage>1? funcName + "("+(startPage-1)+");" : "return false;",
	// "<span aria-hidden='true'>«</span>"));
	//
	// endPage = endPage > totalPage ? totalPage : endPage;
	//
	// for(long i = startPage; i<=endPage; i++){
	// html.append(String.format(bootstrapPtrn,
	// currentPage==i?"class='active'":"",
	// funcName + "("+i+")",
	// i + (currentPage==i?"<span class='sr-only'>(current)</span>":"")));
	// }
	//
	// html.append(String.format(bootstrapPtrn,
	// (endPage<totalPage?"":"class='disabled'"),
	// endPage<totalPage?funcName + "("+(endPage+1)+");" : "return false;",
	// "<span aria-hidden='true'>»</span>"));
	// html.append("</ul>");
	// html.append("</nav>");
	// return html.toString();
	// }

	String pgPtrn = "%s <a href='#' onclick='%s' class='%s'> %s </a>";

	public String getPagingHTMLForBS() {
		StringBuffer html = new StringBuffer();
		html.append("<span class='pg'>");
		if (startPage > 1) {
			html.append(String.format(pgPtrn, "",
					startPage > 1 ? funcName + "(" + (startPage - 1) + ");" : "return false;", "pg_page", "≪"));
		}

		endPage = endPage > totalPage ? totalPage : endPage;

		for (long i = startPage; i <= endPage; i++) {
			if (currentPage == i) {
				html.append("<strong 	class='pg_current'>" + i + "</strong>");
			} else {
				html.append(String.format(pgPtrn, "", funcName + "(" + i + ")", "pg_page", i));
			}
		}

		if (endPage < totalPage) {
			html.append(String.format(pgPtrn, "",
					endPage < totalPage ? funcName + "(" + (endPage + 1) + ");" : "return false;", "pg_page", "≫"));
		}

		html.append("</span>");

		return html.toString();
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;

	}

	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}
	
	public void setManageMentType(String manageMentType) {
		this.manageMentType = manageMentType;
	}
	
	public void setManageMentId(String manageMentId) {
		this.manageMentId = manageMentId;
	}
}
