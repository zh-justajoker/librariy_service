package com.library.dao;

import com.library.model.Borrow;
import com.library.model.FeedBack;
import com.library.model.Notice;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface FeedBackDao {
    @Select("select * from feedback order by ftime desc")
    public List<FeedBack> getFeedBackList();

    @Select("select * from feedback where uno = #{uno} order by ftime desc")
    public List<FeedBack> getFeedBackByUno(String uno);

    @Select("select * from feedback where fid=#{fid}")
    public FeedBack getFeedById(int fid);

    @Update("update feedback set ftime = #{ftime},reply = #{reply},state = 1 where fid=#{fid}")
    public boolean updateFeedBack(@Param("ftime")Long ftime,@Param("reply") String reply,@Param("fid") int fid);

    @Insert("insert into feedback values(null,#{uno},#{uname},#{content},null,#{ftime},#{state})")
    public boolean insertFeedBack(FeedBack feedBack);

    @Delete("delete from feedback where fid = #{fid}")
    public boolean DeleteOne(int fid);
}
