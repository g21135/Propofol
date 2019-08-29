package kr.or.ddit.report.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.ReportVO;

@Repository
public interface IReportDAO {
	/**
	 * 신고 글 작성
	 * @param report
	 * @return
	 */
	public int insertReport(ReportVO report);
	
	/**
	 * 신고 전체 수 조회
	 * @param pagingVO(paging num, type_num)
	 * @return
	 */
	public int selectReportListCount(PagingVO<ReportVO> pagingVO);
	
	/**
	 * 신고 목록 조회
	 * @param pagingVO(paging num, type_num)
	 * @return
	 */
	public List<ReportVO> selectReportList(PagingVO<ReportVO> pagingVO);
	
	/**
	 * 신고 단일 조회
	 * @param report_num
	 * @return
	 */
	public ReportVO selectReport(int report_num);
	
	/**
	 * 신고 삭제
	 * @param report_num
	 * @return
	 */
	public int deleteReport(int report_num);
}
