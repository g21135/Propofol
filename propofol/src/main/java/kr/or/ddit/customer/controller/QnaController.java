package kr.or.ddit.customer.controller;

import java.io.IOException;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
@RequestMapping(value="/qna")
public class QnaController {
	@Inject
	ICustomerService service;
	@Inject
	IMemberService memberService;
	@Inject
	IAlarmService alarmService;
	
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
		pagingVO.setSearchVO(new CustomerVO(4));
		pagingVO.setTotalRecord(service.retrieveCustomerCount(pagingVO));
		List<CustomerVO> qnaList = service.retrieveCustomerList(pagingVO);
		pagingVO.setDataList(qnaList);
		model.addAttribute("pagingVO", pagingVO);
		return "qna/qnaList";
	}
	
	@PostMapping("pass")
	public String pass(@RequestParam int customer_num, String customer_pass, HttpSession session) {
		String message = null;
		String goPage = null;
		CustomerVO savaCustomer = service.retrieveCustomer(customer_num);
		if(savaCustomer.getCustomer_pass().equals(customer_pass)) {
			goPage = "redirect:" + customer_num;
		}else {
			message = "비밀번호 오류입니다!!";
			goPage = "redirect:/qna";
		}
		session.setAttribute("message", message);
		return goPage;
	}
	
	@GetMapping("{customer_num}")
	public String view(@PathVariable(required=true) int customer_num, Model model){
		CustomerVO qna = service.retrieveCustomer(customer_num);
		model.addAttribute("qna", qna);
		return "qna/qnaView";   
	}
	
	@GetMapping("question")
	public String doInsert(){
		return "qna/qnaForm";
	}
	
	@PostMapping("question")
	public String insert(@Validated(InsertGroup.class) CustomerVO customer, Errors errors, Model model) {
		boolean valid = !errors.hasErrors();
		String goPage = null;
		String message = null;
		if (valid) {
			ServiceResult result = service.createQuestion(customer);
			if(ServiceResult.OK.equals(result)) {
				goPage = "redirect:/qna";
			}else {
				message = "서버 오류입니다, 다시 시도해주세요.";
				goPage = "qna/qnaForm";
			}
		} else {
			goPage = "qna/qnaForm";
		}
		model.addAttribute("message", message);
		return goPage;
	}
	
	@GetMapping(value="question/{customer_num}")
	public String doUpdate(@PathVariable int customer_num, Model model){
		CustomerVO customer = service.retrieveCustomer(customer_num);
		model.addAttribute("customer", customer);
		return "qna/qnaForm";
	}
	
	@PostMapping("question/{customer_num}")
	public String update(@Validated(UpdateGroup.class) CustomerVO customer, Errors errors, Model model) {
		boolean valid = !errors.hasErrors();
		String goPage = null;
		String message = null;
		if (valid) {
			ServiceResult result = service.modifyQuestion(customer);
			if(ServiceResult.OK.equals(result)) {
				goPage = "redirect:/qna/"+ customer.getCustomer_num();
			}else {
				message = "서버 오류입니다, 다시 시도해주세요.";
				goPage = "qna/qnaForm";
			}
		} else {
			goPage = "qna/qnaForm";
		}
		model.addAttribute("message", message);
		return goPage;
	}
	
	@PostMapping("answer")
	public String answer(CustomerVO customer, Errors errors, Model model) {
		boolean valid = !errors.hasErrors();
		String goPage = null;
		String message = null;
		String title = null;	//메세지 제목
		String content = null;//메세지 내용
		String mem_mail = null;//메세지 내용
		MemberVO member = memberService.retrieveMember(customer.getMem_id());
		mem_mail = member.getMem_mail();
		if (valid) {
			ServiceResult result = service.modifyAnswer(customer);
			if(ServiceResult.OK.equals(result)) {
				title = "Propofol에서 작성한 고객님의 질문 답변";
				content = customer.getMem_id() + "님이 작성하신 [" + customer.getCustomer_question() + "]의 질문에 답변이 작성되었습니다.";
				ServiceResult mailresult = SendMail.naverMailSend(mem_mail, title, content);
				if(ServiceResult.OK.equals(mailresult)) {
					String mem_id = member.getMem_id();
					String notice_content = mem_id + "님의 질문에 답변이 등록되었습니다";
					String url = "qna/" + customer.getCustomer_num();
					NoticeVO nv = new NoticeVO(mem_id, notice_content, url);
					alarmService.createAlarm(nv);
					goPage = "redirect:/qna/"+ customer.getCustomer_num();
				}else {
					message = "메일 전송에 실패했습니다.";
				}
			}else {
				message = "서버 오류입니다, 다시 시도해주세요.";
				goPage = "redirect:/qna/"+ customer.getCustomer_num();
			}
		} else {
			goPage = "redirect:/qna/"+ customer.getCustomer_num();
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
				goPage = "redirect:/qna";
			}else {
				message = "서버 오류입니다, 다시 시도해주세요.";
				goPage = "redirect:/qna";
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
