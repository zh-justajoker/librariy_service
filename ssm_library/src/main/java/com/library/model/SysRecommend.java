package com.library.model;

public class SysRecommend {
    private int id;
    private String btxm;
    private String isbn;
    private String bname;
    private String author;
    private String bookImg;


    public SysRecommend() {
    }

    public SysRecommend(int id, String btxm, String isbn, String bname, String author, String bookImg) {
        this.id = id;
        this.btxm = btxm;
        this.isbn = isbn;
        this.bname = bname;
        this.author = author;
        this.bookImg = bookImg;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public String getBookImg() {
        return bookImg;
    }

    public void setBookImg(String bookImg) {
        this.bookImg = bookImg;
    }
}
