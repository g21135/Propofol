package kr.or.ddit.customer.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.common.InsertGroup;
import kr.or.ddit.common.UpdateGroup;
import kr.or.ddit.customer.service.ICustomerService;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.CustomerVO;
import kr.or.ddit.vo.PagingVO;

@Controller
@RequestMapping(value="/faq")
public class FaqController {
	@Inject
	ICustomerService service;
	
	@GetMapping(produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<CustomerVO> ajaxList(@RequestParam(name="page", required=false, defaultValue="1") int currentPage, String searchType, String searchWord, Model model) {
		list(currentPage, searchType, searchWord, model);
		return (PagingVO<CustomerVO>) model.asMap().get("pagingVO");
	}
	
	@GetMapping
	public String list(@RequestParam(name="page", required=false, defaultValue="1") int currentPage, String searchType, String searchWord, Model model) {
		PagingVO<CustomerVO> pagingVO = new PagingVO<CustomerVO>(10,5);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSearchType(searchType);
		pagingVO.setSearchWord(searchWord);
		pagingVO.setSearchVO(new CustomerVO(5));
		pagingVO.setTotalRecord(service.retrieveCustomerCount(pagingVO));
		List<CustomerVO> faqList = service.retrieveCustomerList(pagingVO);
		pagingVO.setDataList(faqList);
		model.addAttribute("pagingVO", pagingVO);
		return "faq/faqList";
	}
	
	@GetMapping("insert")
	public String doInsert(){
		return "faq/faqForm";
	}
	
	@PostMapping("insert")
	public String insert(@Validated(InsertGroup.class) CustomerVO customer, Errors errors, Model model) {
		boolean valid = !errors.hasErrors();
		String goPage = null;
		String message = null;
		if (valid) {
			ServiceResult result = service.createFaq(customer);
			if(ServiceResult.OK.equals(result)) {
				goPage = "redirect:/faq";
			}else {
				message = "서버 오류입니다, 다시 시도해주세요.";
				goPage = "faq/faqForm";
			}
		} else {
			goPage = "faq/faqForm";
		}
		model.addAttribute("message", message);
		return goPage;
	}
	
	@GetMapping(value="update/{customer_num}")
	public String doUpdate(@PathVariable int customer_num, Model model){
		CustomerVO customer = service.retrieveCustomer(customer_num);
		model.addAttribute("customer", customer);
		return "faq/faqForm";
	}
	
	@PostMapping("update/{customer_num}")
	public String update(@Validated(UpdateGroup.class) CustomerVO customer, Errors errors, Model model) {
		boolean valid = !errors.hasErrors();
		String goPage = null;
		String message = null;
		if (valid) {
			ServiceResult result = service.modifyFaq(customer);
			if(ServiceResult.OK.equals(result)) {
				goPage = "redirect:/faq";
			}else {
				message = "서버 오류입니다, 다시 시도해주세요.";
				goPage = "faq/faqForm";
			}
		} else {
			goPage = "faq/faqForm";
		}
		model.addAttribute("message", message);
		return goPage;
	}
	
	@DeleteMapping("delete")
	public String delete(@RequestParam int customer_num, Model model) {
		CustomerVO customer = new CustomerVO();
		customer.setCustomer_num(customer_num);
		String goPage = null;
		String message = null;
		ServiceResult result = service.removeCustomer(customer);
			if(ServiceResult.OK.equals(result)) {
				goPage = "redirect:/faq";
			}else {
				message = "서버 오류입니다, 다시 시도해주세요.";
				goPage = "redirect:/faq";
			}
		model.addAttribute("message", message);
		
		return goPage;
	}
}
