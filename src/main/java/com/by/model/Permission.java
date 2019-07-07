package com.by.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Created by fengqiang on 2019/7/1.
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Permission {
    private Integer permissionId;
    private  String permissionName;
}
