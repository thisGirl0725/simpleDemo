package com.by.realm;

import com.by.model.User;
import com.by.service.UserService;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Set;

/**
 * Created by fengqiang on 2019/7/4.
 */
public class MyRealm extends AuthorizingRealm {
    @Autowired
    private UserService userService;
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {//授权，查出所有的rolename
        String username = (String) principals.getPrimaryPrincipal();
        Set<String> roles = userService.findRoleByUserName(username);
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo(roles);
        return info;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        UsernamePasswordToken token = (UsernamePasswordToken)authenticationToken;//认证通过token查询所有的数据库角色
        String username = token.getUsername();
        User user = userService.findByUserName(username);
        if(user == null){
            return null;
        }
        Object principal = user.getUserName();
        Object credentials = user.getUserPswd();
        String realmName = getName();
        AuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(principal,credentials,realmName);
        return authenticationInfo;
    }



}
