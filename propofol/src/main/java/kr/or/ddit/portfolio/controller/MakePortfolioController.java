package kr.or.ddit.portfolio.controller;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.portfolio.dao.IBasicPageDAO;
import kr.or.ddit.portfolio.service.IPortfolioService;
import kr.or.ddit.vo.BasicPageVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.OrderTbVO;
import kr.or.ddit.vo.PortfolioVO;
import kr.or.ddit.vo.TempVO;

@Controller
@RequestMapping(value="/makePortfolio")
public class MakePortfolioController{
    private static Logger logger = LoggerFactory.getLogger(MakePortfolioController.class);

    @Inject
    IPortfolioService service;
    
	@Inject
	IBasicPageDAO dao;
	
	@Inject
	WebApplicationContext container;

	@PostMapping
	public String main(
			@RequestParam(required=false)Integer theme_num,
			@RequestParam(required=false)Integer port_num,
			@RequestParam(required=false)String question_tel,
			@RequestParam(required=false)String question_sns,
			@RequestParam(required=false)String question_map, Model model,
			HttpSession session) {
			
			List<BasicPageVO> list = dao.selectList(theme_num);
			model.addAttribute("pageList",list);
			model.addAttribute("question_tel",question_tel);
			model.addAttribute("question_sns",question_sns);
			model.addAttribute("question_map",question_map);
			model.addAttribute("theme_num",theme_num);
		return "makePortfolio/main";
	}
	
	@PostMapping(value="update")
	public String update(
			@RequestParam(name="update_num",required=false)Integer port_num, 
			Model model, 
			HttpSession session,
			HttpServletRequest req) {
		
		MemberVO member = (MemberVO) session.getAttribute("authMember");
		int count = service.checkPort(member.getMem_id());
		if(count > 0) {
			PortfolioVO pv = service.retrievePort(port_num);
			model.addAttribute("pv",pv);
		}else {
			
			return "redirect:" + req.getHeader("referer");
		}
		return "makePortfolio/main";
	}
	@ResponseBody
	@PostMapping(value="deletePort",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public Map<String, Object> delete(
			@RequestParam(name="delete_num",required=false)Integer port_num, 
			Model model, 
			HttpSession session,
			HttpServletRequest req) {
		Map<String, Object> resultMap = new LinkedHashMap<String, Object>();
		MemberVO member = (MemberVO) session.getAttribute("authMember");
		int count = service.checkPort(member.getMem_id());
		if(count > 0) {
			ServiceResult result = service.deletePort(port_num);
			if(ServiceResult.OK.equals(result)) {
				resultMap.put("success", true);			
			}else {
				resultMap.put("success", false);			
			}	
		}else {
			resultMap.put("success", false);			
		}
		return resultMap;
	}
	
	@ResponseBody
	@PostMapping(value="updatePortInfo",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public Map<String, Object> updatePort(
			@Valid @ModelAttribute(name="port") PortfolioVO port) {
			Map<String, Object> resultMap = new LinkedHashMap<String, Object>();
			ServiceResult result = service.updatePort(port);
			if(ServiceResult.OK.equals(result)) {
				resultMap.put("success", true);			
			}else {
				resultMap.put("success", false);			
			}	
			return resultMap;
	}
	
	@GetMapping("{layout_name}")
	public String layout(@PathVariable(required= true)String layout_name) {
		return "makePortfolio/layout/"+layout_name;
	}
	
	@ResponseBody
	@GetMapping(value="checkPort",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public Map<String, Object> checkPort(HttpSession session) {
		MemberVO member = (MemberVO) session.getAttribute("authMember");
		
		Map<String, Object> resultMap = new LinkedHashMap<String, Object>();
		int count = service.checkPort(member.getMem_id());
		if(count > 0) {
			int cnt = service.checkMemberShip(member.getMem_id());
			if(cnt > 0) resultMap.put("success", true);			
			else resultMap.put("success", false);		
		}else {
			resultMap.put("success", true);			
		}	
		return resultMap;
	}
	
	@PostMapping(value="preview")
	public String preview(
			HttpServletRequest req, 
			@RequestParam(name="previewMenu",required=true) String[] menu,
			Model model) {
		String[] content = req.getParameterValues("previewContent");
		
		model.addAttribute("content", content);
		model.addAttribute("menu",menu);
		
		return "makePortfolio/preview";
	}	
	
	@ResponseBody
	@PostMapping(value="tempSave",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public Map<String,Object> tempSave(
			HttpServletRequest req, HttpSession session,
			@Valid
			@ModelAttribute("portVO") PortfolioVO pv,
			@RequestParam(name="tempSaveMenu",required=true) String[] temp_menu,
			Model model) {
		
		Map<String, Object> resultMap = new LinkedHashMap<String, Object>();
		String[] temp_page = req.getParameterValues("tempSaveContent");
		String[] page_img = req.getParameterValues("imgSrc");
		
		MemberVO mv = (MemberVO)session.getAttribute("authMember");
		if(mv == null) {
			resultMap.put("success",false);
			return resultMap;
		}
		
		pv.setMem_id(mv.getMem_id());
		
		TempVO[] tempArray = new TempVO[temp_page.length];
		
		for(int i = 0; i< temp_page.length; i++) {
			TempVO temp = new TempVO();
			temp.setTemp_page(temp_page[i]);
			temp.setTemp_menu(temp_menu[i]);
			temp.setPage_img(page_img[i]);
			tempArray[i] = temp;
		}		
		pv.setTempArray(tempArray);
		
		ServiceResult result = service.updateTempPort(pv);

		if(ServiceResult.OK.equals(result)) {
			resultMap.put("success",true);
			resultMap.put("pv",pv);
		}else {
			resultMap.put("success",false);
		}
		return resultMap;
	}	
	@ResponseBody
	@PostMapping(value="order",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)  
	public Map<String,Object> order(
			HttpSession session,
			@Valid
			@ModelAttribute("portVO") PortfolioVO pv,Errors error) {
		
		Map<String, Object> resultMap = new LinkedHashMap<String, Object>();

		MemberVO mv = (MemberVO)session.getAttribute("authMember");
		if(mv == null) {
			resultMap.put("success",false);
			return resultMap;
		}
		pv.setMem_id(mv.getMem_id());
		
		OrderTbVO ov = new OrderTbVO();
		ov.setMem_id(mv.getMem_id());
		ov.setOrder_type("제작");
		pv.setOv(ov);

		ServiceResult result = service.createPortAndOrder(pv);
		
		if(ServiceResult.OK.equals(result)) {
			resultMap.put("success",true);
		}else {
			resultMap.put("success",false);
			resultMap.put("error",error);
			
		}
		return resultMap;
	}	
}
