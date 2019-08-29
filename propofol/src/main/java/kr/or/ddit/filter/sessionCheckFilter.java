package kr.or.ddit.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.or.ddit.filter.security.AuthorizationFilter;

public class sessionCheckFilter implements Filter{

	private static Logger logger = LoggerFactory.getLogger(AuthorizationFilter.class);

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		logger.info("{}필터 등록 및 초기화", getClass().getSimpleName());
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		
		HttpSession session = req.getSession();
		if(session.getAttribute("authMember") == null) { 
			session.setAttribute("msg", "세션이 만료되었습니다.");
			resp.sendRedirect(req.getContextPath() + "/");
		}else {
			chain.doFilter(request, response);
		}
	}
	@Override
	public void destroy() {
		logger.info("{}필터 소멸", getClass().getSimpleName());
	}


}
