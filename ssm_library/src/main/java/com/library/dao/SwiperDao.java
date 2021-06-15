package com.library.dao;

import com.library.model.Dept;
import com.library.model.Swiper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface SwiperDao {
    @Select("select * from swiper")
    public List<Swiper> getSwiperList();

    @Select("select * from swiper where sid = #{sid}")
    public Swiper getSwiperById(int sid);

    @Update("update swiper set swUrl = #{swUrl} where sid = #{sid}")
    public boolean updateSwiper(@Param("sid")int sid,@Param("swUrl")String swUrl);
}
