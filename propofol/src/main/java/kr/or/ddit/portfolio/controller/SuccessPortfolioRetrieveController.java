package kr.or.ddit.portfolio.controller;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.alarm.service.IAlarmService;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.portLike.service.IPortLikeService;
import kr.or.ddit.portfolio.service.IPortfolioService;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.NoticeVO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.PortLikeVO;
import kr.or.ddit.vo.PortfolioVO;

@RestController
@RequestMapping(value = "/sucPortfolio", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
public class SuccessPortfolioRetrieveController {
	@Inject
	IPortfolioService service;
	@Inject
	IPortLikeService likeService;
	@Inject
	IAlarmService alarmService;
	
	@GetMapping
	public PagingVO<PortfolioVO> selectList(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage, 
			@RequestParam(required=false) String pf_searchType,
			@RequestParam(required=false) String pf_searchWord,
			HttpSession session) {
		PagingVO<PortfolioVO> pagingVO = new PagingVO<PortfolioVO>(9,3);
		MemberVO member = new MemberVO();
		String mem_id = null;
		if(null != session.getAttribute("authMember")) {
			member = (MemberVO) session.getAttribute("authMember");
			mem_id = member.getMem_id();
		}
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSearchType(pf_searchType);
		pagingVO.setSearchWord(pf_searchWord);
		pagingVO.setSearchVO(new PortfolioVO(mem_id));
		long totalRecord = service.retrieveSucPortCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<PortfolioVO> portfolioList = service.retrieveSucPortList(pagingVO);
		pagingVO.setDataList(portfolioList);
		return pagingVO;
	}
	
	@PostMapping
	public Map<String, Object> like(@RequestParam int port_num, String mem_id){
		Map<String, Object> resultMap = new LinkedHashMap<String, Object>();
		PortLikeVO portLike = new PortLikeVO(port_num, mem_id);
		ServiceResult result = likeService.createLike(portLike);
		if(ServiceResult.OK.equals(result)) {
			PortfolioVO pvo = service.retrievePort(portLike.getPort_num());
			String alarmMem_id = pvo.getMem_id();
			String content = portLike.getMem_id() + " 님이 [" + pvo.getPort_name() + "] 에 좋아요를 눌렀습니다.";
			String url = "myPortfolio" ;
			NoticeVO noticeVO  = new NoticeVO(alarmMem_id, content, url);
			alarmService.createAlarm(noticeVO);
			resultMap.put("success", true);
			resultMap.put("message", "좋아요 성공!");
		}else {
			resultMap.put("success", false);
			resultMap.put("message", "좋아요 실패했습니다.");
		}
		return resultMap;
	}
	
	@DeleteMapping
	public Map<String, Object> delete(@RequestParam int port_num, String mem_id){
		Map<String, Object> resultMap = new LinkedHashMap<String, Object>();
		PortLikeVO portLike = new PortLikeVO(port_num, mem_id);
		ServiceResult result = likeService.deleteLike(portLike);
		if(ServiceResult.OK.equals(result)) {
			resultMap.put("success", true);
			resultMap.put("message", "좋아요 취소");
		}else {
			resultMap.put("success", false);
			resultMap.put("message", "좋아요 취소에 실패했습니다.");
		}
		return resultMap;
	}
}
