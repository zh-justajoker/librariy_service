package com.library.dao;

import com.library.model.Book;
import com.library.model.BookClass;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface BookClassDao {
    @Select("select * from bookClass")
    public List<BookClass> getBookClassList();

    @Select("select * from book where bclass = #{classId}")
    public List<Book> getBookByClassId(int classId);

    @Insert("insert into bookClass values(#{classId},#{className})")
    public boolean insertBookClass(BookClass bookClass);

    @Delete("delete from bookClass where classId = #{classId}")
    public boolean DeleteOne(int classId);
}
