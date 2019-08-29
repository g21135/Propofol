package kr.or.ddit.portfolio.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.portfolio.service.IPortfolioService;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.PortfolioVO;

@RestController
@RequestMapping(value = "/sucPortfolio", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
public class SuccessPortfolioRetrieveController {
	@Inject
	IPortfolioService service;

	@GetMapping
	public PagingVO<PortfolioVO> selectList(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage, 
			@RequestParam(required=false) String pf_searchType,
			@RequestParam(required=false) String pf_searchWord) {
		PagingVO<PortfolioVO> pagingVO = new PagingVO<PortfolioVO>(9,3);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSearchType(pf_searchType);
		pagingVO.setSearchWord(pf_searchWord);

		long totalRecord = service.retrieveSucPortCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);

		List<PortfolioVO> portfolioList = service.retrieveSucPortList(pagingVO);
		pagingVO.setDataList(portfolioList);

		return pagingVO;
	}
}
