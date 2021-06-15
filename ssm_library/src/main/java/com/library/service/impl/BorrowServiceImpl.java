package com.library.service.impl;

import com.library.dao.BorrowDao;
import com.library.model.Borrow;
import com.library.service.BorrowService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BorrowServiceImpl implements BorrowService {
    @Autowired
    private BorrowDao borrowDao;

    @Override
    public List<Borrow> getBorrowList() {
        List<Borrow> borrows = borrowDao.getBorrowList();
        return borrows;
    }

    @Override
    public Borrow getBorrowById(int bid) {
        Borrow borrow = borrowDao.getBorrowById(bid);
        return borrow;
    }

    @Override
    public List<Borrow> getMyBorrow(String uno) {
        List<Borrow> borrows = borrowDao.getMyBorrow(uno);
        return borrows;
    }

    @Override
    public List<Borrow> getBorrowHis(String uno) {
        List<Borrow> borrows = borrowDao.getBorrowHis(uno);
        return borrows;
    }

    @Override
    public boolean updateBorrow(Borrow borrow) {
        boolean isUpdate = borrowDao.updateBorrow(borrow);
        return isUpdate;
    }

    @Override
    public boolean updateBookState(String btxm, int state) {
        boolean isUpdateBookState = borrowDao.updateBookState(btxm,state);
        return isUpdateBookState;
    }

    @Override
    public boolean insertBorrow(Borrow borrow) {
        boolean isInsert = borrowDao.insertBorrow(borrow);
        return isInsert;
    }

    @Override
    public boolean DeleteOne(int bid) {
        boolean isDelete = borrowDao.DeleteOne(bid);
        return isDelete;
    }

    @Override
    public List<Borrow> getBorrowSearchList(String content) {
        List<Borrow> borrows = borrowDao.getBorrowSearchList(content);
        return borrows;
    }
}
