package kr.or.ddit.member.controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.common.UpdateGroup;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.exception.UserNotFoundException;
import kr.or.ddit.member.dao.IMemberDAO;
import kr.or.ddit.member.service.IAuthenticateService;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.vo.MemberVO;

@Controller
@RequestMapping(value="/member/members")
public class MemberController {
	
	@Inject
	IMemberService service;
	@Inject
	IAuthenticateService authService;
	@Inject
	IMemberDAO dao;
	
	/**
	 * 회원의 상세정보 확인
	 * @return
	 * @throws NoSuchAlgorithmException 
	 */
	@GetMapping("{mem_id}")
	public String process(@PathVariable(required=true) String mem_id, 
			Model model) throws NoSuchAlgorithmException {
		MemberVO mv = new MemberVO(mem_id);
		mv = service.retrieveMember(mem_id);
		model.addAttribute("mv",mv);
		return "member/members/memberMain";
	}	
	
	/**
	 * 회원 탈퇴
	 * @param mem_id
	 * @param mem_pass
	 * @return
	 * @throws NoSuchAlgorithmException 
	 */
	@DeleteMapping
	public String deleteMember(@RequestParam(required=true) String mem_id, 
			@RequestParam(required=true) String mem_pass,
			@RequestParam(required=true) String chk,
			HttpSession session,
			RedirectAttributes redirectAttributes
			) throws NoSuchAlgorithmException{
		MemberVO mv = new MemberVO(mem_id, mem_pass);
		ServiceResult result = null;
		String goPage = null;
		String message = null;
		if(authService.authenticate(mv) instanceof MemberVO && "Y".equals(chk)) {
			result = service.removeMember(mv);
			if(ServiceResult.OK.equals(result)) {
				goPage = "redirect:/";
				session.invalidate();
			}else {
				goPage = "redirect:/member/members/leave/" + mem_id;
				message = "서버 오류 입니다... 죄송합니다..ㅠ 잠시뒤에 다시 시도해 주세요!!";
				redirectAttributes.addFlashAttribute("message", message);
			}
		}else {
			goPage = "redirect:/member/members/leave/" + mem_id;
			message = "비밀번호가 일치하지 않습니다!";
			redirectAttributes.addFlashAttribute("message", message);
		}
		return goPage;
	}
	
	/**
	 * 회원정보 수정
	 * @param mv
	 * @param errors
	 * @return
	 * @throws NoSuchAlgorithmException 
	 */
	@PutMapping(produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> modifyMember(@Validated(UpdateGroup.class) MemberVO mv,
			Errors errors) throws NoSuchAlgorithmException{
		Map<String, Object> success = new LinkedHashMap<>();
		ServiceResult result = null;
		
		boolean valid = !errors.hasErrors(); 
		if(valid) {
			result = service.modifyMember(mv);
			if(ServiceResult.OK.equals(result)) {
				success.put("success", true);
			}else {
				success.put("success", false);
			}
		}else {
			success.put("errors", errors);
		}
		
		return success;
	}
	
	/**
	 * 회원정보 수정으로 넘어가는 페이지
	 * @param mem_id
	 * @param mem_pass
	 * @param model
	 * @return
	 * @throws NoSuchAlgorithmException
	 */
	@PostMapping(value="memberContent")
	public String update(@RequestParam(required=true) String mem_id, 
			@RequestParam(required=false) String mem_pass, 
			Model model,
			RedirectAttributes redirectAttributes) throws NoSuchAlgorithmException {
		MemberVO mv = new MemberVO(mem_id, mem_pass);
		Map<String, Object> results = new LinkedHashMap<>();
		boolean success = true;
		String message = null;
		String goPage = null;
		if(StringUtils.isBlank(mem_pass)) {
			success = false;
			message = "비밀번호는 공백일 수 없습니다!!";
			goPage = "redirect:/member/members/" + mem_id;
			redirectAttributes.addFlashAttribute("message", message);
		}else {
			if(authService.authenticate(mv) instanceof MemberVO) {
				results.put("success", success);
				mv = service.retrieveMember(mem_id);
				model.addAttribute("mv", mv);
				goPage = "member/members/memberContent";
			}else {
				success = false;
				message = "비밀번호가 틀렸습니다!!";
				goPage = "redirect:/member/members/" + mem_id;
				redirectAttributes.addFlashAttribute("message", message);
//				results.put("success", success);
//				results.put("message", message);
			}//else end
		}//else end
		
		return goPage;
	}
	
	
	/**
	 * 회원가입
	 * @param mv
	 * @param errors
	 * @param model
	 * @return
	 * @throws NoSuchAlgorithmException 
	 */
	@PostMapping(produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> createMember(@Valid MemberVO mv,
			Errors errors,
			Model model, HttpServletRequest request) throws NoSuchAlgorithmException {
		Map<String, Object> results = new LinkedHashMap<>();
		boolean valid = !errors.hasErrors();
		ServiceResult result = null;
		if(valid) {
			result = service.createMember(mv);
			switch (result) {
			case OK:
				results.put("success", true);
				break;
			default:
				results.put("success", false);
				break;
			}
		}else {
			results.put("success", false);
			results.put("errors", errors);
		}
		return results;
	}
	
	/**
	 * 아이디 중복체크
	 * @param mem_id
	 * @return
	 */
	@PostMapping(value="idChk", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> idChkProcess(@RequestParam(required=true) String mem_id){
		Map<String, Object> result = new LinkedHashMap<>();
		boolean duplicated = false;
		boolean empties = false;
		if(StringUtils.isBlank(mem_id)) {
			empties = true;
		}
		try {
			service.retrieveMember(mem_id);
			duplicated = true;
		}catch (UserNotFoundException e) {
			
		}
		result.put("success", true);
		result.put("duplicated", duplicated);
		result.put("empty", empties);
		return result;
	}
	
	/**
	 * 캡챠
	 * @param request
	 * @return
	 */
	@RequestMapping(value="VerifyRecaptcha", method=RequestMethod.POST)
	@ResponseBody
    public int VerifyRecaptcha(HttpServletRequest request) {
		VerifyRecaptcha.setSecretKey("6Ld3ybIUAAAAAIxxtqice4PDtqUqRLbyH5bHDjlE ");
        String gRecaptchaResponse = request.getParameter("recaptcha");
        System.out.println(gRecaptchaResponse);
        //0 = 성공, 1 = 실패, -1 = 오류
        try {
            if(VerifyRecaptcha.verify(gRecaptchaResponse))
                return 0;
            else return 1;
        } catch (IOException e) {
            e.printStackTrace();
            return -1;
        }
	}
	
//	@GetMapping(value="memberContent")
//	public String memberContent() {
//		return "member/members/memberContent";
//	}
	
	@RequestMapping(value="leave/{mem_id}")
	public String memberLeaver() {
		return "member/members/leave";
	}
}
