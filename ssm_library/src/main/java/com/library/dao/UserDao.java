package com.library.dao;

import com.library.model.Dept;
import com.library.model.User;
import org.apache.ibatis.annotations.*;

import java.util.List;
import java.util.Map;

public interface UserDao {
    @Select("select * from user u inner join dept d on u.deptId = d.id  where u.uno = #{uno} and u.upwd = #{upwd}")
    public User userLogin(@Param("uno")String uno,@Param("upwd")String upwd);

    @Select("select * from user u inner join dept d on u.deptId = d.id")
    public List<User> getUserList();

    @Select("select * from user where uno = #{uno}")
    public User getUserById(String uno);

    @Select("select * from dept")
    public List<Dept> getDeptList();

    @Update("update user set uname = #{uname},sex = #{sex},age = #{age},deptId = #{deptId} where uno=#{uno}")
    public boolean updateUser(User user);

    @Insert("insert into user values(#{uno},#{uname},#{upwd},#{sex},#{age},#{deptId})")
    public boolean insertUser(User user);

    @Delete("delete from user where uno = #{uno}")
    public boolean DeleteOne(String uno);

    //模糊查询
    @Select("select * from user u inner join dept d on u.deptId = d.id where u.uno like '${content}%' or u.uname like '%${content}%'")
    public List<User> getUserSearchList(String content);

    @Update("update user set upwd = #{upwd} where uno=#{uno}")
    public boolean modifyPwd(@Param("uno")String uno,@Param("upwd")String upwd);
}
