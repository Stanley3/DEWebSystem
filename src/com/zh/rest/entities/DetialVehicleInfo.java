package com.zh.rest.entities;

import java.io.Serializable;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class DetialVehicleInfo implements Serializable{
	public static final long serialVersionUID = -3396866965380607637L;
	private String vehicle_sn;
	private String vehicle_vin;
	private String vehicle_phone;
	private int vehicle_lock;
	private double vehicle_arrearage;
	private int vehicle_status;
	private String vehicle_version;
	private String guest_name;
	private String guest_cellphone;
	private String guest_address;
	
	public DetialVehicleInfo(){}

	public DetialVehicleInfo(String vehicle_sn, String vehicle_vin,
			String vehicle_phone, int vehicle_lock, double vehicle_arrearage,
			int vehicle_status, String vehicle_version, String guest_name,
			String guest_cellphone, String guest_address) {
		this.vehicle_sn = vehicle_sn;
		this.vehicle_vin = vehicle_vin;
		this.vehicle_phone = vehicle_phone;
		this.vehicle_lock = vehicle_lock;
		this.vehicle_arrearage = vehicle_arrearage;
		this.vehicle_status = vehicle_status;
		this.vehicle_version = vehicle_version;
		this.guest_name = guest_name;
		this.guest_cellphone = guest_cellphone;
		this.guest_address = guest_address;
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

	public int getVehicle_status() {
		return vehicle_status;
	}

	public void setVehicle_status(int vehicle_status) {
		this.vehicle_status = vehicle_status;
	}

	public String getVehicle_version() {
		return vehicle_version;
	}

	public void setVehicle_version(String vehicle_version) {
		this.vehicle_version = vehicle_version;
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

	public String getGuest_address() {
		return guest_address;
	}

	public void setGuest_address(String guest_address) {
		this.guest_address = guest_address;
	}
	
	
}