package com.by.controller;

import com.by.model.Permission;
import com.by.model.PermissionDeleteVo;
import com.by.model.RoleDeleteVo;
import com.by.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.security.Permissions;
import java.util.List;

/**
 * Created by fengqiang on 2019/7/1.
 */
@Controller
@RequestMapping("permission")
public class PermissionController {
    @Autowired
    private PermissionService permissionService;
    @RequestMapping("permissions")
    @ResponseBody
    public List<Permission> permissions(){
        List<Permission> list = permissionService.selectAll();
        return list;
    }
    @RequestMapping("permissionTable")
    public String permissionTable(){
        return "user/permissionTable";
    }

    @PostMapping("permission")//增加一个
    @ResponseBody
    public String insertPermissions(Permission permission) {
        try {
            permissionService.addPermission(permission);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

    @GetMapping("permission/{id}")//查询一个
    @ResponseBody
    public Permission queryOne(@PathVariable("id") Integer id) {
        Permission permission = permissionService.queryOne(id);
        return permission;
    }


    @DeleteMapping("permission")//删除一个
    @ResponseBody
    public String deletepermission(PermissionDeleteVo arr) {
        try {
            permissionService.deletePermissions(arr);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

    @PutMapping("permission")//修改一个
    @ResponseBody
    public String updatePermission(Permission permission) {
        try {
            permissionService.updatePermission(permission);
            return "success";
        } catch (Exception e) {
            return "error";
        }
    }


}
