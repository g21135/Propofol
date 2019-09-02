package kr.or.ddit.portfolio.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.portfolio.service.IPortfolioService;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.PortfolioVO;

@RestController
@RequestMapping(value = "/memberMenagement", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
public class MemberManagementPortController {

	@Inject
	IPortfolioService service;
	
	@GetMapping("myPortList")
	public PagingVO<PortfolioVO> myPortList(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			HttpSession session) {
		PagingVO<PortfolioVO> pagingVO = new PagingVO<PortfolioVO>(6, 5);
		MemberVO memberVO = new MemberVO();
		memberVO = (MemberVO) session.getAttribute("authMember");
		
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setManageMentType("member");
		pagingVO.setManageMentId(memberVO.getMem_id());

		long totalRecord = service.retrievePortCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);

		List<PortfolioVO> portfolioList = service.retrieveMyPortList(pagingVO);
		pagingVO.setDataList(portfolioList);

		return pagingVO;
	}
	
	@GetMapping("updatePort")
	public Map<String, Object> updatePortfolio(
			@RequestParam(required = true) String update_num
			) {
		// 수정버튼클릭 -> 제작페이지 -> 현재 포트폴리오 jsp가 제작가능? 임시저장? -> 수정..
		
		PortfolioVO portVO = new PortfolioVO();
		portVO = service.retrievePort(Integer.parseInt(update_num));
		ServiceResult result = service.modifyPort(portVO);
		
		Map<String, Object> resultMap = new HashMap<>();
		if(result.equals(ServiceResult.OK)) {
			resultMap.put("success", true);
			resultMap.put("message", "수정성공");
		}else {
			resultMap.put("success", false);
			resultMap.put("message", "수정실패");
		}
		
		return resultMap;
	}
	
	@GetMapping("publicSetting")
	public Map<String, Object> publicSetting(
			@RequestParam(required = true) Integer port_num,
			@RequestParam(required = true) String port_public
			) {
		// 수정버튼클릭 -> 제작페이지 -> 현재 포트폴리오 jsp가 제작가능? 임시저장? -> 수정..
		
		PortfolioVO portVO = new PortfolioVO();
		portVO.setPort_num(port_num);
		portVO.setPort_public(port_public);
		ServiceResult result = service.portPublicSetting(portVO);
		
		Map<String, Object> resultMap = new HashMap<>();
		if(result.equals(ServiceResult.OK)) {
			resultMap.put("success", true);
			resultMap.put("message", "공개설정 변경성공");
		}else {
			resultMap.put("success", false);
			resultMap.put("message", "공개설정 변경실패");
		}
		
		return resultMap;
	}
	
	@GetMapping("config")
	public PortfolioVO config(
			@RequestParam(required = true) Integer config_num
			) {
		
		PortfolioVO resultVO = service.retrievePort(config_num);
		
		return resultVO;
	}
}
