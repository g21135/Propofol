package kr.or.ddit.community.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/jobnews")
public class JobnewsController {

	@GetMapping
	public String jobnews() {
		return "coummunity/jobnews";
	}
}
