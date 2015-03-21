package com.zh.rest.dao;

import java.util.List;
import java.util.Map;

import com.zh.rest.entities.DetialGuestInfo;
import com.zh.rest.entities.ZH_Guest;

public interface ZH_GuestDao {
	public int createGuest(ZH_Guest guest);//新增客户
	public DetialGuestInfo getGuestById(String guest_id); //获取一个客户的信息
	public List<DetialGuestInfo> getGuests(Map<?,?> map); //获取所有客户的信息
	//按客户名、客户手机号、客户地区查询
	public List<DetialGuestInfo> getQueriedGuests(String guest_name, String guest_phone, String guest_area);
	public int updateGuest(ZH_Guest guest); //更新指定客户的信息
	public int deleteGuestById(String guest_id); //删除一个客户信息
	public int getCounts();
}