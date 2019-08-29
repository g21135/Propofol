package kr.or.ddit.filter;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;

public class CkFilter implements javax.servlet.Filter{
	
	 @Override
     public void init(FilterConfig filterConfig) {
     }

     @Override
     public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
         HttpServletResponse res = (HttpServletResponse) response;
         res.setHeader("X-Content-Type-Options", "nosniff");
         chain.doFilter(request, response);
     }

     @Override
     public void destroy() {
     }
}
