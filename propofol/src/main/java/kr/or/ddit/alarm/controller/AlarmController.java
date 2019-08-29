package kr.or.ddit.alarm.controller;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.alarm.dao.IAlarmDAO;
import kr.or.ddit.alarm.service.IAlarmService;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.NoticeVO;
import kr.or.ddit.vo.PagingVO;

@Controller
@RequestMapping(value = "/alarm", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
public class AlarmController {

	@Inject
	IAlarmService service;
	@Inject
	IAlarmDAO dao;
	
	@GetMapping
	@ResponseBody
	public Map<String, Object> alarmList(@RequestParam(name="mem_id", required=true) String mem_id,
			@RequestParam(name="page", required=false, defaultValue="1") int currentValue){
		Map<String, Object> result = new LinkedHashMap<>();
		PagingVO<NoticeVO> pagingVO = new PagingVO<>(5, 3);
		pagingVO.setCurrentPage(currentValue);
		pagingVO.setMem_id(mem_id);
		
		long totalRecord = dao.allCount(mem_id);
		pagingVO.setTotalRecord(totalRecord);
		
		int count = dao.countRead(mem_id); 

		List<NoticeVO> list = service.retreieveAlarm(pagingVO);
		pagingVO.setDataList(list);
		result.put("alarmList", pagingVO);
		result.put("readCount", count);
		return result;
	}
	
	@PostMapping(value="modify")
	public String modifyAlarm(@RequestParam int notice_num,
			@RequestParam String notice_url,
			HttpServletRequest req){
		String goPage = null;
		ServiceResult modify = service.modyfyNoticeRead(notice_num);
		if(ServiceResult.OK.equals(modify)) {
			System.out.println(req.getContextPath());
			goPage = "redirect:/" + req.getContextPath()+notice_url;
		}else {
			goPage = "redirect:/";
		}
		return goPage;
	}
	
	@PostMapping(value="remove")
	@ResponseBody
	public Map<String, Boolean> removeAlarm(@RequestParam int notice_num){
		Map<String, Boolean> result = new LinkedHashMap<>();
		ServiceResult delete = service.removeAlarm(notice_num);
		if(ServiceResult.OK.equals(delete)) {
			result.put("success", true);
		}else {
			result.put("success", false);
		}
		return result;
	}
}
