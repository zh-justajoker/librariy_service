package com.library.model;

public class UserRecomend {
    private int urId;
    private String uno;
    private String btxm;
    private String author;
    private String bname;
    private String isbn;
    private String bookImg;

    public UserRecomend() {
    }

    public UserRecomend(int urId, String uno, String btxm, String author, String bname, String isbn, String bookImg) {
        this.urId = urId;
        this.uno = uno;
        this.btxm = btxm;
        this.author = author;
        this.bname = bname;
        this.isbn = isbn;
        this.bookImg = bookImg;
    }

    public int getUrId() {
        return urId;
    }

    public void setUrId(int urId) {
        this.urId = urId;
    }

    public String getUno() {
        return uno;
    }

    public void setUno(String uno) {
        this.uno = uno;
    }

    public String getBtxm() {
        return btxm;
    }

    public void setBtxm(String btxm) {
        this.btxm = btxm;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getBname() {
        return bname;
    }

    public void setBname(String bname) {
        this.bname = bname;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public String getBookImg() {
        return bookImg;
    }

    public void setBookImg(String bookImg) {
        this.bookImg = bookImg;
    }
}
