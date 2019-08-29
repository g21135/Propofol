package kr.or.ddit.reply.controller;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.alarm.service.IAlarmService;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.portfolio.service.IPortfolioService;
import kr.or.ddit.post.service.IPostService;
import kr.or.ddit.reply.service.IReplyService;
import kr.or.ddit.vo.NoticeVO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.PostVO;
import kr.or.ddit.vo.ReplyVO;

@Controller
@RequestMapping("/reply")
public class ReplyController{
	@Inject
	IReplyService service;
	@Inject
	IPostService postService;
	@Inject
	IAlarmService alarmService;
	
	
	@RequestMapping(value="replyList", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<ReplyVO> list(@RequestParam(name="page", required=false, defaultValue="1") int currentPage, @RequestParam(required=true) int post_num, Model model){
		PagingVO<ReplyVO> pagingVO = new PagingVO<>(5, 5);
		pagingVO.setSearchVO(new ReplyVO(post_num));
		pagingVO.setCurrentPage(currentPage);
		long totalRecord = service.retrieveReplyCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<ReplyVO> replyList = service.retrieveReplyList(pagingVO);
		pagingVO.setDataList(replyList);
		return pagingVO;
	}
	
	@RequestMapping("insert")
	public Map<String, Object> insert(ReplyVO reply){
		Map<String, Object> resultMap = new LinkedHashMap<String, Object>();
		ServiceResult result = service.createReply(reply);
		String userId = null;
		String url = null;
		String content = null;
		if(ServiceResult.OK.equals(result)) {
			resultMap.put("success", true);
			//댓글작성시에 자동으로 Insert
			PostVO pv = postService.retrievePost(reply.getPost_num());
			userId = pv.getMem_id();
			url = "freeBoards/" + reply.getPost_num(); 
			content = reply.getMem_id() + "님이 댓글을 남겼습니다.";
			NoticeVO nv = new NoticeVO(userId, content, url);
			alarmService.createAlarm(nv);
		}else {
			resultMap.put("success", false);
			resultMap.put("message", true);
		}
		return resultMap;
	}
	
	@RequestMapping(value="update")
	public Map<String, Object> update(ReplyVO reply){
		Map<String, Object> resultMap = new LinkedHashMap<String, Object>();
		ServiceResult result = service.modifyReply(reply);
		if(ServiceResult.OK.equals(result)) {
			resultMap.put("success", true);
		}else {
			resultMap.put("success", false);
			resultMap.put("message", true);
		}
		return resultMap;
	}
	
	@RequestMapping(value="delete")
	public Map<String, Object> delete(ReplyVO reply){
		Map<String, Object> resultMap = new LinkedHashMap<String, Object>();
		ServiceResult result = service.removeReply(reply);
		switch (result) {
		case FAILED:
			resultMap.put("success", false);
			resultMap.put("message", "비밀번호 오류입니다.");
		default : 
			resultMap.put("success", true);
		}
		return resultMap;
	}
}