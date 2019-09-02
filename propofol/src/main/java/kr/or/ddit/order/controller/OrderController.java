package kr.or.ddit.order.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.order.service.IOrderService;
import kr.or.ddit.portfolio.dao.IBasicPageDAO;
import kr.or.ddit.portfolio.service.IPortfolioService;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.OrderTbVO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.PortfolioVO;

@Controller
@RequestMapping(value = "/order")
public class OrderController {
	
	@Inject
	IOrderService service;

    @Inject
    IPortfolioService portService;
    @ResponseBody
	@GetMapping(value="myOrderList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
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
	
    @ResponseBody
	@GetMapping(value="adminOrderList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
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
	
    @ResponseBody
	@GetMapping(value="adminOrder_modifyList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
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
	
    @ResponseBody
	@GetMapping(value="adminOrder_produceList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
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
	
    @ResponseBody
	@GetMapping(value="choiceOrder", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
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
	
    @ResponseBody
	@GetMapping(value="completion", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
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
	
	@PostMapping(value="make")
	public String update(
			@RequestParam(name="port_num",required=false)Integer port_num, 
			Model model, 
			HttpSession session,
			HttpServletRequest req) {
			PortfolioVO pv = portService.retrievePort(port_num);
			model.addAttribute("pv",pv);
			session.setAttribute("make_id", pv.getMem_id());
			return "makePortfolio/main";
	}
}
