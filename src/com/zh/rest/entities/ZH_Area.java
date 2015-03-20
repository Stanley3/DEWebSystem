package com.zh.rest.entities;

import java.io.Serializable;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class ZH_Area  implements Serializable {
	public static final long serialVersionUID = -6076337053803968669L;
	
	private String area_address;
	private String area_id;
	
	public ZH_Area(){}

	public ZH_Area(String area_id, String area_address) {
		this.area_address = area_address;
		this.area_id = area_id;
	}

	public String getArea_address() {
		return area_address;
	}

	public void setArea_address(String area_address) {
		this.area_address = area_address;
	}

	public String getArea_id() {
		return area_id;
	}

	public void setArea_id(String area_id) {
		this.area_id = area_id;
	}
}