package kr.or.ddit.introduction.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IntroductionController {

		@RequestMapping("/homeintroduction")
		public String Introduction() {
			return "introduction/homeintroduction";
		}
		
		@RequestMapping("/operationPolicy")
		public String operationPolicy() {
			return "introduction/operationPolicy";
		}
		
		@RequestMapping("/directions")
		public String directions() {
			return "introduction/directions";
		}
		
		@RequestMapping("/instructions")
		public String instructions() {
			return "introduction/instructions";
		}

		@RequestMapping("/slider")
		public String slider() {
			return "introduction/slider";
		}

}
