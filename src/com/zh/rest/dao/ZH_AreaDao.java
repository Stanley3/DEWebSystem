package com.zh.rest.dao;

import java.util.List;

import com.zh.rest.entities.ZH_Area;

public interface ZH_AreaDao {
	public String createArea(ZH_Area area); //新增地区
	public ZH_Area getAreaById(String area_id); //获取一个地区的信息
	public List<ZH_Area> getArea(); //获取所有地区的信息
	//获取查询条件的地区信息，暂未实现
	//public List<ZH_Area> getQueriedArea(String.....); 
	public int updateArea(ZH_Area area); //更新指定地区的信息
	public int deleteAreaById(String area_id); //删除一个地区
}