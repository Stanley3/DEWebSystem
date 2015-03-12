package com.zh.rest.services;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.zh.rest.dao.ZH_GuestDao;
import com.zh.rest.entities.ZH_Guest;

@Component
@Path("/guests")
public class ZH_GuestService {
	@Autowired
	private ZH_GuestDao guestDao;
	
	@Path("/{id}")
	@GET
	@Produces({MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML})
	public Response findById(@PathParam("id") String id){
		ZH_Guest guest = guestDao.getGuestById(id);
		if(guest != null){
			return Response.status(200).entity(guest).build();
		}else{
			return Response.status(404).entity("请求的id" + id + "不存在！").build();
		}
	}
}