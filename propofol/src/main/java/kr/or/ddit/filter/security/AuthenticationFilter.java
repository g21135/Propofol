package kr.or.ddit.filter.security;

import java.io.IOException;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.ResourceBundle;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class AuthenticationFilter implements Filter{
	private static Logger logger = LoggerFactory.getLogger(AuthenticationFilter.class);

	private Map<String, String[]> securedResources; 
	private String secureInfo;
	public static final String SECUREDNAME = "securedResources";
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		logger.info("{}필터 등록 및 초기화", getClass().getSimpleName());	
		
		secureInfo = filterConfig.getInitParameter("secureInfo");
		
		securedResources = new LinkedHashMap<String, String[]>();
		
		ResourceBundle bundle = ResourceBundle.getBundle(secureInfo);
		Iterator<String> keys = bundle.keySet().iterator();
		while (keys.hasNext()) {
			String uri = (String) keys.next();
			String roles = bundle.getString(uri);
			String[] realRoles = roles.split(",");
			securedResources.put(uri,realRoles);
		} 
		
		filterConfig.getServletContext().setAttribute(SECUREDNAME, securedResources);
	}
	

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		
		String uri = req.getRequestURI();
		uri = uri.substring(req.getContextPath().length()).split(";")[0];//콘텍스트 패스와 세션파라미터제거 

		boolean flag = true;
		if(securedResources.containsKey(uri)) {//보호가 필요한 자료
			Object authMember = req.getSession().getAttribute("authMember");
			if(authMember==null) {//로그인이 안되어있다.
				flag = false;
			}
		}
		if(flag) {
			chain.doFilter(request, response);
		}else {//정상적인 유저가 아닐수 도 있음 -> 인증이 필요한 모든 과정에서 이동은 리다이렉션
			req.getSession().setAttribute("msg", "권한이 없습니다!");
			resp.sendRedirect(req.getContextPath()+"/");
		}
	}

	@Override
	public void destroy() {
		logger.info("{}필터 소멸", getClass().getSimpleName());	
	}

}
