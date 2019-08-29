package kr.or.ddit.post.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import kr.or.ddit.post.dao.IPostDAO;
import kr.or.ddit.vo.TypeVO;

@ControllerAdvice
public class PostControllerAdvice {
	@Inject 
	IPostDAO dao;
	
	@ModelAttribute("typeList")
	public List<TypeVO> typeList() {
		return	dao.typeList();
	}
}
