package com.by.service.impl;

import com.by.mapper.RoleMapper;
import com.by.model.Role;
import com.by.model.RoleDeleteVo;
import com.by.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by fengqiang on 2019/7/1.
 */
@Service
public class RoleServiceImpl implements RoleService {
    @Autowired
    private RoleMapper roleMapper;

    @Override
    public List<Role> findAll() {
        return roleMapper.selectAll();
    }

    @Override
    public void updateRole(Role role) {
        roleMapper.updateRole(role.getRoleName(),role.getRoleId());
    }

    @Override
    public void addRole(Role role) {
        roleMapper.addRole(role.getRoleName());
    }

    @Override
    public Role queryOne(Integer id) {
        return roleMapper.queryOne(id);
    }

    @Override
    public void deleteStus(RoleDeleteVo arr) {

        roleMapper.delectById(arr.getArr());
    }
}
