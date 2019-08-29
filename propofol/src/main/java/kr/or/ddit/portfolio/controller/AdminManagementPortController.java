package kr.or.ddit.portfolio.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.portfolio.service.IPortfolioService;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.PortfolioVO;

@RestController
@RequestMapping(value = "/adminMenagement", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
public class AdminManagementPortController {

	@Inject
	IPortfolioService service;
	
	@GetMapping("allMemberPortList")
	public PagingVO<PortfolioVO> allMemberPortList(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false) String pf_searchType,
			@RequestParam(required = false) String pf_searchWord) {
		PagingVO<PortfolioVO> pagingVO = new PagingVO<PortfolioVO>(10, 3);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSearchType(pf_searchType);
		pagingVO.setSearchWord(pf_searchWord);
		pagingVO.setManageMentType("admin_all");

		long totalRecord = service.retrievePortCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);

		List<PortfolioVO> portfolioList = service.retrievePortList(pagingVO);
		pagingVO.setDataList(portfolioList);

		return pagingVO;
	}
	
	@GetMapping("blackPort")
	public Map<String, Object> blackPortfolio(
			@RequestParam(required = true) String black_num
	) {
		ServiceResult result = service.banPort(Integer.parseInt(black_num));
		Map<String, Object> resultMap = new HashMap<>();
		if(result.equals(ServiceResult.OK)) {
			resultMap.put("success", true);
			resultMap.put("message", "제제성공");
		}else {
			resultMap.put("success", false);
			resultMap.put("message", "제제실패");
		}
		
		return resultMap;
	}
	
	@GetMapping("readPort")
	public Map<String, Object> readPortfolio(
			@RequestParam(required = true) String read_num
	) {
		ServiceResult result = service.readPort(Integer.parseInt(read_num));
		Map<String, Object> resultMap = new HashMap<>();
		if(result.equals(ServiceResult.OK)) {
			resultMap.put("success", true);
			resultMap.put("message", "확인성공");
		}else {
			resultMap.put("success", false);
			resultMap.put("message", "확인실패");
		}
		
		return resultMap;
	}
	
	@GetMapping("unbanPort")
	public Map<String, Object> unbanPortfolio(
			@RequestParam(required = true) String unban_num
			) {
		ServiceResult result = service.unbanPort(Integer.parseInt(unban_num));
		Map<String, Object> resultMap = new HashMap<>();
		if(result.equals(ServiceResult.OK)) {
			resultMap.put("success", true);
			resultMap.put("message", "해제성공");
		}else {
			resultMap.put("success", false);
			resultMap.put("message", "해제실패");
		}
		
		return resultMap;
	}
	
	
	@GetMapping("sucMemberPortList")
	public PagingVO<PortfolioVO> sucMemberPortList(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false) String pf_searchType,
			@RequestParam(required = false) String pf_searchWord) {
		PagingVO<PortfolioVO> pagingVO = new PagingVO<PortfolioVO>(10, 3);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSearchType(pf_searchType);
		pagingVO.setSearchWord(pf_searchWord);
		pagingVO.setManageMentType("admin_suc");
		
		long totalRecord = service.retrieveSucPortCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<PortfolioVO> portfolioList = service.retrieveSucPortList(pagingVO);
		pagingVO.setDataList(portfolioList);
		
		return pagingVO;
	}
	
	@GetMapping("blackMemberPortList")
	public PagingVO<PortfolioVO> blackMemberPortList(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false) String pf_searchType,
			@RequestParam(required = false) String pf_searchWord) {
		PagingVO<PortfolioVO> pagingVO = new PagingVO<PortfolioVO>(10, 3);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSearchType(pf_searchType);
		pagingVO.setSearchWord(pf_searchWord);
		pagingVO.setManageMentType("admin_black");
		
		long totalRecord = service.retrievePortCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<PortfolioVO> portfolioList = service.retrievePortList(pagingVO);
		pagingVO.setDataList(portfolioList);
		
		return pagingVO;
	}
}
