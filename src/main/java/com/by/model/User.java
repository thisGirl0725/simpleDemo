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
public class User {
    private  Integer userId;
    private  String userName;
    private  String userPswd;
}
