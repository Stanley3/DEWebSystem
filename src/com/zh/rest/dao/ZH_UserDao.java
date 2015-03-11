package com.zh.rest.dao;

import java.util.List;

import com.zh.rest.entities.ZH_User;

public interface ZH_UserDao {
	public String createUser(ZH_User user);//����һ���û�
	public List<ZH_User> getUsers(); //�õ����е��û�
	public ZH_User getUserById(String user_id); //�ȵ�һ���û�ͨ��id
	public int updateUserById(String user_id); //����һ���û�ͨ��id
	public int deleteUserById(String user_id); //ɾ��һ���û�ͨ��id
}