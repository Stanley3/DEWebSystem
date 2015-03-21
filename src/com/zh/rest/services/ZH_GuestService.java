package com.zh.rest.services;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.DefaultValue;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.zh.rest.dao.ZH_GuestDao;
import com.zh.rest.entities.DetialGuestInfo;
import com.zh.rest.entities.ZH_Guest;

@Component
@Path("/guests")
public class ZH_GuestService {
	@Autowired
	private ZH_GuestDao guestDao;

	@Path("/{id}")
	@GET
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML,
			MediaType.TEXT_PLAIN })
	public Response findById(@PathParam("id") String id) {
		DetialGuestInfo guest = guestDao.getGuestById(id);
		if (guest != null) {
			return Response.status(200).entity(guest).build();
		} else {
			return Response.status(404).entity("请求的id" + id + "不存在！").build();
		}
	}

	@GET
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public Response getAllGuests(
			@DefaultValue("") @QueryParam("name") String name,
			@DefaultValue("") @QueryParam("cellphone") String cellphone,
			@DefaultValue("") @QueryParam("address") String address,
			@DefaultValue("0") @QueryParam("rows") String row,
			@DefaultValue("0") @QueryParam("page") String page) {
		ArrayList<DetialGuestInfo> guestList;
		int rows = Integer.valueOf(row);
		int pages = Integer.valueOf(page);
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("rows", rows);
		map.put("pages", pages);
		if (name.isEmpty() && cellphone.isEmpty() && address.isEmpty()) {
			if(pages != 0 && rows != 0){
				Map<String, Object> result = new HashMap<String, Object>();
				result.put("total", guestDao.getCounts());
				result.put("rows", guestDao.getGuests(map));
				return Response.status(200).entity(result).build();
			}else
				return Response.status(200).entity(guestDao.getGuests(map)).build();
		} else {
			guestList = (ArrayList<DetialGuestInfo>) guestDao.getQueriedGuests(
					name, cellphone, address);
			return Response.status(200).entity(guestList).build();
		}
	}

	@POST
	@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	@Produces(MediaType.TEXT_HTML)
	public Response createGuest(@FormParam("name") String name,
			@FormParam("cellphone") String cellphone,
			@FormParam("fixedline") String fixedline,
			@FormParam("area") String area) {
		UUID uuid = UUID.randomUUID();
		String id = uuid.toString().replace("-", "");
		ZH_Guest guest = new ZH_Guest(id, name, cellphone, fixedline, area);
		System.out.println(id + ", " + name + ", " + cellphone + ", "
				+ fixedline + ", " + area);
		guestDao.createGuest(guest);
		return Response.status(201).entity("新增成功").build();
	}

	@POST
	@Path("{id}")
	@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	@Produces(MediaType.TEXT_HTML)
	public Response updateGuest(@PathParam("id") String id,
			@FormParam("name") String name,
			@FormParam("cellphone") String cellphone,
			@FormParam("fixedline") String fixedline,
			@FormParam("area") String area) {
		ZH_Guest guest;
		if (area.isEmpty())
			guest = new ZH_Guest(id, name, cellphone, fixedline, null);
		else
			guest = new ZH_Guest(id, name, cellphone, fixedline, area);
		if (guestDao.updateGuest(guest) == 1)
			return Response.status(200).entity("true").build();
		else
			return Response.status(404).entity("false").build();
	}

	@Path("{id}")
	@DELETE
	@Produces(MediaType.TEXT_HTML)
	public Response deleteGuestById(@PathParam("id") String id) {
		if (guestDao.deleteGuestById(id) == 1) {
			return Response.status(204).entity("删除成功").build();
		} else
			return Response.status(404).entity("请求的id" + id + "不存在").build();
	}

	public void setGuestDao(ZH_GuestDao guestDao) {
		this.guestDao = guestDao;
	}
}