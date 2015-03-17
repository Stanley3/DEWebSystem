package com.zh.rest.services;

import java.util.UUID;

import javax.servlet.http.HttpSession;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.DefaultValue;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.sun.research.ws.wadl.Request;
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
		System.out.println("-------输入的用户名为：" + name + "密码：" + password + ", 角色：" + role + "--------");
		UUID uuid = UUID.randomUUID();
		String id = uuid.toString().replace("-", "");
		ZH_User user = new ZH_User(id, name, password, role);
		userDao.createUser(user);
		return Response.status(201).entity("true").build();
	}
	
	@POST
	@Path("/validate")
	@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	@Produces({MediaType.APPLICATION_JSON, MediaType.APPLICATION_SVG_XML})
	public Response validateUser(@FormParam("name") String name, 
								 @FormParam("password") String password){
		System.out.println("-------------就收到用户的输入参数为：" + name + ", " + password + "----------------");
		
		return Response.status(200).entity(userDao.validateUser(name, password)).build();
	}
	
	@POST
	@Path("{id}")
	@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	@Produces(MediaType.TEXT_PLAIN)
	public Response updateUserById(@PathParam("id") String id, 
								   @FormParam("name") String name,
								   @FormParam("role") String role){
		System.out.println("更新方法得到执行！");
		ZH_User user = new ZH_User(id, name, null, role);
		if(userDao.updateUser(user) == 1)
			return Response.status(200).entity("true").build();
		else
			return Response.status(404).entity("false").build();
		
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
	
	@GET 
	@Produces({MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML})
	public Response getAllUsers(@DefaultValue("") @QueryParam("name") String name,
								@DefaultValue("") @QueryParam("role") String role){
		System.out.println("查询方法得到执行！");
		if(name.isEmpty() && role.isEmpty())
			return Response.status(200).entity(userDao.getUsers()).build();
		else{
			System.out.println("用户名为：" + name + ", 角色为: " + role);
			return Response.status(200).entity(userDao.getQueriedUsers(name, role)).build();
		}
	}
	
	@Path("{id}")
	@DELETE
	@Produces(MediaType.TEXT_HTML)
	public Response deleteUserById(@PathParam("id") String id){
		if(userDao.deleteUserById(id) == 1){
			return Response.status(204).entity("true").build();
		}else
			return Response.status(404).entity("false").build();
	}
	
	public void setUserDao(ZH_UserDao userDao) {
		this.userDao = userDao;
	}
}