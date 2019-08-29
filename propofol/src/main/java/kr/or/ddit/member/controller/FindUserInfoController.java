package kr.or.ddit.member.controller;

import java.security.NoSuchAlgorithmException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.exception.UserNotFoundException;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.utils.SendMail;
import kr.or.ddit.utils.SendSMS;
import kr.or.ddit.vo.MemberVO;

@Controller
@RequestMapping(value="/find/findMember")
public class FindUserInfoController {
	@Inject
	IMemberService service;
	
	@GetMapping(value="userId")
	public String userInfoId() {
		return "find/findMember/findId";
	}
	
	@GetMapping(value="userPw")
	public String userInfoPw() {
		return "find/findMember/findPass";
	}
	
	/**
	 * 핸드폰 인증을 통한 비밀번호 찾기
	 * @param user
	 * @param mem_tel
	 * @return
	 */
	@PostMapping(value="phone", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> msgProcess(@RequestParam String user,
			@RequestParam String mem_tel,
			HttpSession session){
		Map<String, Object> result = new LinkedHashMap<String, Object>();
		boolean empty = false;	//공백체크 변수 -> 비어 있으면 true, 채워져 있으면 false
		boolean duplicated = false;	//아이디 일치 여부, 일치하면  true, 안하면 false
		boolean telChk = false; //전화번호 일치 여부 일치하면 true, 아니면 false
		String confirm = null;	//인증 번호 담을 변수
		String message = null;
		MemberVO mv = new MemberVO();
		if(StringUtils.isBlank(user)) {	//이름 혹은 아이디가 비었다
			empty = true;
		}else {
			try {
				mv = service.retrieveMember(user);
				duplicated = true;
				if(StringUtils.isNotBlank(mem_tel)) {	//전화번호가 채워져서 왔다.
					if(mv.getMem_tel().equals(mem_tel)) {	//넘어온 전화번호와 가입시 전화번호가 일치한다.
						telChk = true;
						confirm = SendSMS.SendMsg(mem_tel);
						message = "인증번호가 발송 되었습니다.";
					}else {	//일치하지 않는다.
						message = "전화번호가 일치하지 않습니다!!";
					}
				}else {	//전화번호가 공백이다.
					empty =true;
					message = "전화번호는 공백일 수 없습니다.";
				}
			} catch (UserNotFoundException e) {
				message = user + " 회원을 찾을 수 없습니다.";
			}
		}//이름 혹은 아이디가 안 비었다.
		
		result.put("empty", empty);
		result.put("duplicated", duplicated);
		result.put("message", message);
		result.put("telChk", telChk);
		
		session.setAttribute("confirm", confirm);
		
		return result;
	}
	
	/**
	 * 핸드폰 인증번호 확인
	 * @param user
	 * @param mem_tel
	 * @param confirmNum
	 * @param session
	 * @return
	 */
	@PostMapping(value="check", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> confirmChk(@RequestParam String confirmNum,
			HttpSession session){
		Map<String, Object> result = new LinkedHashMap<>();
		String message = null;
		boolean chk = false;
		String possible = null;
		if(session.getAttribute("confirm") != null) {
			possible = (String) session.getAttribute("confirm");
			if(StringUtils.isNotBlank(confirmNum)) {
				if(possible.equals(confirmNum)) {
					message = "인증에 성공했습니다~. 비밀번호를 변경해주세용~";
					chk = true;
					session.removeAttribute("confirm");
				}else {
					message = "인증번호가 같지 않습니다. 다시 입력해주세요";
				}
			}else {
				message = "인증번호는 공백일 수 없습니다.";
			}
		}else {
			message = "요청이 만료되었습니다. 인증번호를 다시 발급받아주세요";
		}
		
		result.put("chk", chk);
		result.put("message", message);
		return result;
	}
	
	/**
	 * 회원의 비밀번호 수정
	 * @return
	 * @throws NoSuchAlgorithmException 
	 */
	@PutMapping
	public String modifyUser(@RequestParam String user, 
			@RequestParam String mem_pass,
			RedirectAttributes redirectAttributes) throws NoSuchAlgorithmException {
		String goPage = null;
		ServiceResult result = null;
		if(StringUtils.isNotBlank(user) && StringUtils.isNotBlank(mem_pass)) {
			MemberVO mv = new MemberVO(user, mem_pass);
			result = service.modifyPass(mv);
			if(ServiceResult.OK.equals(result)) {
				goPage = "redirect:/";
				redirectAttributes.addFlashAttribute("message", "비밀번호가 성공적으로 바뀌었습니다!!");
			}else {
				goPage = "find/findMember/findPass";
				redirectAttributes.addFlashAttribute("message", "비밀번호 변경에 실패했습니다..ㅠ!!");
			}
		}else {
			goPage = "find/findMember/findPass";
			redirectAttributes.addFlashAttribute("message", "아이디 또는 비밀번호가 공백입니다.");
		}
		return goPage;
	}
	
	/**
	 * 비밀번호 찾기 시 이메일 인증
	 * @return
	 */
	@PostMapping(value="mail", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> mailPassProcess(@RequestParam String mem_mail, 
			@RequestParam String user,
			HttpSession session){
		Map<String, Object> results = new LinkedHashMap<>();
		MemberVO mv = new MemberVO();
		ServiceResult result = null;	//메일 성공여부
		boolean duplicated = false;//회원 유무 - 없으면 false, 있으면 true
		boolean mailChk = false;//메일 체크 여부 - 없으면 falase, 있으면 true
		
		int rnd = (int)((Math.random() * 100000) + 100000);
		String rnds = String.valueOf(rnd);
		
		String title = null;	//메세지 제목
		String content = null;//메세지 내용
		String message = null;
		if(StringUtils.isNotBlank(user) && StringUtils.isNotBlank(mem_mail)) {//이름과 이메일이 공백이거나 비어있지 않다.
			try {
				mv = service.retrieveMember(user);
				duplicated = true;
				if(mv.getMem_mail().equals(mem_mail)) {//넘어온 email과 회원의 기존에 입력한 email과 같다
					mailChk = true;
					title = "Propofol에서 발송된 인증번호 입니다.";
					content = "고객님의 인증 번호는 [" + rnd + "] 입니다. Propofol 화면에 인증 번호를 입력해주세요!";
					result = SendMail.naverMailSend(mem_mail, title, content);
					if(ServiceResult.OK.equals(result)) {	//메일 성공했다
						session.setAttribute("mailConfirm", rnds);
						message = "인증번호 발송에 성공했습니다. 메일을 확인해주세요!";
					}else {//실패했다.
						message = "인증번호 발송에 실패했습니다. 잠시후 다시 시도해주세요!";
					}
				}else {//이메일이 같지 않다.
					message = "가입시 작성한 이메일 주소와 같지 않습니다!";
				}
			} catch (UserNotFoundException e) {
				message="해당 아이디로 존재하는 회원이 없습니다. 아이디를 확인해 주세요";
			}
		}else {//비어있다.
			message="아이디와 비밀번호는 공백일 수 없습니다.";
		}
		results.put("duplicated", duplicated);
		results.put("mailChk", mailChk);
		results.put("message", message);
		return results;
	}
	
	/**
	 * 메일 인증 번호 확인
	 * @param confirmNum
	 * @param session
	 * @return
	 */
	@PostMapping(value="mailChk", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> MailPwConChk(@RequestParam String confirmNum,
			@RequestParam(required=false) String mem_name, @RequestParam(required=false) String mem_mail,
			HttpSession session){
		Map<String, Object> result = new LinkedHashMap<>();
		String message = null;
		StringBuffer bf = new StringBuffer();
		boolean chk = false;
		String possible = null;
		MemberVO member = new MemberVO();
		
		if(session.getAttribute("mailConfirm") != null) {
			possible = (String) session.getAttribute("mailConfirm");
			if(StringUtils.isNotBlank(confirmNum)) {
				if(possible.equals(confirmNum)) {
					bf.append("인증에 성공했습니다♥");
					chk = true;
					session.removeAttribute("mailConfirm");
				}else {
					message = "인증번호가 같지 않습니다. 다시 입력해주세요";
				}
			}else {
				message = "인증번호는 공백일 수 없습니다.";
			}
		}else {
			message = "요청이 만료되었습니다. 인증번호를 다시 발급받아주세요";
		}
		
		if(mem_name != null && mem_mail != null) {
			Object name = mem_name;
			Object mail = mem_mail;
			MemberVO mv = new MemberVO(name, mail);
			member = service.retrieveMemberForFindUserInfo(mv);
			String memId = member.getMem_id();
			int cnt = memId.length();
			String mem = memId.substring(0, cnt-3) + "***";
			bf.append("\n 회원님의 아이디는 " + mem + " 입니다.");
			result.put("ID", bf);
		}
		
		result.put("chk", chk);
		result.put("message", message);
		return result;
	}
	
	/**
	 * 메일로 아이디 찾긔
	 * @param mem_name
	 * @param mem_mail
	 * @param session
	 * @return
	 */
	@PostMapping(value="searching", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> findIdMail(@RequestParam String mem_name,
			@RequestParam String mem_mail,
			HttpSession session){
		Map<String, Object> results = new LinkedHashMap<>();
		ServiceResult result = null;	//메일 성공여부
		boolean duplicated = false;//회원 유무 - 없으면 false, 있으면 true
		boolean mailChk = false;//메일 체크 여부 - 없으면 falase, 있으면 true
		int rnd = (int)((Math.random() * 100000) + 100000);
		String rnds = String.valueOf(rnd);
		
		String title = null;	//메세지 제목
		String content = null;//메세지 내용
		String message = null;
		if(StringUtils.isNotBlank(mem_name) && StringUtils.isNotBlank(mem_mail)) {//이름과 이메일이 공백이거나 비어있지 않다.
			Object name = mem_name;
			Object mail = mem_mail;
			MemberVO mv = new MemberVO(name, mail);
			try {
				MemberVO member = new MemberVO();
				member = service.retrieveMemberForFindUserInfo(mv);
				duplicated = true;
				if(member.getMem_mail().equals(mem_mail)) {//넘어온 email과 회원의 기존에 입력한 email과 같다
					mailChk = true;
					title = "Propofol에서 발송된 인증번호 입니다.";
					content = "고객님의 인증 번호는 [" + rnd + "] 입니다. Propofol 화면에 인증 번호를 입력해주세요!";
					result = SendMail.naverMailSend(mem_mail, title, content);
					if(ServiceResult.OK.equals(result)) {	//메일 성공했다
						session.setAttribute("mailConfirm", rnds);
						message = "인증번호 발송에 성공했습니다. 메일을 확인해주세요!";
					}else {//실패했다.
						message = "인증번호 발송에 실패했습니다. 잠시후 다시 시도해주세요!";
					}
				}else {//이메일이 같지 않다.
					message = "가입시 작성한 이메일 주소와 같지 않습니다!";
				}
			} catch (UserNotFoundException e) {
				message="해당 아이디로 존재하는 회원이 없습니다. 아이디를 확인해 주세요";
			}
		}else {//비어있다.
			message="아이디와 비밀번호는 공백일 수 없습니다.";
		}
		results.put("duplicated", duplicated);
		results.put("mailChk", mailChk);
		results.put("message", message);
		return results;
	}
}
