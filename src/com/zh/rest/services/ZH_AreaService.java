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
		System.out.println("���յ��ĵ�ַΪ��" + address); 
		areaDao.createArea(area);
		return Response.status(201).entity("�����ɹ�").build();
	}
	
	@GET 
	@Produces({MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML})
	public Response getAllUsers(@DefaultValue("") @QueryParam("address") String address){
		System.out.println("��ѯ�����õ�ִ�У�");
		if(address.isEmpty())
			return Response.status(200).entity(areaDao.getArea()).build();
		else{
			System.out.println("��ַΪ��" + address);
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
			return Response.status(404).entity("�����id" + id + "�����ڣ�").build();
		}
	}
	
	/*@PUT 
	@Path("{id}")
	@Consumes({MediaType.APPLICATION_FORM_URLENCODED})
	@Produces({MediaType.TEXT_HTML})	
	@Transactional
	public Response updateUserById(@PathParam("id") String id, ZH_Area area) {
		if(area.getArea_id() == null) area.setArea_id(id);
		System.out.println("���²����õ�ִ��");
		String message; 
		int status; 
		if(areaWasUpdated(area)){
			status = 200; //OK
			message = "���³ɹ�";
		} else if(areaCanBeCreated(area)){
			areaDao.createArea(area);
			status = 201; //Created 
			message = "�����ɹ�";
		} else {
			status = 406; //Not acceptable
			message = "�ṩ����Ϣ����ȡ";
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
		System.out.println("���·����õ�ִ�У�");
		System.out.println("id: " + id + ", address:" + address);
		ZH_Area area = new ZH_Area(id, address);
		if(areaDao.updateArea(area) == 1)
				return Response.status(200).entity("���³ɹ�").build();
		else
			return Response.status(404).entity("����ʧ��").build();
	}
	
	@Path("{id}")
	@DELETE
	@Produces(MediaType.TEXT_HTML)
	@Transactional
	public Response deleteUserById(@PathParam("id") String id){
		System.out.println("ɾ�������õ�ִ�У�");
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