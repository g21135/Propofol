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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.post.service.IPostService;
import kr.or.ddit.report.service.IReportService;
import kr.or.ddit.utils.SendMail;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.PostVO;
import kr.or.ddit.vo.ReportVO;

@Controller
@RequestMapping(value="/manager/report")
public class ManagerReportController {
	@Inject
	IReportService reportService;
	@Inject
	IPostService postService;
	@Inject
	IMemberService memberService;
	
	@PostMapping(produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> ajax(@RequestParam String report_num){
		Map<String, Object> success = new LinkedHashMap<>();
		String message = "";
		ReportVO report = reportService.retrieveReport(Integer.parseInt(report_num));
		PostVO post = postService.retrievePost(report.getPost_num());
		if(report != null && post != null) {
			success.put("report", report);
			success.put("post", post);
		}else {
			message = "정보를 가져오지 못했습니다.";
		}
		success.put("message", message);
		return success;
	}
	
	@GetMapping("{mem_id}")
	public String process(@RequestParam(name="page", required=false, defaultValue="1")int currentPage, Model model) throws NoSuchAlgorithmException {
		PagingVO<ReportVO> pagingVO = new PagingVO<>(5, 3);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setTotalRecord(reportService.retrieveReportCount(pagingVO));
		List<ReportVO> reportList = reportService.retrieveReportList(pagingVO);
		pagingVO.setDataList(reportList);
		model.addAttribute("pagingVO", pagingVO);
		
		return "member/manager/managerReportCheck";
	}
	
	@PostMapping(value="delete", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> delete(@RequestParam int post_num, @RequestParam int report_num) {
		Map<String, Object> success = new LinkedHashMap<>();
		PostVO post = postService.retrievePost(post_num);
		ReportVO report = reportService.retrieveReport(report_num);
		MemberVO member = memberService.retrieveMember(report.getMem_id_from());
		String message = null;
		String title = "[Propofol] 신고 게시글 확인 완료했습니다.";
		String content = member.getMem_name() + "님이 신고하신 " + report.getReport_content() + "게시글을 제재했습니다. 감사합니다.";
		if(post == null) {
			message = "해당 게시글이 없습니다.";
		}else {
			ServiceResult postResult = postService.removeReportPost(post);
			if(ServiceResult.FAILED.equals(postResult)) {
				message = "이미 삭제 처리된 게시글입니다. 작성한 회원에게 이메일 전송.";
				if(member.getMem_mail() != null) {
					SendMail.naverMailSend(member.getMem_mail(), title, content);
				}
				reportService.removeReport(report_num);
			}else {
				message = "삭제 완료. 작성한 회원에게 이메일 전송.";
				if(member.getMem_mail() != null) {
					SendMail.naverMailSend(member.getMem_mail(), title, content);
				}
				reportService.removeReport(report_num);
			}
		}
		success.put("message", message);
		return success;
	}
	
	@PostMapping(value="update", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> update(@RequestParam int post_num, @RequestParam int report_num, Model model) {
		Map<String, Object> success = new LinkedHashMap<>();
		PostVO post = postService.retrievePost(post_num);
		ReportVO report = reportService.retrieveReport(report_num);
		MemberVO member = memberService.retrieveMember(report.getMem_id_from());
		
		String message = null;
		String title = "[Propofol] 신고 게시글 확인 완료했습니다.";
		String content = member.getMem_name() + "님이 신고하신 " + report.getReport_content() + "게시글을 삭제했습니다. 감사합니다.";
		
		if(post == null) {
			message = "해당 게시글이 없습니다.";
		}else {
			ServiceResult postResult = postService.modifyReportPost(post_num);
			if(ServiceResult.FAILED.equals(postResult)) {
				message = "서버 오류입니다. 다시 시도해주세요.";
			}else {
				message = "제재 완료. 작성한 회원에게 이메일 전송.";
				if(member.getMem_mail() != null) {
					SendMail.naverMailSend(member.getMem_mail(), title, content);
				}
				reportService.removeReport(report_num);
			}
		}
		success.put("message", message);
		
		return success;
	}
}
