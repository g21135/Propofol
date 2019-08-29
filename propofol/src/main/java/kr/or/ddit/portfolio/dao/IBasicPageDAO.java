package kr.or.ddit.portfolio.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.BasicPageVO;

@Repository
public interface IBasicPageDAO {
	public List<BasicPageVO> selectList(int themeNum);
}
