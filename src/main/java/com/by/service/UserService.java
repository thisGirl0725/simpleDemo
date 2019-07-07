package com.by.service;

import com.by.model.RoleAndUserVo;
import com.by.model.RoleIdVo;
import com.by.model.User;
import com.by.model.UserDeleteVo;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Created by fengqiang on 2019/7/1.
 */
@Service
public interface UserService {


    void addUser(User user);

    boolean selectByUserName(User user);

    boolean selectByName(User user);

    List<RoleAndUserVo> selectAll();

    User queryOne(Integer id);

    void updateUser(User user);

    void deleteusers(UserDeleteVo arr);

    Map<String, Object> selectRoles(Integer userId);

    void addUserRole(Integer userId, RoleIdVo userName);

    List<RoleAndUserVo> selectAll2(Map<String, Object> map1);

    Integer selectByCount();

    void deleteOne(Integer id);

    User findByUserName(String username);

    Set<String> findRoleByUserName(String username);
}
