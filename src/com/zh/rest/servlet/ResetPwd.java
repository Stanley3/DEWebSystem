package com.zh.rest.servlet;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.Form;
import javax.ws.rs.core.MediaType;

import com.zh.rest.entities.Util;

public class ResetPwd extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException{
		String newPwd = request.getParameter("newPwd");
		String oldPwd = request.getParameter("oldPwd");
		HttpSession session = request.getSession();
		String pwd = (String) session.getAttribute("pwd");
		System.out.println("newPwd=" + newPwd + ", oldPwd=" + oldPwd + ", pwd=" + pwd);
		for (Enumeration<String> e = request.getParameterNames(); e.hasMoreElements();)
		       System.out.println(e.nextElement());
		if(pwd.equals(oldPwd)){
			String user_id = (String) session.getAttribute("user_id");
			Client client = ClientBuilder.newClient();
			WebTarget target = client.target(Util.BASEURL + "rest")
							.path("users").path(user_id);
			System.out.println(target.getUri().toURL().toString());
			Form form = new Form();
			form.param("pwd", newPwd);
			String result = target.request(MediaType.TEXT_PLAIN)
					.post(Entity.entity(form, MediaType.APPLICATION_FORM_URLENCODED_TYPE), String.class);
			if(result.equals("true")){
				response.sendRedirect("resetSuccess.jsp");
			}
			
		}else{
			Cookie cookie = new Cookie("result", "false");
			response.addCookie(cookie);
			//response.sendRedirect("resetPwd.jsp");
			response.setHeader("refresh", "0;URL=resetPwd.jsp");
		}
	}
	
}
