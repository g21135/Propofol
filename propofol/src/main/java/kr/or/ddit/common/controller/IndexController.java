package kr.or.ddit.common.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.or.ddit.naverLogin.service.NaverLoginBO;

@Controller
public class IndexController {
	
	@Inject
	NaverLoginBO naverLoginBO;
	
	@GetMapping("/")
	public String index(Model model, HttpSession session) {
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		session.setAttribute("url", naverAuthUrl);
		
		return "index";
	}
	
	@GetMapping("/portfolioList")
	public String portfolioList() {
		return "portfolio/portfolioList";
	}
	
	@GetMapping("/sucPortfolioList")
	public String sucPortfolioList() {
		return "portfolio/successPortfolio";
	}
	
	@GetMapping("/allMemPort")
	public String allMemPort() {
		return "managementPortfolio/manage_admin/allMemberPortList";
	}
	
	@GetMapping("/sucMemPort")
	public String sucMemPort() {
		return "managementPortfolio/manage_admin/sucMemberPortList";
	}
	
	@GetMapping("/blackMemPort")
	public String blackMemPort() {
		return "managementPortfolio/manage_admin/blackMemberPortList";
	}
	
	@GetMapping("/orderPortfolio")
	public String orderPortfolio() {
		return "managementPortfolio/manage_admin/orderPortfolioList";
	}
	
	@GetMapping("/order_producePortfolio")
	public String order_producePortfolio() {
		return "managementPortfolio/manage_admin/order_producePortfolioList";
	}
	
	@GetMapping("/order_modifyPortfolio")
	public String order_modifyPortfolio() {
		return "managementPortfolio/manage_admin/order_modifyPortfolioList";
	}
	
	@GetMapping("/myPortfolio")
	public String myPortfolio() {
		return "managementPortfolio/manage_member/myPortList";
	}
	
	@GetMapping("/temporaryPortfolio")
	public String temporaryPortfolio() {
		return "managementPortfolio/manage_member/temporaryPortList";
	}
	
	@GetMapping("/myOrder")
	public String myOrder() {
		return "managementPortfolio/manage_member/myOrderList";
	}
	
	
}
