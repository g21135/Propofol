package kr.or.ddit.portfolio.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="/managementPort")
public class ManagementPortfolioController {
	@GetMapping
	public String main() {
		return "managementPortfolio/main";
	}
}
