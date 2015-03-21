package com.zh.rest.dao;

import java.util.List;
import java.util.Map;

import com.zh.rest.entities.DetialVehicleInfo;
import com.zh.rest.entities.ZH_Vehicle;

public interface ZH_VehicleDao {
	public int createVehicle(ZH_Vehicle vehicle); //新增车辆
	public ZH_Vehicle getVehicleById(String vehicle_id); //获取一个车辆的信息
	public List<DetialVehicleInfo> getVehicles(Map<?,?>map); //获取所有的车辆信息
//	public List<DetialVehicleInfo> getQueridVehicles(String vehicle_vin,
//					String vehicle_sn, String vehicle_phone, String guest, String lock, String remark, String arrearage); //获取符合条件的车辆信息
	public List<DetialVehicleInfo> getQueriedVehicles(Map<String, Object> map);
	public int updateVehicle(ZH_Vehicle vehicle ); //更新一个车辆的信息
	public int deleteVehicleById(String vehicle_id); //删除一个车辆的信息
	public int getCounts();
}