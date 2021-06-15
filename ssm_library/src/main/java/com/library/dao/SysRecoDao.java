package com.library.dao;

import com.library.model.Book;
import com.library.model.SysRecommend;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface SysRecoDao {
    @Insert("insert into sys_recommend values(null,#{btxm})")
    public boolean insertBook(String btxm);

    @Select("select bclass from book where btxm = #{btxm}")
    public int bclass(String btxm);

    @Select("select * from sys_recommend sr inner join book b on sr.btxm = b.btxm")
    public List<SysRecommend> getSysRecoList();

    @Select("select * from sys_recommend where btxm = #{btxm}")
    public SysRecommend getSysRecommendById(String btxm);

    @Select("select count(*) from sys_recommend")
    public int getSysRecoCount();

    @Delete("delete from sys_recommend where btxm = #{btxm}")
    public boolean DeleteOne(String btxm);
}
