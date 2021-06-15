package com.library.service.impl;

import com.library.dao.BookClassDao;
import com.library.model.Book;
import com.library.model.BookClass;
import com.library.service.BookClassService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class BookClassServiceImpl implements BookClassService {
    @Autowired
    private BookClassDao bookClassDao;
    @Override
    public List<BookClass> getBookClassList() {
        List<BookClass> bookClassList = bookClassDao.getBookClassList();
        return bookClassList;
    }

    @Override
    public List<Book> getBookByClassId(int classId) {
        List<Book> books = bookClassDao.getBookByClassId(classId);
        return books;
    }

    @Override
    public boolean insertBookClass(BookClass bookClass) {
        boolean isInsert = bookClassDao.insertBookClass(bookClass);
        return isInsert;
    }

    @Override
    public boolean DeleteOne(int classId) {
        boolean isDelete = bookClassDao.DeleteOne(classId);
        return isDelete;
    }
}
