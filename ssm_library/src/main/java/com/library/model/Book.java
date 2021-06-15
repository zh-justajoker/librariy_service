package com.library.model;

import org.springframework.web.multipart.MultipartFile;

public class Book {
    private String btxm;
    private String isbn;
    private String bname;
    private String author;
    private int bclass;
    private int state;
    private String bookImg;
    private String bookintro;
    private String className;

    public Book() {
    }

    public Book(String btxm, String isbn, String bname, String author, int bclass, int state, String bookImg, String bookintro, String className) {
        this.btxm = btxm;
        this.isbn = isbn;
        this.bname = bname;
        this.author = author;
        this.bclass = bclass;
        this.state = state;
        this.bookImg = bookImg;
        this.bookintro = bookintro;
        this.className = className;
    }

    public String getBtxm() {
        return btxm;
    }

    public void setBtxm(String btxm) {
        this.btxm = btxm;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public String getBname() {
        return bname;
    }

    public void setBname(String bname) {
        this.bname = bname;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public int getBclass() {
        return bclass;
    }

    public void setBclass(int bclass) {
        this.bclass = bclass;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public String getBookImg() {
        return bookImg;
    }

    public void setBookImg(String bookImg) {
        this.bookImg = bookImg;
    }

    public String getBookintro() {
        return bookintro;
    }

    public void setBookintro(String bookintro) {
        this.bookintro = bookintro;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }
}
