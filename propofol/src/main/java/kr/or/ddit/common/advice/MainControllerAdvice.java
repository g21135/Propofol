package kr.or.ddit.common.advice;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.tiles.AttributeContext;
import org.apache.tiles.preparer.ViewPreparer;
import org.apache.tiles.request.Request;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import kr.or.ddit.portfolio.dao.IThemeDAO;
import kr.or.ddit.vo.ThemeVO;

@ControllerAdvice
public class MainControllerAdvice {

	@Inject
	IThemeDAO themeDao;
	
	@ModelAttribute("themeList")
	public List<ThemeVO> themeList() {
		return themeDao.selectList();
	}
}
