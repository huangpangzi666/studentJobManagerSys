package com.submit.mapper;

import com.submit.entity.TLogin;
import com.submit.entity.TLoginExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TLoginMapper {
    int countByExample(TLoginExample example);

    int deleteByExample(TLoginExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(TLogin record);

    int insertSelective(TLogin record);

    List<TLogin> selectByExample(TLoginExample example);

    TLogin selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") TLogin record, @Param("example") TLoginExample example);

    int updateByExample(@Param("record") TLogin record, @Param("example") TLoginExample example);

    int updateByPrimaryKeySelective(TLogin record);

    int updateByPrimaryKey(TLogin record);
}