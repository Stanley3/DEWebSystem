package com.zh.rest.dao;

import java.util.List;

import com.zh.rest.entities.ZH_User;

public interface ZH_UserDao {
	public int createUser(ZH_User user);//����һ���û�
	public List<ZH_User> getUsers(); //�õ����е��û�
	public ZH_User getUserById(String user_id); //�ȵ�һ���û�ͨ��id
	public int updateUser(ZH_User user); //����һ���û�ͨ��id
	public int deleteUserById(String user_id); //ɾ��һ���û�ͨ��id
	public ZH_User validateUser(String name, String password);
	public List<ZH_User> getQueriedUsers(String name, String role);
}