package com.by.controller;

import com.by.model.Role;
import com.by.model.RoleDeleteVo;
import com.by.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Created by fengqiang on 2019/7/1.
 */
@Controller
@RequestMapping("role")//角色表
public class RoleController {
    @Autowired
    private RoleService roleService;
    @RequestMapping("roles")
    @ResponseBody
    public List<Role> roles(){
       List<Role> list = roleService.findAll();
       return list;
    }
    @RequestMapping("roleTablePage")
    public  String roleTable(){
        return "user/roleTable";
    }
    @PutMapping("role")//修改一个
    @ResponseBody
    public String updateRole(Role role) {
        try {
            roleService.updateRole(role);
            return "success";
        } catch (Exception e) {
            return "error";
        }
    }
    @PostMapping("role")//增加一个
    @ResponseBody
    public String insertRole(Role role) {
        try {
            roleService.addRole(role);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

    @GetMapping("role/{id}")//查询一个
    @ResponseBody
    public Role queryOne(@PathVariable("id") Integer id) {
        Role role = roleService.queryOne(id);
        return role;
    }


    @DeleteMapping("role")//删除一个
    @ResponseBody
    public String deleteRole(RoleDeleteVo arr) {
        try {
            roleService.deleteStus(arr);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }


}

