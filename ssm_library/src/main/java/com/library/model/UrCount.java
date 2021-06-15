package com.library.model;

public class UrCount {
    private String btxm;
    private int count;
    private String isbn;
    private String bname;
    private String author;
    private String bookImg;

    public UrCount() {
    }

    public UrCount(String btxm, int count, String isbn, String bname, String author, String bookImg) {
        this.btxm = btxm;
        this.count = count;
        this.isbn = isbn;
        this.bname = bname;
        this.author = author;
        this.bookImg = bookImg;
    }

    public String getBtxm() {
        return btxm;
    }

    public void setBtxm(String btxm) {
        this.btxm = btxm;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
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
