package kr.or.ddit.customer.controller;

import java.io.IOException;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

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

import kr.or.ddit.alarm.service.IAlarmService;
import kr.or.ddit.common.InsertGroup;
import kr.or.ddit.common.UpdateGroup;
import kr.or.ddit.customer.service.ICustomerService;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.utils.SendMail;
import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.CustomerVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.NoticeVO;
import kr.or.ddit.vo.PagingVO;

@Controller
@RequestMapping(value="/suggest")
public class SuggestController {
	@Inject
	ICustomerService service;
	@Inject
	IAlarmService alarmService;
	@Inject
	IMemberService memberService;
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
		pagingVO.setSearchVO(new CustomerVO(6));
		pagingVO.setTotalRecord(service.retrieveCustomerCount(pagingVO));
		List<CustomerVO> qnaList = service.retrieveCustomerList(pagingVO);
		pagingVO.setDataList(qnaList);
		model.addAttribute("pagingVO", pagingVO);
		return "suggest/suggestList";
	}
	
	@GetMapping("{customer_num}")
	public String view(@PathVariable(required=true) int customer_num, Model model){
		CustomerVO suggest = service.retrieveCustomer(customer_num);
		model.addAttribute("suggest", suggest);
		return "suggest/suggestView";   
	}
	
	@GetMapping("insert")
	public String doInsert(){
		return "suggest/suggestForm";
	}

	@PostMapping("insert")
	public String insert(@Validated(InsertGroup.class) CustomerVO customer, Errors errors, Model model) {
		boolean valid = !errors.hasErrors();
		String goPage = null;
		String message = null;
		if (valid) {
			ServiceResult result = service.createSuggest(customer);
			if(ServiceResult.OK.equals(result)) {
				goPage = "redirect:/suggest/"+ customer.getCustomer_num();
			}else {
				message = "서버 오류입니다, 다시 시도해주세요.";
				goPage = "suggest/suggestForm";
			}
		} else {
			goPage = "suggest/suggestForm";
		}
		model.addAttribute("message", message);
		return goPage;
	}
	
	@GetMapping(value="/update/{customer_num}")
	public String doUpdate(@PathVariable int customer_num, Model model){
		CustomerVO customer = service.retrieveCustomer(customer_num);
		model.addAttribute("customer", customer);
		return "suggest/suggestForm";
	}
	
	@PostMapping("/update/{customer_num}")
	public String update(@Validated(UpdateGroup.class) CustomerVO customer, Errors errors, Model model) {
		boolean valid = !errors.hasErrors();
		String goPage = null;
		String message = null;
		if (valid) {
			ServiceResult result = service.modifySuggest(customer);
			if(ServiceResult.OK.equals(result)) {
				goPage = "redirect:/suggest/"+ customer.getCustomer_num();
			}else {
				message = "서버 오류입니다, 다시 시도해주세요.";
				goPage = "suggest/suggestForm";
			}
		} else {
			goPage = "suggest/suggestForm";
		}
		model.addAttribute("message", message);
		return goPage;
	}
	
	@PostMapping("answer")
	public String answer(CustomerVO customer, Errors errors, Model model) {
		boolean valid = !errors.hasErrors();
		String goPage = "redirect:/suggest/"+ customer.getCustomer_num();
		String message = null;
		String title = null;	//메세지 제목
		String content = null;//메세지 내용
		String mem_mail = null;//메세지 내용
		if (valid) {
			ServiceResult result = service.modifyAnswer(customer);
			if(ServiceResult.OK.equals(result)) {
				MemberVO member = memberService.retrieveMember(customer.getMem_id());
				mem_mail = member.getMem_mail();
				title = "Propofol에서 작성한 고객님의 건의사항에 대한 답변";
				content = customer.getMem_id() + "님이 작성하신 " + customer.getCustomer_question() + "의 건의에 답변이 작성되었습니다.";
				ServiceResult mailresult = SendMail.naverMailSend(mem_mail, title, content);
				if(ServiceResult.OK.equals(mailresult)) {
					message = "메일 전송에 성공했습니다.";
				}else {
					message = "메일 전송에 실패했습니다.";
				}
			}else {
				message = "서버 오류입니다, 다시 시도해주세요.";
			}
		} else {
			message = "서버 오류입니다, 다시 시도해주세요.";
		}
		model.addAttribute("message", message);
		return goPage;
	}
	
	@PostMapping("ing")
	public String ing(CustomerVO customer, Errors errors, Model model) {
		boolean valid = !errors.hasErrors();
		String goPage = null;
		String message = null;
		if (valid) {
			ServiceResult result = service.modifyIng(customer);
			if(ServiceResult.OK.equals(result)) {
				String mem_id = customer.getMem_id();
				String notice_content = mem_id + "회원님 건의의 진행상황이 [" + customer.getCustomer_check() + "]로 변경되었습니다.";
				String url = "suggest/" + customer.getCustomer_num();
				NoticeVO nv  = new NoticeVO(mem_id, notice_content, url);
				alarmService.createAlarm(nv);
				goPage = "redirect:/suggest/"+ customer.getCustomer_num();
			}else {
				message = "서버 오류입니다, 다시 시도해주세요.";
				goPage = "redirect:/suggest/"+ customer.getCustomer_num();
			}
		} else {
			goPage = "redirect:/suggest/"+ customer.getCustomer_num();
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
				goPage = "redirect:/suggest";
			}else {
				message = "서버 오류입니다, 다시 시도해주세요.";
				goPage = "redirect:/suggest";
			}
		model.addAttribute("message", message);
		
		return goPage;
	}
	
	@RequestMapping("download")
	public String process(@RequestParam(name="attach", required=true) String att_noStr, HttpServletResponse resp, Model model) throws IOException {
		AttachVO attach = service.download(Integer.parseInt(att_noStr));
		model.addAttribute("attach", attach);
		return "downloadView";
	}
}
