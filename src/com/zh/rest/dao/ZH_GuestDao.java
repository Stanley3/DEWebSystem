package com.zh.rest.dao;

import java.util.List;

import com.zh.rest.entities.DetialGuestInfo;
import com.zh.rest.entities.ZH_Guest;

public interface ZH_GuestDao {
	public String createGuest(ZH_Guest guest);//�����ͻ�
	public DetialGuestInfo getGuestById(String guest_id); //��ȡһ���ͻ�����Ϣ
	public List<DetialGuestInfo> getGuests(); //��ȡ���пͻ�����Ϣ
	//���ͻ������ͻ��ֻ��š��ͻ�������ѯ
	public List<ZH_Guest> getQueriedVehicles(String guest_name, String guest_phone, String guest_area);
	public int updateGuest(ZH_Guest guest); //����ָ���ͻ�����Ϣ
	public int deleteGuestById(String guest_id); //ɾ��һ���ͻ���Ϣ
}