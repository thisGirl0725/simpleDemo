package com.by.controller;

import com.by.model.Tree;
import com.by.service.TreeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import java.util.List;

/**
 * Created by fengqiang on 2019/7/1.
 */
@Controller
@RequestMapping("tree")
public class TreeController {
    @Autowired
    private TreeService treeService;
    @ResponseBody
    @RequestMapping("trees")//查询tree的全部数据
    public List<Tree> trees(@RequestParam(defaultValue ="0",required = false) Integer id){
        List<Tree> list =  treeService.selectAll(id);
        return list;
    }
}
