package com.by.mapper;

import com.by.model.Permission;
import org.apache.ibatis.annotations.*;

import java.security.Permissions;
import java.util.List;

/**
 * Created by fengqiang on 2019/7/1.
 */
@Mapper
public interface PermissionMapper {
    @Select("select * from t_permission")
    List<Permission> selectAll();
    @Insert("insert into t_permission(permission_name) values(#{name})")
    void addPermission(String name);
    @Select("select * from t_permission where permission_id = #{id}")
    Permission queryOne(Integer id);

    void deletePermissions(@Param("arr") List<Integer> arr);
    @Update("update  t_permission set permission_Name=#{name} where permission_Id =#{id}  ")
    void updatePermission(@Param("id") Integer permissionId,@Param("name")  String permissionName);



}
