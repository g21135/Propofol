package kr.or.ddit.common.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

	
@Controller
public class testController {
	
	@GetMapping("/test")
	public String index(Model model, HttpSession session) {
		return "makePortfolio/test";
	}
}
