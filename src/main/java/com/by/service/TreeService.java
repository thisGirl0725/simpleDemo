package com.by.service;

import com.by.model.Tree;
import org.springframework.stereotype.Service;


import java.util.List;

/**
 * Created by fengqiang on 2019/7/1.
 */
@Service
public interface TreeService {
    List<Tree> selectAll(Integer id);
}
