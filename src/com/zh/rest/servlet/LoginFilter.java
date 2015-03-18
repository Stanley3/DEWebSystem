package com.zh.rest.servlet;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.RequestToViewNameTranslator;

/**
 * Servlet Filter implementation class LoginFilter
 */
@WebFilter("/LoginFilter")
public class LoginFilter implements Filter {

    /**
     * Default constructor. 
     */
    public LoginFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here

		// pass the request along the filter chain
		if(request instanceof HttpServletRequest && 
				response instanceof HttpServletResponse){
			HttpServletRequest req = (HttpServletRequest)request;
			HttpSession session = req.getSession();
			String sAttr = (String) session.getAttribute("userid");
			System.out.println("获取时 : " + sAttr);
			String contextPath = ((HttpServletResponse) response).encodeRedirectURL(req.getContextPath());
			System.out.println("当前上下文：" + ((HttpServletResponse) response).encodeRedirectURL(req.getContextPath()));
			System.out.println("当前请求的URL: " +  req.getRequestURL().toString()); 
			if(sAttr != null){ 
				chain.doFilter(request, response);
			}
			else 
				request.getRequestDispatcher("/jump.jsp").forward(request, response);
				/*((HttpServletResponse) response).sendRedirect(((HttpServletResponse) response).encodeRedirectURL(req.getContextPath() +
				        "/index.jsp"));*/
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
