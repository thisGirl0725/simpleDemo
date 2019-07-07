package com.by.mapper;

import com.by.model.RoleAndUserVo;
import com.by.model.RoleIdVo;
import com.by.model.User;
import org.apache.ibatis.annotations.*;

import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Created by fengqiang on 2019/7/1.
 */
@Mapper
public interface UserMapper {
    User selectByUserName(String userName);

    User selectByUser(@Param("userName") String userName,@Param("userPswd") String UserPswd);

    void addUser(@Param("userName") String userName,@Param("userPswd") String UserPswd);

    List<RoleAndUserVo> selectAll();
    @Select("select * from t_user where user_id =#{id}")
    User queryOne(Integer id);
    @Update("update t_user set user_name=#{userName}, user_pswd =#{userPswd} where user_id =#{id}")
    void updateUser(@Param("userName") String userName,@Param("userPswd") String UserPswd,@Param("id")Integer id);
    void delectById(@Param("arr") List<Integer> arr);
    @Delete("delete from t_role_and_user where user_id=#{id}")
    void deleteByUserId(@Param("id") Integer userId);
    void addUserRole(@Param("id") Integer userId, @Param("roleId") RoleIdVo roleName);


    List<RoleAndUserVo> selectAll2(Map<String, Object> map1);

    Integer selectByCount();
    @Delete("delete from t_user where user_id=#{id}")
    void deleteById(@Param("id") Integer id);

    Set<String> findRoleByUserName(@Param("username") String username);
}
