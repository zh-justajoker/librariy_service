package com.library.service.impl;

import com.library.dao.BookDao;
import com.library.model.Book;
import com.library.model.BookClass;
import com.library.model.BookClassify;
import com.library.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookServiceImpl implements BookService {
    @Autowired
    private BookDao bookDao;
    @Override
    public List<Book> getBookList() {
        List<Book> books = bookDao.getBookList();
        return books;
    }

    @Override
    public BookClassify getBookClassify(int bclass) {
        BookClassify bookClassify = bookDao.getBookClassify(bclass);
        return bookClassify;
    }

    @Override
    public boolean updateBookState(String btxm, int state) {
        boolean isUpdateBookState = bookDao.updateBookState(btxm,state);
        return isUpdateBookState;
    }

    @Override
    public int bclass(String btxm) {
        int bclass = bookDao.bclass(btxm);
        return bclass;
    }

    @Override
    public Book getBookById(String btxm) {
        Book book = bookDao.getBookById(btxm);
        return book;
    }

    @Override
    public List<BookClass> getBookClassList() {
        List<BookClass> bookClasses = bookDao.getBookClassList();
        return bookClasses;
    }

    @Override
    public boolean updateBook(Book book) {
        boolean isUpdate = bookDao.updateBook(book);
        return isUpdate;
    }

    @Override
    public boolean insertBook(Book book) {
        boolean isInsert = bookDao.insertBook(book);
        return isInsert;
    }

    @Override
    public boolean DeleteOne(String btxm) {
        boolean isDeleteOne = bookDao.DeleteOne(btxm);
        return isDeleteOne;
    }

    @Override
    public List<Book> getBookSearchList(String content) {
        List<Book> books = bookDao.getBookSearchList(content);
        return books;
    }
}
