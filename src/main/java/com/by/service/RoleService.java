package com.by.service;

import com.by.model.Role;
import com.by.model.RoleDeleteVo;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by fengqiang on 2019/7/1.
 */
@Service
public interface RoleService {
    List<Role> findAll();

    void updateRole(Role role);

    void addRole(Role role);

    Role queryOne(Integer id);

    void deleteStus(RoleDeleteVo arr);
}
