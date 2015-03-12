package com.zh.rest.dao;

import java.util.List;

import com.zh.rest.entities.ZH_Vehicle;

public interface ZH_VehicleDao {
	public String createVehicle(ZH_Vehicle vehicle); //新增车辆
	public ZH_Vehicle getVehicleById(String vehicle_id); //获取一个车辆的信息
	public List<ZH_Vehicle> getVehilces(); //获取所有的车辆信息
	public List<ZH_Vehicle> getQueridVehicles(String vehicle_vin,
					String vehicle_sn, String vehicle_phone, String area, String lock_status); //获取符合条件的车辆信息
	public int updateVehicle(ZH_Vehicle vehicle ); //更新一个车辆的信息
	public int deleteVehicleById(String vehicle_id); //删除一个车辆的信息
}