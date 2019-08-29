package kr.or.ddit.report.service;

import java.util.List;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.ReplyVO;
import kr.or.ddit.vo.ReportVO;

public interface IReportService {
	/**
	 * 신고 글 추가
	 * @param report
	 * @return
	 */
	public ServiceResult createReport(ReportVO report);
	
	/**
	 * 신고 목록 수 조회
	 * @param pagingVO
	 * @return
	 */
	public int retrieveReportCount(PagingVO<ReportVO> pagingVO);
	
	/**
	 * 신고 목록 조회
	 * @param pagingVO
	 * @return
	 */
	public List<ReportVO> retrieveReportList(PagingVO<ReportVO> pagingVO);
	
	/**
	 * 신고 목록 조회
	 * @param pagingVO
	 * @return
	 */
	public ReportVO retrieveReport(int report_num);
	
	/**
	 * 성공 실패
	 * @param report_num
	 * @return
	 */
	public ServiceResult removeReport(int report_num);
}
