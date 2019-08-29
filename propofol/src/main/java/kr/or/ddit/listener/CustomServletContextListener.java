package kr.or.ddit.listener;

import java.util.HashSet;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.or.ddit.vo.MemberVO;

@WebListener
public class CustomServletContextListener implements ServletContextListener {
	Logger logger = LoggerFactory.getLogger(CustomServletContextListener.class);
	
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		ServletContext application = sce.getServletContext();
		application.setAttribute("cPath", application.getContextPath());
		
//		세션을 누적할 수 있는 속성 생성 및 공유 
		application.setAttribute("userCount", new Integer(0));	
		application.setAttribute("userList", new HashSet<MemberVO>());	
		logger.info("서버 구동  {} 컨텍스트 시작" , application.getContextPath());
		
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		ServletContext application = sce.getServletContext();
		logger.info("{} 컨텍스트  종료" , application.getContextPath());
	}

}
