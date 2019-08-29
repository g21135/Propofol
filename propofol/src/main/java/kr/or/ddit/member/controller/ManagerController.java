package kr.or.ddit.member.controller;

import java.security.NoSuchAlgorithmException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.member.dao.IMemberDAO;
import kr.or.ddit.member.service.IAuthenticateService;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.PagingVO;

@Controller
@RequestMapping(value="/member/manager")
public class ManagerController {

	@Inject
	IMemberService service;
	@Inject
	IAuthenticateService authService;
	@Inject
	IMemberDAO dao;
	
	@GetMapping("{mem_id}")
	public String process(@PathVariable(required=false) String mem_id, 
			@RequestParam(name="page", required=false, defaultValue="1")int currentPage,
			@RequestParam(required = false) String pf_searchType,
			@RequestParam(required = false) String pf_searchWord,
			Model model) throws NoSuchAlgorithmException {
		PagingVO<MemberVO> pagingVO = new PagingVO<>(5, 3);
		
		MemberVO mv = service.retrieveMember(mem_id);
		
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSearchType(pf_searchType);
		pagingVO.setSearchWord(pf_searchWord);
		pagingVO.setRole(mv.getGr_num());
		
		long totalRecord = service.retrieveMemberCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<MemberVO> memberList = service.retrieveMemberList(pagingVO);
		pagingVO.setDataList(memberList);
		model.addAttribute("memberList", pagingVO);
		model.addAttribute("mem_role", mv.getMem_role());
		
		return "member/manager/managerMain";
	}
	
	@PutMapping(produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> modifyMemberGrade(@RequestParam(required=true) String mem_id,
			@RequestParam(required=true) int managerGradeType){
		String memId = mem_id.trim();
		MemberVO mv = new MemberVO(memId, managerGradeType);
		ServiceResult result = null;
		result = service.modifyGrade(mv);
		
		Map<String, Object> results = new LinkedHashMap<String, Object>();
		
		if(ServiceResult.OK.equals(result)) {
			results.put("success", true);
			results.put("results", "회원의 등급 수정 성공~");
		}else {
			results.put("success", false);
			results.put("results", "실패에..ㅠㅠ");
		}
		return results;
	}
}
