package kr.or.ddit.report.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.alarm.service.IAlarmService;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.report.service.IReportService;
import kr.or.ddit.vo.NoticeVO;
import kr.or.ddit.vo.ReportVO;

@Controller
@RequestMapping(value="/report")
public class ReportController {
	@Inject
	IReportService service;
	@Inject
	IAlarmService alarmService;
	
	@PostMapping("{mem_id_to}")
	public String doInsert(@PathVariable String mem_id_to, @RequestParam int post_num, Model model){
		model.addAttribute("mem_id_to", mem_id_to);
		model.addAttribute("post_num", post_num);
		return "report/reportForm";
	}

	@PostMapping
	public String insert(ReportVO report, Errors errors, HttpSession session) {
		boolean valid = !errors.hasErrors();
		String goPage = null;
		String message = null;
		if (valid) {
			ServiceResult result = service.createReport(report);
			String userId = report.getMem_id_to();
			String content = report.getMem_id_from()  + "님이 회원님의 게시글을 신고했습니다.";
			String url = "freeBoards/" + report.getPost_num();
			NoticeVO nv = new NoticeVO(userId, content, url);
			if(ServiceResult.OK.equals(result)) {
				message = "신고가 완료되었습니다.";
				alarmService.createAlarm(nv);
				goPage = "redirect:/freeBoards";
			}else {
				message = "서버 오류입니다, 다시 시도해주세요.";
				goPage = "report/reportForm";
			}
		} else {
			goPage = "report/reportForm";
		}
		session.setAttribute("message", message);
		return goPage;
	}
}
