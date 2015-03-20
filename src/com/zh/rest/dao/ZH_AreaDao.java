package com.zh.rest.dao;

import java.util.List;
import java.util.Map;

import com.zh.rest.entities.ZH_Area;

public interface ZH_AreaDao {
	public int createArea(ZH_Area area); //��������
	public ZH_Area getAreaById(String area_id); //��ȡһ����������Ϣ
	public List<ZH_Area> getArea(Map<?,?> map); //��ȡ���е�������Ϣ
	//��ȡ��ѯ�����ĵ�����Ϣ����δʵ��
	public List<ZH_Area> getQueriedArea(String address); 
	public int updateArea(ZH_Area area); //����ָ����������Ϣ
	public int deleteAreaById(String area_id); //ɾ��һ������
	public int getCounts();
}