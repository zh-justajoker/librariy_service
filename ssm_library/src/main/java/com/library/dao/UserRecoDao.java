package com.library.dao;

import com.library.model.Borrow;
import com.library.model.SysRecommend;
import com.library.model.UrCount;
import com.library.model.UserRecomend;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface UserRecoDao {

    // 查询是否推荐过
    @Select("select * from user_recommend where uno = #{uno} and btxm = #{btxm}")
    public UserRecomend getUserRecomendByUB(@Param("uno")String uno,@Param("btxm") String btxm);

    @Select("select * from user_recommend where uno = #{uno}")
    public List<UserRecomend> getMyRecomendList(String uno);

    // 添加到用户推荐
    @Insert("insert into user_recommend values(null,#{uno},#{btxm},#{bname},#{author},#{isbn},#{bookImg})")
    public boolean insertUserRecomend(UserRecomend UserRecomend);

    // 删除用户推荐记录
    @Delete("delete from user_recommend where uno = #{uno} and btxm = #{btxm}")
    public boolean DeleteUserRecomendOne(@Param("uno")String uno,@Param("btxm") String btxm);

    // 查询推荐
    @Select("select * from ur_count where btxm = #{btxm}")
    public UrCount getUrCountById(String btxm);

    // 查询表中有多少条数据
    @Select("select count(btxm) from ur_count")
    public int getCount();

    // 查询用户推荐列表不超过20条
    @Select("select * from ur_count ur inner join book b on ur.btxm = b.btxm order by count desc")
    public List<UrCount> getUrCountList();

    // 查询用户推荐列表前20
    @Select("select * from ur_count ur inner join book b on ur.btxm = b.btxm order by count desc LIMIT 30")
    public List<UrCount> getUrCountTwList();

    // 没有直接添加
    @Insert("insert into ur_count values(#{btxm},1)")
    public boolean insertUrCount(String btxm);

    // 有count+1
    @Update("update ur_count set count = count + 1 where btxm=#{btxm}")
    public boolean updateUrCount(String btxm);


    // 查询count的值
    @Select("select count from ur_count where btxm=#{btxm}")
    public int getCountNum(String btxm);
    // count为1直接删除
    @Delete("delete from ur_count where btxm=#{btxm}")
    public boolean deleteUrCount(String btxm);

    // count>1让count-1
    @Update("update ur_count set count = count - 1 where btxm=#{btxm}")
    public boolean deleteCountjy(String btxm);
}
