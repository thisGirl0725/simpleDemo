package com.by.service;

import com.by.model.Permission;
import com.by.model.PermissionDeleteVo;
import org.springframework.stereotype.Service;

import java.security.Permissions;
import java.util.List;

/**
 * Created by fengqiang on 2019/7/1.
 */
@Service
public interface PermissionService {
    List<Permission> selectAll();

    void addPermission(Permission permission);

    Permission queryOne(Integer id);

    void deletePermissions(PermissionDeleteVo arr);

    void updatePermission(Permission permission);
}
