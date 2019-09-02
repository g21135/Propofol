package kr.or.ddit.common.controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.WebUtils;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.exception.UserNotFoundException;
import kr.or.ddit.member.service.IAuthenticateService;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.utils.SecurityUtils;
import kr.or.ddit.utils.SendSMS;
import kr.or.ddit.vo.MemberVO;

@Controller
@RequestMapping(value="/login")
public class LoginController{
	@Inject
	IAuthenticateService service;
	@Inject
	IMemberService memberService;
	
	@Inject
	WebApplicationContext container;
	
	@ResponseBody
	@PostMapping(produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public Map<String, Object> process(@RequestParam(required=false) String mem_id, 
			@RequestParam(required=false) String mem_pass, 
			@RequestParam(required=false) String saveSession, 
			HttpSession session,
			HttpServletResponse resp) throws IOException, NoSuchAlgorithmException{
		
		Map<String, Object> resultMap = new LinkedHashMap<String, Object>();
		
		if(StringUtils.isBlank(mem_id)||StringUtils.isBlank(mem_pass)) {
			resultMap.put("msg","필수데이터 누락"); 
		}else {
			try {
				MemberVO member = new MemberVO(mem_id, mem_pass);
				Object result = service.authenticate(member);
				if(result instanceof MemberVO){
					
					if(StringUtils.isNotBlank(saveSession)) {//값이 있다
						if("check".equals(saveSession)) {//check다
							session.setAttribute("authMember", (MemberVO)result);
							resultMap.put("successId", mem_id); 
							resultMap.put("success", true);
							
							Cookie cookie = new Cookie("loginCookie", session.getId());
							cookie.setPath("/");
							int count = 60*60*24*7;
							cookie.setMaxAge(count);
							//쿠키 적용
							resp.addCookie(cookie);
							//로그인 상태 유지 시간
							Date sessionLimit = new Date(System.currentTimeMillis() + (1000 * count));
							member.setSession_id(session.getId());
							member.setSession_limite(sessionLimit);
							memberService.addSession(member);
						}
					}else {//값이 없다.
						session.setAttribute("authMember", (MemberVO)result);
						resultMap.put("successId", mem_id); 
						resultMap.put("success", true);
					}//아니다
					((HashSet<MemberVO>) container.getServletContext().getAttribute("userList")).add((MemberVO)result);
				}else {
					if(ServiceResult.INVALIDPASSWORD.equals(result)) {
						resultMap.put("failedId", mem_id); 
						resultMap.put("msg","비밀번호 오류"); 
					}else if(ServiceResult.NOTAVAILABLE.equals(result)){
				 		resultMap.put("msg","탈퇴 처리된 아이디입니다."); 
					}else {
						resultMap.put("msg", "블랙리스트 처리된 회원입니다. 자세한 사항은 문의게시판에 문의해주세요.");
					}
				}	
			} catch (UserNotFoundException e) {
				resultMap.put("msg","아이디 오류"); 
			}
		}
		return resultMap;
	}
	
	@GetMapping
	public String process(HttpSession session, 
			RedirectAttributes sessionScope,
			HttpServletRequest req, HttpServletResponse resp){
		if(session == null || session.isNew()) { 
			sessionScope.addFlashAttribute("msg", "로그인을 해주세요.");
		}else {
			MemberVO mv = (MemberVO)session.getAttribute("authMember");
			sessionScope.addFlashAttribute("msg", "로그아웃되었습니다.");
			Cookie cookie = WebUtils.getCookie(req, "loginCookie");

			if(cookie != null) {
				cookie.setPath("/");
				cookie.setMaxAge(0);
				resp.addCookie(cookie);
				//사용자 테이블의 세션유지 시간을 현재 시간으로 변경
				Date date = new Date(System.currentTimeMillis());
				mv.setSession_id(session.getId());
				mv.setSession_limite(date);
				memberService.addSession(mv);
			}
			session.invalidate();
		}
		return "redirect:/";
	}
}
