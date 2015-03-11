package com.zh.rest.entities;

import java.io.Serializable;

public class ZH_Vehicle implements Serializable{
	public static final long serialVersionUID = -6076339665380866937L;
	
	private String vehicle_id;
	private String vehicle_sn;
	private String vehicle_vin;
	private String vehicle_phone;
	private int vehicle_lock;
	private double vehicle_arrearage;
	private String vehicle_remark;
	private String vehicle_guest;
	
	public ZH_Vehicle(){}

	public ZH_Vehicle(String vehicle_id, String vehicle_sn, String vehicle_vin,
			String vehicle_phone, int vehicle_lock, double vehicle_arrearage,
			String vehicle_remark, String vehicle_guest) {
		this.vehicle_id = vehicle_id;
		this.vehicle_sn = vehicle_sn;
		this.vehicle_vin = vehicle_vin;
		this.vehicle_phone = vehicle_phone;
		this.vehicle_lock = vehicle_lock;
		this.vehicle_arrearage = vehicle_arrearage;
		this.vehicle_remark = vehicle_remark;
		this.vehicle_guest = vehicle_guest;
	}

	public String getVehicle_id() {
		return vehicle_id;
	}

	public void setVehicle_id(String vehicle_id) {
		this.vehicle_id = vehicle_id;
	}

	public String getVehicle_sn() {
		return vehicle_sn;
	}

	public void setVehicle_sn(String vehicle_sn) {
		this.vehicle_sn = vehicle_sn;
	}

	public String getVehicle_vin() {
		return vehicle_vin;
	}

	public void setVehicle_vin(String vehicle_vin) {
		this.vehicle_vin = vehicle_vin;
	}

	public String getVehicle_phone() {
		return vehicle_phone;
	}

	public void setVehicle_phone(String vehicle_phone) {
		this.vehicle_phone = vehicle_phone;
	}

	public int getVehicle_lock() {
		return vehicle_lock;
	}

	public void setVehicle_lock(int vehicle_lock) {
		this.vehicle_lock = vehicle_lock;
	}

	public double getVehicle_arrearage() {
		return vehicle_arrearage;
	}

	public void setVehicle_arrearage(double vehicle_arrearage) {
		this.vehicle_arrearage = vehicle_arrearage;
	}

	public String getVehicle_remark() {
		return vehicle_remark;
	}

	public void setVehicle_remark(String vehicle_remark) {
		this.vehicle_remark = vehicle_remark;
	}

	public String getVehicle_guest() {
		return vehicle_guest;
	}

	public void setVehicle_guest(String vehicle_guest) {
		this.vehicle_guest = vehicle_guest;
	}
	
}