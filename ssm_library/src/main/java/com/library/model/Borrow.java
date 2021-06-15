package com.library.model;

public class Borrow {
    private String bid;
    private String uno;
    private String uname;
    private String btxm;
    private String bname;
    private String author;
    private String bookImg;
    private Long btime;
    private int state;

    public Borrow() {
    }

    public Borrow(String bid, String uno, String uname, String btxm, String bname, String author, String bookImg, Long btime, int state) {
        this.bid = bid;
        this.uno = uno;
        this.uname = uname;
        this.btxm = btxm;
        this.bname = bname;
        this.author = author;
        this.bookImg = bookImg;
        this.btime = btime;
        this.state = state;
    }

    public String getBid() {
        return bid;
    }

    public void setBid(String bid) {
        this.bid = bid;
    }

    public String getUno() {
        return uno;
    }

    public void setUno(String uno) {
        this.uno = uno;
    }

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }

    public String getBtxm() {
        return btxm;
    }

    public void setBtxm(String btxm) {
        this.btxm = btxm;
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

    public Long getBtime() {
        return btime;
    }

    public void setBtime(Long btime) {
        this.btime = btime;
    }

    public String getBookImg() {
        return bookImg;
    }

    public void setBookImg(String bookImg) {
        this.bookImg = bookImg;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }
}
