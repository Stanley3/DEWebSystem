package com.zh.rest.dao;

import java.util.List;

import com.zh.rest.entities.DetialVehicleInfo;
import com.zh.rest.entities.ZH_Vehicle;

public interface ZH_VehicleDao {
	public String createVehicle(ZH_Vehicle vehicle); //��������
	public ZH_Vehicle getVehicleById(String vehicle_id); //��ȡһ����������Ϣ
	public List<DetialVehicleInfo> getVehicles(); //��ȡ���еĳ�����Ϣ
//	public List<DetialVehicleInfo> getQueridVehicles(String vehicle_vin,
//					String vehicle_sn, String vehicle_phone, String area, String lock_status); //��ȡ���������ĳ�����Ϣ
	public int updateVehicle(ZH_Vehicle vehicle ); //����һ����������Ϣ
	public int deleteVehicleById(String vehicle_id); //ɾ��һ����������Ϣ
}