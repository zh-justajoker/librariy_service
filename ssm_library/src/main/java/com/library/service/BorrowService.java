package com.library.service;

import com.library.model.Borrow;

import java.util.List;

public interface BorrowService {
    public List<Borrow> getBorrowList();

    public Borrow getBorrowById(int bid);

    public List<Borrow> getMyBorrow(String uno);

    public List<Borrow> getBorrowHis(String uno);

    public boolean updateBorrow(Borrow borrow);

    public boolean updateBookState(String btxm,int state);

    public boolean insertBorrow(Borrow borrow);

    public boolean DeleteOne(int bid);

    public List<Borrow> getBorrowSearchList(String content);
}
