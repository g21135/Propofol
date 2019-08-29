package kr.or.ddit.common.intecerptor;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import kr.or.ddit.exception.UserNotFoundException;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.vo.MemberVO;

public class LoginInterceptor extends HandlerInterceptorAdapter{
	@Inject
	IMemberService serivce;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//sessoin 가져옴
		HttpSession session = request.getSession();
		Object obj = session.getAttribute("authMember");
		
		if(obj == null) {//로그인 된 세션이 없다.
			Cookie cookie = WebUtils.getCookie(request, "loginCookie");
			if(cookie != null) {//이전에 로그인 시 생성된 쿠키가 존재
				//쿠키가 있으니 쿠키에서 값을 꺼내온다.(이전에 박아 놓은 세션아이디)
				String sessionId = cookie.getValue();
				try {
					MemberVO mv = serivce.retrieveSessionMember(sessionId);
					if(mv != null) {//사용자가 있다!!
						session.setAttribute("authMember", mv);
						return true;
					}
				} catch (UserNotFoundException | NullPointerException e) {
					return true;
				}
			}else {//이전에 생성된 쿠키가 존재하지 않는다.
//				response.sendRedirect(request.getContextPath() + "/");
//				response.getWriter().print("{\"page\":\""+request.getContextPath()+"/test\"}");
				return true;
			}
		}
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
	}
	
}
