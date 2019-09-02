package kr.or.ddit.ppt.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.ppt.serivce.PPTApiService;

@Controller
public class PPTController {
	
	@Inject
	private PPTApiService ppt;
	
	@RequestMapping(value="/ppt")
	public String pptView() {
		return "ppt";
	}
	
	@RequestMapping(value="/made", method=RequestMethod.POST)
	public String pptMade(@RequestParam("pptData") String pptData) throws Exception {
		ppt.createImage(pptData);
		return "ppt";
	}
	
}
