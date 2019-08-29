package kr.or.ddit.report.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.report.dao.IReportDAO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.ReportVO;

@Service
public class ReportServiceImpl implements IReportService {
	@Inject
	IReportDAO dao;

	@Override
	public ServiceResult createReport(ReportVO report) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = dao.insertReport(report);
		if (cnt > 0) {
			result = ServiceResult.OK;
		} 
		return result;
	}

	@Override
	public int retrieveReportCount(PagingVO<ReportVO> pagingVO) {
		return dao.selectReportListCount(pagingVO);
	}

	@Override
	public List<ReportVO> retrieveReportList(PagingVO<ReportVO> pagingVO) {
		return dao.selectReportList(pagingVO);
	}

	@Override
	public ReportVO retrieveReport(int report_num) {
		return dao.selectReport(report_num);
	}

	@Override
	public ServiceResult removeReport(int report_num) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = dao.deleteReport(report_num);
		if (cnt > 0) {
			result = ServiceResult.OK;
		} 
		return result;
	}
}
