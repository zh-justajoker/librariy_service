package com.library.model;

import java.util.List;

public class BookClassify {
    private String classId;
    private String className;
    private List<Book> books;

    public BookClassify() {
    }

    public BookClassify(String classId, String className, List<Book> books) {
        this.classId = classId;
        this.className = className;
        this.books = books;
    }

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public List<Book> getBooks() {
        return books;
    }

    public void setBooks(List<Book> books) {
        this.books = books;
    }
}
