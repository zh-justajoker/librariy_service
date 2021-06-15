package com.library.service;

import com.library.model.Book;
import com.library.model.BookClass;

import java.util.List;

public interface BookClassService {
    public List<BookClass> getBookClassList();

    public List<Book> getBookByClassId(int classId);

    public boolean insertBookClass(BookClass bookClass);

    public boolean DeleteOne(int classId);
}
