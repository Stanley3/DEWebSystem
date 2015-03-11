package com.zh.rest.entities;

import java.io.Serializable;

public class ZH_Guest implements Serializable {
	public static final long serialVersionUID = -6538060763396866937L;
	
	private String guest_id;
	private String guest_name;
	private String guest_cellphone;
	private String guest_fixedline;
	private String guest_area;
	
	public ZH_Guest(){}

	public ZH_Guest(String guest_id, String guest_name, String guest_cellphone,
			String guest_fixedline, String guest_area) {
		this.guest_id = guest_id;
		this.guest_name = guest_name;
		this.guest_cellphone = guest_cellphone;
		this.guest_fixedline = guest_fixedline;
		this.guest_area = guest_area;
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

	public String getGuest_area() {
		return guest_area;
	}

	public void setGuest_area(String guest_area) {
		this.guest_area = guest_area;
	}
	
}