package kr.or.ddit.kakaoLogin.controller;

import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.exception.UserNotFoundException;
import kr.or.ddit.kakaoLogin.service.KakaoAPI;
import kr.or.ddit.member.dao.IMemberDAO;
import kr.or.ddit.member.service.IAuthenticateService;
import kr.or.ddit.vo.MemberVO;

@Controller
@RequestMapping(value = "/kakao")
public class KaKaoLoginController {

	@Inject
	private KakaoAPI kakao;

	@Inject
	IAuthenticateService service;

	@Inject
	IMemberDAO memberDao;
	
	@Inject
	WebApplicationContext container;

	@GetMapping
	public String process(HttpSession session, RedirectAttributes sessionScope) {
		if (session == null || session.isNew()) {
			sessionScope.addFlashAttribute("msg", "로그인을 해주세요.");
		} else {
			kakao.kakaoLogout((String) session.getAttribute("access_Token"));
			sessionScope.addFlashAttribute("msg", "로그아웃되었습니다.");
			session.invalidate();
		}
		return "redirect:/";
	}

	@GetMapping("kakaologin")
	public String login(@RequestParam("code") String code, HttpSession session) throws NoSuchAlgorithmException {
		String access_Token = kakao.getAccessToken(code);
		HashMap<String, Object> userInfo = kakao.getUserInfo(access_Token);
		System.out.println("login Controller : " + userInfo);

		Map<String, Object> resultMap = new LinkedHashMap<String, Object>();
		// 클라이언트의 이메일이 존재할 때 세션에 해당 이메일과 토큰 등록
		if (userInfo.get("email") != null) {
			MemberVO member = new MemberVO();
			member = kakao.retrieveKakao(userInfo);
			try {
				if (member == null) {
					resultMap.put("failedId", userInfo.get("id"));
					resultMap.put("msg", "오류");
				}else {
					MemberVO kakaoMember = new MemberVO((String)userInfo.get("id"), (String)userInfo.get("id"));
					Object result = service.authenticate(kakaoMember);
					session.setAttribute("authMember", (MemberVO)result);
					resultMap.put("authMember", member);
					resultMap.put("successId", member.getMem_id()); 
					((Set<MemberVO>) container.getServletContext().getAttribute("userList")).add((MemberVO)result);
					resultMap.put("success", true);
					session.setAttribute("access_Token", access_Token);
				}
				// session.setAttribute("id", userInfo.get("id"));
				// session.setAttribute("userId", userInfo.get("email"));
				// session.setAttribute("nickname", userInfo.get("nickname"));
				// session.setAttribute("profile_image", userInfo.get("profile_image"));
				// session.setAttribute("birthday", userInfo.get("birthday"));
				// session.setAttribute("gender", userInfo.get("gender"));
				
			} catch (Exception e) {
				resultMap.put("msg", "카카오 로그인 오류");
			}
		}
		session.setAttribute("resultMap", resultMap);
		return "redirect:/";
	}

}
