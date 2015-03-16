package com.zh.rest.services;

import java.io.UnsupportedEncodingException;
import java.util.UUID;

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

import com.zh.rest.dao.ZH_AreaDao;
import com.zh.rest.entities.ZH_Area;



@Component
@Path("/areas")
public class ZH_AreaService {
	@Autowired
	private ZH_AreaDao areaDao;
	
	
	@POST
	@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	@Produces(MediaType.TEXT_PLAIN)
	public Response createArea(@FormParam("address") String address){
		UUID uuid = UUID.randomUUID();
		String id = uuid.toString().replace("-", "");
		ZH_Area area = new ZH_Area(id, address);
		System.out.println("接收到的地址为：" + address); 
		areaDao.createArea(area);
		return Response.status(201).entity("新增成功").build();
	}
	
	@GET 
	@Produces({MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML})
	public Response getAllUsers(@DefaultValue("") @QueryParam("address") String address){
		System.out.println("查询方法得到执行！");
		if(address.isEmpty())
			return Response.status(200).entity(areaDao.getArea()).build();
		else{
			System.out.println("地址为：" + address);
			return Response.status(200).entity(areaDao.getQueriedArea(address)).build();
		}
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
	
	/*@PUT 
	@Path("{id}")
	@Consumes({MediaType.APPLICATION_FORM_URLENCODED})
	@Produces({MediaType.TEXT_HTML})	
	@Transactional
	public Response updateUserById(@PathParam("id") String id, ZH_Area area) {
		if(area.getArea_id() == null) area.setArea_id(id);
		System.out.println("更新操作得到执行");
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
	}*/
	
	@Path("{id}")
	@POST
	@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	@Produces(MediaType.TEXT_HTML)
	public Response updateArea(@PathParam("id") String id, @FormParam("address") String address){
		System.out.println("更新方法得到执行！");
		System.out.println("id: " + id + ", address:" + address);
		ZH_Area area = new ZH_Area(id, address);
		if(areaDao.updateArea(area) == 1)
				return Response.status(200).entity("更新成功").build();
		else
			return Response.status(404).entity("更新失败").build();
	}
	
	@Path("{id}")
	@DELETE
	@Produces(MediaType.TEXT_HTML)
	@Transactional
	public Response deleteUserById(@PathParam("id") String id){
		System.out.println("删除方法得到执行！");
		int count = areaDao.deleteAreaById(id);
		if(count == 1){
			return Response.status(200).entity("true").build();
		}else
			return Response.status(404).entity("false").build();
	}
	
	public void setAreaDao(ZH_AreaDao areaDao) {
		this.areaDao = areaDao;
	}
}