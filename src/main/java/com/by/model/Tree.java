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
public class Tree {
    private Integer id;

    private String text;

    private String iconCls;

    private String state;

    private String ckecked;

    private String url;

    private Integer pid;
}
