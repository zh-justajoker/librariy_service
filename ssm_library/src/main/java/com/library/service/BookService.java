package com.library.service;

import com.library.model.Book;
import com.library.model.BookClass;
import com.library.model.BookClassify;

import java.util.List;

public interface BookService {
    public List<Book> getBookList();

    public BookClassify getBookClassify(int bclass);

    public int bclass(String btxm);

    public Book getBookById(String btxm);

    public List<BookClass> getBookClassList();

    public boolean updateBookState(String btxm, int state);

    public boolean updateBook(Book book);

    public boolean insertBook(Book book);

    public boolean DeleteOne(String btxm);

    public List<Book> getBookSearchList(String content);
}
