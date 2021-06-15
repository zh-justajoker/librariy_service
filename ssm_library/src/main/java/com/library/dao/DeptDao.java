package com.library.dao;

import com.library.model.Dept;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface DeptDao {
    @Select("select * from dept")
    public List<Dept> getDeptList();

    @Select("select * from user where deptId = #{id}")
    public List<Dept> getDeptById(int id);

    @Insert("insert into dept values(#{id},#{dname})")
    public boolean insertDept(Dept dept);

    @Delete("delete from dept where id = #{id)}")
    public boolean DeleteOne(int id);
}
