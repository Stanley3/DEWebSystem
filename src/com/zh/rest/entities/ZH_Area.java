package com.zh.rest.entities;

import java.io.Serializable;

public class ZH_Area implements Serializable{
	public static final long serialVersionUID = -6076337053803968669L;
	
	private String area_address;
	
	public ZH_Area(){}

	public ZH_Area(String area_address) {
		this.area_address = area_address;
	}
	
	public String getArea_address() {
		return area_address;
	}

	public void setArea_address(String area_address) {
		this.area_address = area_address;
	}
}