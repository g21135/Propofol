package kr.or.ddit.portfolio.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.ThemeVO;

@Repository
public interface IThemeDAO {
	public List<ThemeVO> selectList();
}
