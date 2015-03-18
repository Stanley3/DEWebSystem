package com.zh.rest.servlet;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.Form;

public class ResetPwd extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public void doPost(HttpServletRequest request, HttpServletResponse response){
		String newPwd = request.getParameter("newPwd");
		Client client = ClientBuilder.newClient();
		WebTarget target = client.target("http://localhost:8080/ZHWS/rest").path("resetPwd");
		Form form = new Form();
	}
	
}
