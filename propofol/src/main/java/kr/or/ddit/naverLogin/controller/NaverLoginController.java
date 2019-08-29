package kr.or.ddit.naverLogin.controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;

import com.github.scribejava.core.model.OAuth2AccessToken;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.exception.UserNotFoundException;
import kr.or.ddit.member.dao.IMemberDAO;
import kr.or.ddit.member.service.IAuthenticateService;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.naverLogin.service.NaverLoginBO;
import kr.or.ddit.utils.SecurityUtils;
import kr.or.ddit.vo.MemberVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class NaverLoginController {
	
	@Inject
	IMemberService service;
	
	@Inject
	IAuthenticateService authService;
	
	@Inject
	WebApplicationContext container;
	
	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;

	@Inject
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}
	
	// 네이버 로그인 성공시 callback호출 메소드
	@GetMapping(value = "/naverLogin",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session)
			throws IOException, ParseException, NoSuchAlgorithmException {
		
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);
		// 1. 로그인 사용자 정보를 읽어온다.
		apiResult = naverLoginBO.getUserProfile(oauthToken); // String형식의 json데이터
		/**
		 * apiResult json 구조 {"resultcode":"00", "message":"success",
		 * "response":{"id":"33666449","nickname":"shinn****",
		 * "age":"20-29","gender":"M","email":"shinn0608@naver.com",
		 * "name":"\uc2e0\ubc94\ud638"}}
		 **/
		// 2. String형식인 apiResult를 json형태로 바꿈
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;
		// 3. 데이터 파싱
		// Top레벨 단계 _response 파싱
		JSONObject response_obj = (JSONObject) jsonObj.get("response");
		// response의 nickname값 파싱
		// 4.파싱 닉네임 세션으로 저장
		MemberVO member = new MemberVO((String) response_obj.get("id"),(String) response_obj.get("id"));
		Object result = null;
		try {
			result = authService.authenticate(member);
			session.setAttribute("authMember", (MemberVO)result); // 세션 생성
			((Set<MemberVO>) container.getServletContext().getAttribute("userList")).add((MemberVO)result);
			
		} catch (UserNotFoundException e) {
			MemberVO insertMember = new MemberVO();
			insertMember.setMem_id((String) response_obj.get("id"));
			insertMember.setMem_pass(SecurityUtils.sha512((String) response_obj.get("id")));
			insertMember.setMem_name((String) response_obj.get("name"));
			insertMember.setMem_tel("소셜동의거부");
			insertMember.setLogin_type(2);
			
			if (StringUtils.isNotBlank((String) response_obj.get("email"))) {
				insertMember.setMem_mail((String) response_obj.get("email"));
			} else {
				insertMember.setMem_mail("소셜동의거부");
			}
			if (StringUtils.isNotBlank((String) response_obj.get("profile_image"))) {
				insertMember.setMem_image((String) response_obj.get("profile_image"));
			} else {
				insertMember.setMem_image("네이버 이미지");
			}
			if (StringUtils.isNotBlank((String) response_obj.get("gender"))) {
				insertMember.setMem_gen(((String) response_obj.get("gender")).equals("female") ? "F" : "M");
			} else {
				insertMember.setMem_gen("N");
			}

			ServiceResult resultJoin = service.createMember(insertMember);
			if(ServiceResult.OK.equals(resultJoin)) {
				session.setAttribute("authMember", insertMember); // 세션 생성
			}
		}
		return "redirect:/";
	}

	// 로그아웃
	@GetMapping(value = "/naverLogout")
	public String logout(HttpSession session) throws IOException {
		session.invalidate();
		return "redirect:/";
	}
}
