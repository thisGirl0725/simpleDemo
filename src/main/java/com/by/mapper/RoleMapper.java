package com.by.mapper;

import com.by.model.Role;
import com.by.model.RoleDeleteVo;

import java.util.List;

import org.apache.ibatis.annotations.*;
@Mapper
public interface RoleMapper {
    @Select("select * from t_role")
    List<Role> selectAll();
    @Update("update t_role set role_name=#{name} where role_id=#{id}")
    void updateRole(@Param("name") String roleName, @Param("id") Integer roleId);
    @Insert("insert into t_role(role_name) values(#{name})")
    void addRole(String roleName);
    @Select("select * from t_role where role_id =#{id}")
    Role queryOne(Integer id);
    void delectById(@Param("arr") List<Integer> arr);
    @Select("select * from t_role")
    List<Role> selectRoles();
    @Select("select role_id from t_role_and_user where user_id =#{userId}")
    List<Integer> selectById(@Param("userId") Integer userId);

}