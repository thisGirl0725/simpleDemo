package com.by.service.impl;

import com.by.mapper.PermissionMapper;
import com.by.model.Permission;
import com.by.model.PermissionDeleteVo;
import com.by.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.security.Permissions;
import java.util.List;

/**
 * Created by fengqiang on 2019/7/1.
 */
@Service
public class PermissionServiceImpl implements PermissionService {
    @Autowired
    private PermissionMapper permissionMapper;
    @Override
    public List<Permission> selectAll() {
        return permissionMapper.selectAll();
    }

    @Override
    public void addPermission(Permission permission) {
        permissionMapper.addPermission(permission.getPermissionName());
    }

    @Override
    public Permission queryOne(Integer id) {
        return permissionMapper.queryOne(id);
    }

    @Override
    public void deletePermissions(PermissionDeleteVo arr) {
        permissionMapper.deletePermissions(arr.getArr());
    }

    @Override
    public void updatePermission(Permission permission) {
        permissionMapper.updatePermission(permission.getPermissionId(),permission.getPermissionName());
    }


}
