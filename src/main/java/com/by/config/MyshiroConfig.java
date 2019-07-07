package com.by.config;

import com.by.realm.MyRealm;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Created by liyaqi on 2019/7/4.
 */
@Configuration
public class MyshiroConfig {
    @Bean
    public DefaultWebSecurityManager defaultWebSecurityManager(){
        DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager();
        securityManager.setRealm(myRealm());

        return securityManager;
    }

    @Bean
    public MyRealm myRealm(){
        MyRealm myRealm = new MyRealm();
        /*myRealm.setCredentialsMatcher(hashedCredentialsMatcher());*/

        return myRealm;
    }

   /* @Bean
    public HashedCredentialsMatcher hashedCredentialsMatcher(){
        HashedCredentialsMatcher hashedCredentialsMatcher = new HashedCredentialsMatcher();
        hashedCredentialsMatcher.setHashAlgorithmName("MD5");
        hashedCredentialsMatcher.setHashIterations(3);
        return hashedCredentialsMatcher;
    }*/

    @Bean
    public ShiroFilterFactoryBean shiroFilter(){
        ShiroFilterFactoryBean factoryBean = new ShiroFilterFactoryBean();
        factoryBean.setSecurityManager(defaultWebSecurityManager());
        factoryBean.setLoginUrl("/user/toLoginPage2");//登陆页面为page2
        factoryBean.setSuccessUrl("/user/mian2");//登陆成功后的页面为mian2
        factoryBean.setUnauthorizedUrl("/unauthorized.jsp");//没有权限时跳转的页面
        Map<String ,String> map = new LinkedHashMap<>();
        map.put("/user/toLoginPage","anon");//登陆页面1不需要拦截，可以进入
        map.put("/user/toLoginPage2","anon");//登陆2页面不需要拦截可以进入
        map.put("user/zhucePage2","anon");//注册方法不需要拦截
        map.put("user/zhucePage","anon");//注册方法不需要拦截
        map.put("/user/login","anon");//登陆一方法可以直接进入
        map.put("/user/login2","anon");//登陆2方法可以直接进入
        map.put("/user/logout","logout");//此为登出方法
        map.put("/**","authc");//所有方法拦截
        factoryBean.setFilterChainDefinitionMap(map);
        return factoryBean;
    }



}
