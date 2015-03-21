package com.zh.rest.services;

import java.util.HashMap;
import java.util.Map;
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
			@FormParam("vin") String vin, @FormParam("phone") String phone,
			@FormParam("lock") int lock,
			@FormParam("arrearage") double arrearage,
			@FormParam("remark") String remark,
			@FormParam("guest") String guest, @FormParam("status") int status) {
		System.out.println("接收到插入的数据！"
				+ "用户为：" + guest);
		UUID uuid = UUID.randomUUID();
		String id = uuid.toString().replace("-", "");
		ZH_Vehicle vehicle = new ZH_Vehicle(id, sn, vin, phone, lock,
				arrearage, remark, guest, null, status);
		vehicleDao.createVehicle(vehicle);
		return Response.status(201).entity("新增成功").build();
	}

	@GET
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public Response getAllVehicles(@DefaultValue("") @QueryParam("vin") String vin,
			@DefaultValue("") @QueryParam("sn") String sn,
			@DefaultValue("") @QueryParam("phone") String phone,
			@DefaultValue("") @QueryParam("area") String area,
			@DefaultValue("") @QueryParam("lock") String lock,
			@DefaultValue("0") @QueryParam("rows") String row,
			@DefaultValue("0") @QueryParam("page") String page) {
		int rows = Integer.valueOf(row);
		int pages = Integer.valueOf(page);
		Map<String, Integer> param = new HashMap<String, Integer>();
		param.put("rows", rows);
		param.put("pages", pages);
		if(vin.isEmpty() && sn.isEmpty() && phone.isEmpty() && area.isEmpty() && lock.isEmpty()){
			if(rows != 0 && pages != 0){
				int totals = vehicleDao.getCounts();
				Map<String, Object>result = new HashMap<String, Object>();
				result.put("total", totals);
				result.put("rows", vehicleDao.getVehicles(param));
				return Response.status(200).entity(result).build();
			}else
				return Response.status(200).entity(vehicleDao.getVehicles(param)).build();
		}
		else{
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("vin", vin);
			map.put("sn", sn);
			map.put("phone", phone);
			map.put("area", area.isEmpty() ? null : area);
			map.put("lock", lock.isEmpty() ? 0 : Integer.valueOf(lock));
			return Response.status(200).entity(vehicleDao.getQueriedVehicles(map)).build();
		}
	}

	@GET
	@Path("{id}")
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public Response getVehicle(@PathParam("id") String id) {
		ZH_Vehicle vehicle = vehicleDao.getVehicleById(id);
		if (vehicle != null) {
			return Response.status(200).entity(vehicle).build();
		} else {
			return Response.status(404).entity("请求的id" + id + "不存在！").build();
		}
	}

	@POST
	@Path("{id}")
	@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	@Produces({ MediaType.TEXT_HTML })
	@Transactional
	public Response updateUserById(@PathParam("id") String id,
			@FormParam("sn") String sn, @FormParam("vin") String vin,
			@FormParam("phone") String phone, @FormParam("guest") String guest,
			@FormParam("lock") String lock, @FormParam("remark") String remark,
			@FormParam("arrearage") String arrearage) {
		System.out.println("更新方法得到执行！客户的id为" + guest);
		ZH_Vehicle vehicle;
		if(guest.isEmpty()) //不知道FormParam把null变成了什么，此处必须这样做，guest不会当null处理。
		{
			vehicle = new ZH_Vehicle(id, sn, vin, phone, Integer.valueOf(lock), Double.valueOf(arrearage), remark, null, null, 0);
		}
		else
			vehicle = new ZH_Vehicle(id, sn, vin, phone, Integer.valueOf(lock), Double.valueOf(arrearage), remark, guest, null, 0);
		if(vehicleDao.updateVehicle(vehicle) == 1)
			return Response.status(200).entity("true").build();
		else
			return Response.status(404).entity(404).build();
	}


	@Path("{id}")
	@DELETE
	@Produces(MediaType.TEXT_HTML)
	public Response deleteUserById(@PathParam("id") String id) {
		System.out.println("删除方法得到执行，id为: " + id);
		if (vehicleDao.deleteVehicleById(id) == 1) {
			return Response.status(204).entity("删除成功").build();
		} else
			return Response.status(404).entity("请求的id" + id + "不存在").build();
	}

	public void setUserDao(ZH_VehicleDao vehicleDao) {
		this.vehicleDao = vehicleDao;
	}
}