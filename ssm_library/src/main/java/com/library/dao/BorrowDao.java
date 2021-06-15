package com.library.dao;

import com.library.model.Book;
import com.library.model.BookClass;
import com.library.model.Borrow;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface BorrowDao {
    @Select("select * from borrow order by btime desc")
    public List<Borrow> getBorrowList();

    @Select("select * from borrow where bid = #{bid}")
    public Borrow getBorrowById(int bid);

    @Select("select * from borrow where uno = #{uno} and state=1 order by btime desc")
    public List<Borrow> getMyBorrow(String uno);

    @Select("select * from borrow where uno = #{uno} order by btime desc")
    public List<Borrow> getBorrowHis(String uno);

    @Update("update borrow set btime = #{btime}, state = #{state} where bid=#{bid}")
    public boolean updateBorrow(Borrow borrow);

    @Update("update book set state = #{state} where btxm=#{btxm}")
    public boolean updateBookState(@Param("btxm")String btxm,@Param("state") int state);

    @Insert("insert into borrow values(null,#{uno},#{uname},#{btxm},#{bname},#{author},#{btime},#{state},#{bookImg})")
    public boolean insertBorrow(Borrow borrow);

    @Delete("delete from borrow where bid = #{bid}")
    public boolean DeleteOne(int bid);

    //模糊查询
    @Select("select * from borrow where uno like '${content}%' or bname like '%${content}%'")
    public List<Borrow> getBorrowSearchList(String content);
}
