package kr.or.ddit.post.controller;

import java.io.IOException;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.common.InsertGroup;
import kr.or.ddit.common.UpdateGroup;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.post.service.IPostService;
import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.PostVO;

@Controller
@RequestMapping(value="/noticeBoards")
public class NoticeBoardController {
	@Inject
	IPostService service;
	      
	@GetMapping(produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<PostVO> ajaxList(@RequestParam(name="page", required=false, defaultValue="1") int currentPage, String searchType, String searchWord, Model model) {
		list(currentPage, searchType, searchWord, model);
		return (PagingVO<PostVO>) model.asMap().get("pagingVO");
	}
	
	@GetMapping
	public String list(@RequestParam(name="page", required=false, defaultValue="1") int currentPage, String searchType, String searchWord, Model model) {
		PagingVO<PostVO> pagingVO = new PagingVO<PostVO>(10,5);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSearchType(searchType);
		pagingVO.setSearchWord(searchWord);
		pagingVO.setSearchVO(new PostVO(1));
		pagingVO.setTotalRecord(service.retrievePostCount(pagingVO));
	      
		List<PostVO> postList = service.retrievePostList(pagingVO);
		pagingVO.setDataList(postList);
		model.addAttribute("pagingVO", pagingVO);
		return "noticeBoards/noticeBoardList";
	}
	   
	@GetMapping("insert")
	public String doInsert(){
		return "noticeBoards/noticeBoardForm";
	}

	@PostMapping("insert")
	public String insert(@Validated(InsertGroup.class) PostVO post, Errors errors, Model model) {
		boolean valid = !errors.hasErrors();
		String goPage = null;
		String message = null;
		if (valid) {
			ServiceResult result = service.createPost(post);
			if(ServiceResult.OK.equals(result)) {
				goPage = "redirect:/noticeBoards/"+ post.getPost_num();
			}else {
				message = "서버 오류입니다, 다시 시도해주세요.";
				goPage = "noticeBoards/noticeBoardForm";
			}
		} else {
			goPage = "noticeBoards/noticeBoardForm";
		}
		model.addAttribute("message", message);
		return goPage;
	}
	
	@GetMapping(value="update/{post_num}")
	public String doUpdate(@PathVariable int post_num, Model model){
		PostVO post = service.retrievePost(post_num);
		model.addAttribute("post", post);
		return "noticeBoards/noticeBoardForm";
	}
	
	@PostMapping("update/{post_num}")
	public String update(@Validated(UpdateGroup.class) PostVO post, Errors errors, Model model) {
		boolean valid = !errors.hasErrors();
		String goPage = null;
		String message = null;
		if (valid) {
			ServiceResult result = service.modifyPost(post);
			if(ServiceResult.OK.equals(result)) {
				goPage = "redirect:/noticeBoards/"+ post.getPost_num();
			}else {
				message = "서버 오류입니다, 다시 시도해주세요.";
				goPage = "noticeBoards/noticeBoardForm";
			}
		} else {
			goPage = "noticeBoards/noticeBoardForm";
		}
		model.addAttribute("message", message);
		return goPage;
	}
	
	@GetMapping("{post_num}")
	public String view(@PathVariable(required=true) int post_num, Model model){
		PostVO postVO = service.retrievePost(post_num);
		model.addAttribute("postVO", postVO);
		return "noticeBoards/noticeBoardView";   
	}
	
	@DeleteMapping("delete")
	public String delete(@RequestParam(required=true) int post_num, Model model) {
		PostVO post = new PostVO();
		post.setPost_num(post_num);
		String goPage = null;
		String message = null;
		ServiceResult result = service.removePost(post);
			if(ServiceResult.OK.equals(result)) {
				goPage = "redirect:/noticeBoards";
			}else {
				message = "서버 오류입니다, 다시 시도해주세요.";
				goPage = "noticeBoards/" + post_num;
			}
		model.addAttribute("message", message);
		
		return goPage;
	}
	
	@RequestMapping("download")
	public String process(@RequestParam(name="attach", required=true) String att_noStr, HttpServletResponse resp, Model model) throws IOException {
		AttachVO attach = service.download(Integer.parseInt(att_noStr));
		model.addAttribute("attach", attach);
		return "downloadView";
	}
}