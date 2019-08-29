package kr.or.ddit.filter;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 
 * 사용자에 대한 블랙리스트를 작성하고
 * 해당 블랙리스트에 포함된 유저를 블라인드 처리
 * @author pc10
 *
 */
public class BlindFilter implements Filter{
	private static Logger logger = LoggerFactory.getLogger(BlindFilter.class);
	Map<String, String> blackList;
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		logger.info("{} Blind필터 등록 초기화 ", getClass().getSimpleName());
		blackList = new LinkedHashMap<String, String>();
		
		blackList.put("127.0.0.1","그냥 나 블랙리스트에 추가");
		blackList.put("0:0:0:0:0:0:0:1", "그냥 나 블랙리스트에 추가");
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletResponse resp = (HttpServletResponse) response;
		HttpServletRequest req= (HttpServletRequest) request;
		
		String ip = request.getRemoteAddr();
		String message = blackList.get(ip);
		
		String uri = req.getRequestURI();
		
		boolean path = StringUtils.containsIgnoreCase(uri, "/common/blind.jsp"); //무한반복 방지
		
		if(message == null || path) {
			chain.doFilter(request, response);
		}else {
			req.getSession().setAttribute("message", message);
			resp.sendRedirect(req.getContextPath() + "/common/blind.jsp");
		}
	}

	@Override
	public void destroy() {
		logger.info("{} Blind필터 소멸 ", getClass().getSimpleName());
		
	}

}
