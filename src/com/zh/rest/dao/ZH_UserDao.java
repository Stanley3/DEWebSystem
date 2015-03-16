package com.zh.rest.dao;

import java.util.List;

import com.zh.rest.entities.ZH_User;

public interface ZH_UserDao {
	public int createUser(ZH_User user);//创建一个用户
	public List<ZH_User> getUsers(); //得到所有的用户
	public ZH_User getUserById(String user_id); //等到一个用户通过id
	public int updateUser(ZH_User user); //更新一个用户通过id
	public int deleteUserById(String user_id); //删除一个用户通过id
	public ZH_User validateUser(String name, String password);
	public List<ZH_User> getQueriedUsers(String name, String role);
}