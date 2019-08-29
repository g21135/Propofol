package kr.or.ddit.community.controller;




import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/recruit")
public class CommunityPageControllers {
	
	@GetMapping
	public String recruit() {
		return "coummunity/recruit";
	}
	
	
}
