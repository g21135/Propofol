package kr.or.ddit.order.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.order.service.IOrderService;
import kr.or.ddit.vo.OrderTbVO;

@Controller
@RequestMapping(value="/manager/sales")
public class ManagerOrderController {
	@Inject
	IOrderService service;
	
	@GetMapping("{mem_id}")
	public String sales() {
		return "member/manager/managerSales";
	}
	
	@PostMapping(produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<OrderTbVO> List(OrderTbVO orderTbVO) {
		List<OrderTbVO> list;
		if (orderTbVO.getOrder_date() != null) {
			//날짜 선택이 있을 시
			list = service.retrieveMonthOrderList(orderTbVO);
		}else if(orderTbVO.getOrder_type() != null) {
			//타입 선택 시
			list = service.retrieveTypeOrderList(orderTbVO);
		}else {
			//날짜 선택이 없을 시
			list =  service.retrieveManagerOrderList(orderTbVO);
		}
		return list;
	} 
}
