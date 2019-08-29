package kr.or.ddit.portLike.controller;

import java.util.LinkedHashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.alarm.service.IAlarmService;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.portLike.service.IPortLikeService;
import kr.or.ddit.portfolio.service.IPortfolioService;
import kr.or.ddit.vo.NoticeVO;
import kr.or.ddit.vo.PortLikeVO;
import kr.or.ddit.vo.PortfolioVO;

@Controller
@RequestMapping(value = "/like", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
public class PortLikeController {
	@Inject
	IPortLikeService likeService;
	@Inject
	IPortfolioService service;
	@Inject
	IAlarmService alarmService;
	
	@PostMapping
	public Map<String, Object> like(@RequestParam PortLikeVO portLike){
		Map<String, Object> resultMap = new LinkedHashMap<String, Object>();
		ServiceResult result = likeService.createLike(portLike);
		if(ServiceResult.OK.equals(result)) {
			resultMap.put("success", true);
			resultMap.put("message", "좋아요 성공!");
			PortfolioVO pvo = service.retrievePort(portLike.getPort_num());
			String content = portLike.getMem_id() + " 님이" + pvo.getPort_name() + " 에 좋아요를 눌렀습니다.";
			String url = "myPortfolio" ;
			NoticeVO noticeVO  = new NoticeVO(pvo.getMem_id(), content, url);
			alarmService.createAlarm(noticeVO);
		}else {
			resultMap.put("success", false);
			resultMap.put("message", "좋아요 실패했습니다.");
		}
		return resultMap;
	}
}
