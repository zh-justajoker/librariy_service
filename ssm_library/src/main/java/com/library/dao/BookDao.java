package com.library.dao;

import com.library.model.Book;
import com.library.model.BookClass;
import com.library.model.BookClassify;
import com.library.model.Borrow;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface BookDao {
    @Select("select * from book b inner join bookclass bc on b.bclass = bc.classId order by b.bclass")
    public List<Book> getBookList();

    @Select("select * from book where bclass = #{bclass}")
    public List<Book> getBookBybClass(int bclass);

    @Select("select bclass from book where btxm = #{btxm}")
    public int bclass(String btxm);

    @Select("select * from bookClass where classId = #{bclass}")
    @Results({@Result(property = "books", column = "classId",
                    many = @Many(select = "com.library.dao.BookDao.getBookBybClass"))
    })
    public BookClassify getBookClassify(int bclass);

    @Update("update book set state = #{state} where btxm=#{btxm}")
    public boolean updateBookState(@Param("btxm")String btxm,@Param("state") int state);

    @Select("select * from book b inner join bookclass bc on b.bclass = bc.classId where btxm = #{btxm}")
    public Book getBookById(String btxm);

    @Select("select * from bookClass")
    public List<BookClass> getBookClassList();

    @Update("update book set isbn = #{isbn},bname = #{bname},author = #{author},bclass = #{bclass},state = #{state},bookImg = #{bookImg} where btxm=#{btxm}")
    public boolean updateBook(Book book);

    @Insert("insert into book values(#{btxm},#{isbn},#{bname},#{author},#{bclass},#{state},#{bookintro},#{bookImg})")
    public boolean insertBook(Book book);

    @Delete("delete from book where btxm = #{btxm}")
    public boolean DeleteOne(String btxm);

    //模糊查询
    @Select("select * from book b inner join bookclass bc on b.bclass = bc.classId where b.isbn like '${content}%' or b.bname like '%${content}%'")
    public List<Book> getBookSearchList(String content);
}
