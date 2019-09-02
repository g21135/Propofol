package kr.or.ddit.Pay.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.Pay.service.IPayService;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.OrderTbVO;

@Controller
public class payController {

	@Inject
	IPayService service;

	@RequestMapping("/addPayment")
	@GetMapping
	public String payment() {
		return "Pay/addPayment";
	}
	
	@RequestMapping("/PayList")
	@GetMapping
	public String paylist() {
		return "Pay/PayList";
	}
	
	@GetMapping(value="/resultPayment")
	public String modifyMeberShip(
			@RequestParam String mem_id,
			@RequestParam int mem_membership,
			@RequestParam String mem_rank,
			@RequestParam int mem_price,
			RedirectAttributes redirectAttributes) {
		MemberVO mv = new MemberVO();
		mv.setMem_id(mem_id);
		mv.setMem_membership(mem_membership);
		OrderTbVO ot = new OrderTbVO();
		ot.setMem_id(mem_id);
		ot.setOrder_cost(mem_price);
		ot.setOrder_type(mem_rank);
		ServiceResult mvresult = null;
		ServiceResult odresult = null;
		String goPage = null;
		mvresult = service.ModifyMemberShip(mv);
		odresult = service.createOrderList(ot);
		if(ServiceResult.OK.equals(mvresult)) {
			if(ServiceResult.OK.equals(odresult)) {
				redirectAttributes.addFlashAttribute("msg", "프리미엄 구매에  성공하셨습니다.");
				goPage = "redirect:/";
			}else {
				redirectAttributes.addFlashAttribute("msg", "실패 하셨습니다.");
				goPage = "PayList";
			}
		}else {
			redirectAttributes.addFlashAttribute("msg", "프리미엄 구매에 실패 하셨습니다.");
			goPage = "PayList";
		}
		return goPage;
	}
}
