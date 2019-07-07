package com.by.controller;

import com.by.model.RoleAndUserVo;
import com.by.model.RoleIdVo;
import com.by.model.User;
import com.by.model.UserDeleteVo;
import com.by.service.UserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by fengqiang on 2019/7/1.
 */
@Controller
@RequestMapping("user")
public class UserController {
    @Autowired
    private UserService userService;


    @RequestMapping("toLoginPage")//到登陆页面
    public String loginpage(){

        return "user/loginPage";
    }
    @RequestMapping("toLoginPage2")//到登陆页面2（layui）
    public String loginpage2(){
        return "user/loginPage2";
    }

    @RequestMapping("login")//通过username判断然后登陆   第一种页面登陆后为easyui
    public String users(User user, ModelMap map){
        boolean b = userService.selectByUserName(user);
        if (b){
            return "redirect:/user/mian";//重定向到ersyui页面
        }
        map.put("msg","账户或密码不正确");
        return "user/loginPage";
    }
    @RequestMapping("login2")//通过username判断然后登陆
    public String users2(String userName,String userPswd,ModelMap map){
        Subject subject = SecurityUtils.getSubject();//shiro认证，进入成功后为layui界面
        UsernamePasswordToken token = new UsernamePasswordToken(userName,userPswd);
        token.setRememberMe(true);
        try {
            subject.login(token);
            System.out.println("登陆成功");
            return "redirect:/user/mian2";
        } catch (UnknownAccountException e) {
            System.out.println("登陆失败 ");
            map.put("msg","用户名不存在");
            return "user/loginPage2";
        }catch(IncorrectCredentialsException e){
            map.put("msg","密码错误");
            return "user/loginPage2";
        }

    }
    @RequestMapping("toZhucePage")//到注册页面
    public  String zhucePage(){
        return "user/zhucePage";
    }
    @RequestMapping("toZhucePage2")//到注册2页面，登录后为layui的页面
    public  String zhucePage2(){
        return "user/zhucePage2";
    }
    @RequestMapping("mian")//到mian页面
    public String mian(){
        return "user/mian";
    }
    @RequestMapping("zhuce")//注册
    public String zhuce(User user,ModelMap map){
        boolean b = userService.selectByName(user);
        if (b){
            map.put("msg","注册成功，请返回登陆页面");
            return "user/zhucePage";
        }
        map.put("msg","用户名已存在，请重新输入");
        return "user/zhucePage";

    }
    @ResponseBody
    @RequestMapping("users")//查询用户表数据 easyui
    public List<RoleAndUserVo> users(){
        List<RoleAndUserVo> list = userService.selectAll();
        return list;
    }
    @RequestMapping("toUserTable")//去user表
    public String userTable(){
        return "user/userTable";
    }
    @RequestMapping("toUserTable2")//去user2表
    public String userTable2(){
        return "user/userTable2";
    }
    @PostMapping("user")//增加一个
    @ResponseBody
    public String insertUser(User user) {
        try {
            userService.addUser(user);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }
    @GetMapping("user/{id}")//查询一个
    @ResponseBody
    public User queryOne(@PathVariable("id") Integer id) {
        User user = userService.queryOne(id);
        return user;
    }

    @PutMapping("user")//修改一个
    @ResponseBody
    public String updateUser(User user) {
        try {
            userService.updateUser(user);
            return "success";
        } catch (Exception e) {
            return "error";
        }
    }
    @DeleteMapping("user")//删除一个
    @ResponseBody
    public String deleteUsers(UserDeleteVo arr) {
        try {
            userService.deleteusers(arr);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }
    @RequestMapping("roles/{id}")//查询userid的所有rolename
    @ResponseBody
    public Map<String,Object> roles(@PathVariable("id") Integer userId){
        Map<String,Object> map = new HashMap<>();
        map = userService.selectRoles(userId);
        return map;
    }
    @RequestMapping("roles")
    @ResponseBody
    public Map<String,Object> roles2(@RequestParam("userId") Integer userId){
        Map<String,Object> map = new HashMap<>();
        map = userService.selectRoles(userId);
        return map;
    }
    @ResponseBody
    @RequestMapping("addUserRole")
    public String addUserRole(Integer userId, RoleIdVo roleName){
        try {
            userService.addUserRole(userId,roleName);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }
    @ResponseBody
    @RequestMapping("addUserRole2")
    public Map<String,String> addUserRole2(Integer userId, RoleIdVo roleName){
        Map<String,String> map = new HashMap<>();
        try {
            userService.addUserRole(userId,roleName);
            map.put("success","success");
            return map;
        } catch (Exception e) {
            e.printStackTrace();
            map.put("error","error");
            return map;
        }
    }
    @RequestMapping("mian2")
    public String mian2(){
        return "user/mian2";
    }
    @RequestMapping("users2")//layui界面
    @ResponseBody
    public Map<String,Object> users2(int page, int limit){
        Map<String, Object> map1 = new HashMap<>();
        map1.put("start",(page-1)*limit);
        map1.put("limit",limit);
        Map map = new HashMap();
        List<RoleAndUserVo> list = userService.selectAll2(map1);
        Integer count = userService.selectByCount();
        map.put("msg","");
        map.put("count",count);
        map.put("code",0);
        map.put("data",list);
        return map;
    }
    @DeleteMapping("user/{id}")
    @ResponseBody
    public Map<String,String >deleteOne(@PathVariable("id") Integer id){
        Map<String,String > map =new HashMap<>();
        try {
            userService.deleteOne(id);
            map.put("success","success");
            return map;
        } catch (Exception e) {
            map.put("error","error");
            return map;
        }

    }

}
