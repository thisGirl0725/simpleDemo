package com.by.mapper;

import com.by.model.Tree;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * Created by fengqiang on 2019/7/1.
 */
@Mapper
public interface TreeMapper {
    @Select("select * from t_tree where pid =#{id}")
    List<Tree> selectAll(Integer id);
}
