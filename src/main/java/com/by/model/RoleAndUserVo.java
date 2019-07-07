package com.by.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.List;

/**
 * Created by fengqiang on 2019/7/2.
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class RoleAndUserVo extends User{
    private List<Role> roles;
}
