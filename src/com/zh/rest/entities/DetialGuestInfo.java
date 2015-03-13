package com.zh.rest.entities;

import java.io.Serializable;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class DetialGuestInfo implements Serializable {
	public static final long serialVersionUID = -6538060763396866937L;
	
	private String guest_id;
	private String guest_name;
	private String guest_cellphone;
	private String guest_fixedline;
	private String area_address; //此处为客户的地址而不是客户地址的id
	
	public DetialGuestInfo(){}

	public DetialGuestInfo(String guest_id, String guest_name, String guest_cellphone,
			String guest_fixedline, String area_address) {
		this.guest_id = guest_id;
		this.guest_name = guest_name;
		this.guest_cellphone = guest_cellphone;
		this.guest_fixedline = guest_fixedline;
		this.area_address = area_address;
	}

	public String getGuest_id() {
		return guest_id;
	}

	public void setGuest_id(String guest_id) {
		this.guest_id = guest_id;
	}

	public String getGuest_name() {
		return guest_name;
	}

	public void setGuest_name(String guest_name) {
		this.guest_name = guest_name;
	}

	public String getGuest_cellphone() {
		return guest_cellphone;
	}

	public void setGuest_cellphone(String guest_cellphone) {
		this.guest_cellphone = guest_cellphone;
	}

	public String getGuest_fixedline() {
		return guest_fixedline;
	}

	public void setGuest_fixedline(String guest_fixedline) {
		this.guest_fixedline = guest_fixedline;
	}

	public String getArea_address() {
		return area_address;
	}

	public void setArea_address(String area_address) {
		this.area_address = area_address;
	}
	
}