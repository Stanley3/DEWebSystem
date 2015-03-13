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

import com.zh.rest.dao.ZH_VehicleDao;
import com.zh.rest.entities.ZH_Vehicle;

@Component
@Path("/vehicles")
public class ZH_VehicleService {
	@Autowired
	private ZH_VehicleDao vehicleDao;
	
	
	@POST
	@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	@Produces(MediaType.TEXT_HTML)
	public Response createUser(@FormParam("sn") String sn,
							   @FormParam("vin") String vin,
							   @FormParam("phone") String phone,
							   @FormParam("lock") int lock,
							   @FormParam("arrearage") double arrearage,
							   @FormParam("remark") String remark,
							   @FormParam("guest") String guest){		
		UUID uuid = UUID.randomUUID();
		String id = uuid.toString().replace("-", "");
		ZH_Vehicle vehicle = new ZH_Vehicle(id, sn, vin, phone, lock, arrearage, remark, guest);
		vehicleDao.createVehicle(vehicle);
		return Response.status(201).entity("新增成功").build();
	}
	
	@GET 
	@Produces({MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML})
	public Response getAllVehicles(){
		return Response.status(200).entity(vehicleDao.getVehicles()).build();
	}
	
	@GET
	@Path("{id}")
	@Produces({MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML})
	public Response getUser(@PathParam("id") String id){
		ZH_Vehicle vehicle = vehicleDao.getVehicleById(id);
		if(vehicle != null){
			return Response.status(200).entity(vehicle).build();
		}else{
			return Response.status(404).entity("请求的id" + id + "不存在！").build();
		}
	}
	
	@PUT 
	@Path("{id}")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.TEXT_HTML})	
	@Transactional
	public Response updateUserById(@PathParam("id") String id, ZH_Vehicle vehicle) {
		if(vehicle.getVehicle_id() == null) vehicle.setVehicle_id(id);		
		String message; 
		int status; 
		if(vehicleWasUpdated(vehicle)){
			status = 200; //OK
			message = "更新成功";
		} else if(vehicleCanBeCreated(vehicle)){
			vehicleDao.createVehicle(vehicle);
			status = 201; //Created 
			message = "新增成功";
		} else {
			status = 406; //Not acceptable
			message = "提供的信息不正取";
		}
		
		return Response.status(status).entity(message).build();		
	}
	
	private boolean vehicleWasUpdated(ZH_Vehicle vehicle){
		return vehicleDao.updateVehicle(vehicle) == 1;
	}
	
	private boolean vehicleCanBeCreated(ZH_Vehicle vehicle){
		return vehicle.getVehicle_id() != null && 
			   vehicle.getVehicle_sn() != null && 
			   vehicle.getVehicle_vin() != null &&
			   vehicle.getVehicle_phone() != null &&
			   vehicle.getVehicle_guest() != null;
	}
	
	@Path("{id}")
	@DELETE
	@Produces(MediaType.TEXT_HTML)
	public Response deleteUserById(@PathParam("id") String id){
		if(vehicleDao.deleteVehicleById(id) == 1){
			return Response.status(204).entity("删除成功").build();
		}else
			return Response.status(404).entity("请求的id" + id + "不存在").build();
	}
	
	public void setUserDao(ZH_VehicleDao vehicleDao) {
		this.vehicleDao = vehicleDao;
	}
}