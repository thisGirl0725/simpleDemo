package com.by.service.impl;

import com.by.mapper.TreeMapper;
import com.by.model.Tree;
import com.by.service.TreeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by fengqiang on 2019/7/1.
 */
@Service
public class TreeServiceImpl  implements TreeService {
    @Autowired
    private TreeMapper treeMapper;
    @Override
    public List<Tree> selectAll(Integer id) {
        return treeMapper.selectAll(id);
    }
}
