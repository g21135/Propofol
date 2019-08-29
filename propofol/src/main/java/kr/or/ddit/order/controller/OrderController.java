package kr.or.ddit.order.controller;

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
import kr.or.ddit.order.service.IOrderService;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.OrderTbVO;
import kr.or.ddit.vo.PagingVO;

@RestController
@RequestMapping(value = "/order", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
public class OrderController {
	
	@Inject
	IOrderService service;
	
	@GetMapping("myOrderList")
	public PagingVO<OrderTbVO> myOrderList(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false) String pf_searchType,
			@RequestParam(required = false) String pf_searchWord,
			HttpSession session) {
		PagingVO<OrderTbVO> pagingVO = new PagingVO<OrderTbVO>(10, 5);
		MemberVO memberVO = new MemberVO();
		memberVO = (MemberVO) session.getAttribute("authMember");
		
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSearchType(pf_searchType);
		pagingVO.setSearchWord(pf_searchWord);
		pagingVO.setManageMentType("member");
		pagingVO.setManageMentId(memberVO.getMem_id());

		long totalRecord = service.retrieveOrderCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);

		List<OrderTbVO> portfolioList = service.retrieveOrderList(pagingVO);
		pagingVO.setDataList(portfolioList);

		return pagingVO;
	}
	
	@GetMapping("adminOrderList")
	public PagingVO<OrderTbVO> adminOrderList(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false) String pf_searchType,
			@RequestParam(required = false) String pf_searchWord,
			HttpSession session) {
		PagingVO<OrderTbVO> pagingVO = new PagingVO<OrderTbVO>(10, 5);
		
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSearchType(pf_searchType);
		pagingVO.setSearchWord(pf_searchWord);
		pagingVO.setManageMentType("admin_orderList");
		
		long totalRecord = service.retrieveOrderCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<OrderTbVO> portfolioList = service.retrieveOrderList(pagingVO);
		pagingVO.setDataList(portfolioList);
		
		return pagingVO;
	}
	
	@GetMapping("adminOrder_modifyList")
	public PagingVO<OrderTbVO> adminOrderModifyList(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false) String pf_searchType,
			@RequestParam(required = false) String pf_searchWord,
			HttpSession session) {
		MemberVO memVO = new MemberVO();
		memVO = (MemberVO) session.getAttribute("authMember");
		
		PagingVO<OrderTbVO> pagingVO = new PagingVO<OrderTbVO>(10, 5);
		
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSearchType(pf_searchType);
		pagingVO.setSearchWord(pf_searchWord);
		pagingVO.setManageMentType("admin_order_modifyList");
		pagingVO.setManageMentId(memVO.getMem_id());
		
		long totalRecord = service.retrieveOrderCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<OrderTbVO> portfolioList = service.retrieveOrderList(pagingVO);
		pagingVO.setDataList(portfolioList);
		
		return pagingVO;
	}
	
	@GetMapping("adminOrder_produceList")
	public PagingVO<OrderTbVO> adminOrderProduceList(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false) String pf_searchType,
			@RequestParam(required = false) String pf_searchWord,
			HttpSession session) {
		PagingVO<OrderTbVO> pagingVO = new PagingVO<OrderTbVO>(10, 5);
		MemberVO memVO = new MemberVO();
		memVO = (MemberVO) session.getAttribute("authMember");
		
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSearchType(pf_searchType);
		pagingVO.setSearchWord(pf_searchWord);
		pagingVO.setManageMentType("admin_order_produceList");
		pagingVO.setManageMentId(memVO.getMem_id());
		
		long totalRecord = service.retrieveOrderCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<OrderTbVO> portfolioList = service.retrieveOrderList(pagingVO);
		pagingVO.setDataList(portfolioList);
		
		return pagingVO;
	}
	
	@GetMapping("choiceOrder")
	public Map<String, Object> choiceOrder(
			@RequestParam(required = true) Integer choice_num,
			@RequestParam(required = true) String admin_id
			) {
		OrderTbVO orderVO = new OrderTbVO();
		orderVO.setOrder_num(choice_num);
		orderVO.setAdmin_id(admin_id);
		ServiceResult result = service.choiceOrder(orderVO);
		Map<String, Object> resultMap = new HashMap<>();
		if(result.equals(ServiceResult.OK)) {
			resultMap.put("success", true);
			resultMap.put("message", "승인성공");
		}else {
			resultMap.put("success", false);
			resultMap.put("message", "승인실패");
		}
		
		return resultMap;
	}
	
	@GetMapping("completion")
	public Map<String, Object> completion(
			@RequestParam(required = true) Integer completion_num
			) {
		ServiceResult result = service.completionOrder(completion_num);
		Map<String, Object> resultMap = new HashMap<>();
		if(result.equals(ServiceResult.OK)) {
			resultMap.put("success", true);
			resultMap.put("message", "업데이트성공");
		}else {
			resultMap.put("success", false);
			resultMap.put("message", "업데이트실패");
		}
		
		return resultMap;
	}
	
}
