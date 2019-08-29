package kr.or.ddit.filter.security;

import java.io.IOException;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.or.ddit.vo.MemberVO;

public class AuthorizationFilter implements Filter {
	private static Logger logger = LoggerFactory.getLogger(AuthorizationFilter.class);

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		logger.info("{}필터 등록 및 초기화", getClass().getSimpleName());
		// 여기서 꺼내는건 위험 동기화가 안되어있음 앞에서의 init이 늦게끝나고 이게 먼저끝날수도
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		Map<String, String[]> securedResources = (Map<String, String[]>) req.getServletContext().getAttribute(AuthenticationFilter.SECUREDNAME);
		
		String uri = req.getRequestURI();
		uri = uri.substring(req.getContextPath().length()).split(";")[0];//콘텍스트 패스와 세션파라미터제거 
		String[] roles = securedResources.get(uri);
		
		boolean pass = true;
		if(roles != null) {//보호되고 있는 자원
			//인증필터를 거치고 왔다 -> 로그인을 확인하고 옴 
			
			MemberVO authMember = (MemberVO) req.getSession().getAttribute("authMember");
			String userRole = authMember.getMem_role();
			boolean contains = containsRole(roles, userRole); //인가여부
		
			if(!contains) {
				pass = false;
			}
		}
		if(pass) {
			chain.doFilter(request, response);
		}else {
			req.getSession().setAttribute("msg", "권한이 없습니다!");
			resp.sendRedirect(req.getContextPath()+"/");
		}		
	}
	private boolean containsRole(String[] roles, String userRole) {
		boolean contains = false;
		for(String tmp : roles) {
			if(userRole.equals(tmp)) {
				contains = true;
				break;
			}
		}
		return contains;
	}
	@Override
	public void destroy() {
		logger.info("{}필터 소멸", getClass().getSimpleName());
	}

}
