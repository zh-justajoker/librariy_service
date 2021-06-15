package com.library.dao;

import com.library.model.Borrow;
import com.library.model.Root;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectProvider;
import org.apache.ibatis.annotations.Update;

import java.util.Map;

public interface RootDao {
    @Select("select * from root where rname= #{rname} and rpwd=#{rpwd}")
    public Root login(@Param("rname")String rname,@Param("rpwd")String rpwd);

    @Select("select * from root where rpwd=#{rpwd}")
    public Root getPwd(@Param("rpwd")String rpwd);

    @Update("update root set rpwd = #{rpwd} where rname = 'xculibrary'")
    public boolean updatePwd(@Param("rpwd")String rpwd);
}
