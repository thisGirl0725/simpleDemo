package com.by.service.impl;

import com.by.mapper.RoleMapper;
import com.by.mapper.UserMapper;
import com.by.model.*;
import com.by.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Created by fengqiang on 2019/7/1.
 */
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private RoleMapper roleMapper;

    @Override
    public void addUser(User user) {
        userMapper.addUser(user.getUserName(),user.getUserPswd());
    }

    @Override
    public boolean selectByUserName(User user) {
        User user1 = userMapper.selectByUser(user.getUserName(),user.getUserPswd());//通过name查询一组数据
        if(user1 != null){
            return true;
        }
        return false;
    }

    @Override
    public boolean selectByName(User user) {
        User user1 = userMapper.selectByUserName(user.getUserName());
        if (user1 == null){
            userMapper.addUser(user.getUserPswd(),user.getUserName());
            return true;
        }

        return false;
    }

    @Override
    public List<RoleAndUserVo> selectAll() {
        return userMapper.selectAll();
    }

    @Override
    public User queryOne(Integer id) {
        return userMapper.queryOne(id);
    }

    @Override
    public void updateUser(User user) {
        userMapper.updateUser(user.getUserName(),user.getUserPswd(),user.getUserId());
    }

    @Override
    public void deleteusers(UserDeleteVo arr) {
        List<Integer> arr1 = arr.getArr();
        userMapper.delectById(arr1);

    }

    @Override
    public Map<String, Object> selectRoles(Integer userId) {
        Map<String,Object> map = new HashMap<>();
        List<Role> list1 = roleMapper.selectRoles();//获取role的全部数据
        map.put("roles",list1);
        List<Integer> list2 = roleMapper.selectById(userId);
        map.put("roleIds",list2);
        return map;
    }

    @Override
    public void addUserRole(Integer userId, RoleIdVo roleName ) {
        userMapper.deleteByUserId(userId);
        userMapper.addUserRole(userId,roleName);

    }

    @Override
    public List<RoleAndUserVo> selectAll2(Map<String, Object> map1) {
        return  userMapper.selectAll2(map1);
    }

    @Override
    public Integer selectByCount() {
        return userMapper.selectByCount();
    }

    @Override
    public void deleteOne(Integer id) {
        userMapper.deleteById(id);
    }

    @Override
    public User findByUserName(String username) {
        return userMapper.selectByUserName(username);
    }

    @Override
    public Set<String> findRoleByUserName(String username) {
        return userMapper.findRoleByUserName(username);
    }


}
