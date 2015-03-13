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

import com.zh.rest.dao.ZH_AreaDao;
import com.zh.rest.entities.ZH_Area;



@Component
@Path("/areas")
public class ZH_AreaService {
	@Autowired
	private ZH_AreaDao areaDao;
	
	
	@POST
	@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	@Produces(MediaType.TEXT_HTML)
	public Response createUser(@FormParam("address") String address){
		UUID uuid = UUID.randomUUID();
		String id = uuid.toString().replace("-", "");
		ZH_Area area = new ZH_Area(id, address);
		areaDao.createArea(area);
		return Response.status(201).entity("新增成功").build();
	}
	
	@GET 
	@Produces({MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML})
	public Response getAllUsers(){
		return Response.status(200).entity(areaDao.getArea()).build();
	}
	
	@GET
	@Path("{id}")
	@Produces({MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML})
	public Response getUser(@PathParam("id") String id){
		ZH_Area area = areaDao.getAreaById(id);
		if(area != null){
			return Response.status(200).entity(area).build();
		}else{
			return Response.status(404).entity("请求的id" + id + "不存在！").build();
		}
	}
	
	@PUT 
	@Path("{id}")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.TEXT_HTML})	
	@Transactional
	public Response updateUserById(@PathParam("id") String id, ZH_Area area) {
		if(area.getArea_id() == null) area.setArea_id(id);
		String message; 
		int status; 
		if(areaWasUpdated(area)){
			status = 200; //OK
			message = "更新成功";
		} else if(areaCanBeCreated(area)){
			areaDao.createArea(area);
			status = 201; //Created 
			message = "新增成功";
		} else {
			status = 406; //Not acceptable
			message = "提供的信息不正取";
		}
		
		return Response.status(status).entity(message).build();		
	}
	
	private boolean areaWasUpdated(ZH_Area Area){
		return areaDao.updateArea(Area) == 1;
	}
	
	private boolean areaCanBeCreated(ZH_Area area){
		return area.getArea_id() != null && area.getArea_address() != null;
	}
	
	@Path("{id}")
	@DELETE
	@Produces(MediaType.TEXT_HTML)
	public Response deleteUserById(@PathParam("id") String id){
		if(areaDao.deleteAreaById(id) == 1){
			return Response.status(204).entity("删除成功").build();
		}else
			return Response.status(404).entity("请求的id" + id + "不存在").build();
	}
	
	public void setUserDao(ZH_AreaDao areaDao) {
		this.areaDao = areaDao;
	}
}