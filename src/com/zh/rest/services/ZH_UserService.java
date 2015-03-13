package com.zh.rest.services;

import java.util.UUID;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.zh.rest.dao.ZH_UserDao;
import com.zh.rest.entities.ZH_User;

@Component
@Path("/users")
public class ZH_UserService {
	@Autowired
	private ZH_UserDao userDao;
	
	
	@POST
	@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	@Produces(MediaType.TEXT_HTML)
	public Response createUser(@FormParam("name") String name,
			@FormParam("password") String password, 
			@FormParam("role") String role){
		UUID uuid = UUID.randomUUID();
		String id = uuid.toString().replace("-", "");
		ZH_User user = new ZH_User(id, name, password, role);
		userDao.createUser(user);
		return Response.status(201).entity("新增成功").build();
	}
	
	@GET 
	@Produces({MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML})
	public Response getAllUsers(){
		return Response.status(200).entity(userDao.getUsers()).build();
	}
	
	@GET
	@Path("{id}")
	@Produces({MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML})
	public Response getUser(@PathParam("id") String id){
		ZH_User user = userDao.getUserById(id);
		if(user != null){
			return Response.status(200).entity(user).build();
		}else{
			return Response.status(404).entity("请求的id" + id + "不存在！").build();
		}
	}
	
	@PUT 
	@Path("{id}")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.TEXT_HTML})	
	@Transactional
	public Response updateUserById(@PathParam("id") String id, ZH_User user) {
		if(user.getUser_id() == null) user.setUser_id(id);
		String message; 
		int status; 
		if(userWasUpdated(user)){
			status = 200; //OK
			message = "更新成功";
		} else if(userCanBeCreated(user)){
			userDao.createUser(user);
			status = 201; //Created 
			message = "新增成功";
		} else {
			status = 406; //Not acceptable
			message = "提供的信息不争取";
		}
		
		return Response.status(status).entity(message).build();		
	}
	
	private boolean userWasUpdated(ZH_User user){
		return userDao.updateUser(user) == 1;
	}
	
	private boolean userCanBeCreated(ZH_User user){
		return user.getUser_id() != null && user.getUser_name() != null;
	}
	
	@Path("{id}")
	@DELETE
	@Produces(MediaType.TEXT_HTML)
	public Response deleteUserById(@PathParam("id") String id){
		if(userDao.deleteUserById(id) == 1){
			return Response.status(204).entity("删除成功").build();
		}else
			return Response.status(404).entity("请求的id" + id + "不存在").build();
	}
	
	public void setUserDao(ZH_UserDao userDao) {
		this.userDao = userDao;
	}
}