package com.library.dao;

import com.library.model.Notice;
import com.library.model.UrCount;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface NoticeDao {
    @Select("select * from notice order by ntime desc")
    public List<Notice> getNoticeList();

    @Select("select * from notice where nid=#{nid}")
    public Notice getNoticeById(int nid);

    @Insert("insert into notice values(null,#{header},#{content},#{ntime},0)")
    public boolean insertNotice(Notice notice);

    @Delete("delete from notice where nid = #{nid)}")
    public boolean DeleteOne(int nid);

    // ncount+1
    @Update("update notice set ncount = ncount + 1 where nid=#{nid}")
    public boolean updateNoticeCount(int nid);

    // 查询用户推荐列表前20
    @Select("select * from notice order by ntime desc LIMIT 1")
    public Notice getNewNotice();
}
