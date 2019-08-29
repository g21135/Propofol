package kr.or.ddit.Pay.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class payController {

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
}
