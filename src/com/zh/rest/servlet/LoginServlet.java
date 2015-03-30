package com.zh.rest.servlet;
import java.io.IOException;

import javax.servlet.ServletException;
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
import com.zh.rest.entities.ZH_User;

public class LoginServlet extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException{
		
		String name = req.getParameter("name");
		String password = req.getParameter("password");
		HttpSession session = req.getSession();
		
		
		ZH_User user = null;
		Client client = ClientBuilder.newClient();
		WebTarget target = client.target(Util.BASEURL + "rest").path("users").path("validate");
		Form form = new Form();
		form.param("name", name);
		form.param("password", password);
		user = target.request(MediaType.APPLICATION_JSON_TYPE).post(Entity.entity(form, MediaType.APPLICATION_FORM_URLENCODED_TYPE), ZH_User.class);
		if(user != null && user.getUser_id() != null){
			session.setAttribute("user_id", user.getUser_id());
			session.setAttribute("pwd", user.getUser_password());
			session.setAttribute("name", user.getUser_name());
			session.setAttribute("role", user.getUser_role());
			resp.setHeader("refresh", "0;URL=pages/vehicle.jsp");
		}
	}
}