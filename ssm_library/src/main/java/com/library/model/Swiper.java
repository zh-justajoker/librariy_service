package com.library.model;

public class Swiper {
    private int sid;
    private String swUrl;

    public Swiper() {
    }

    public Swiper(int sid, String swUrl) {
        this.sid = sid;
        this.swUrl = swUrl;
    }

    public int getSid() {
        return sid;
    }

    public void setSid(int sid) {
        this.sid = sid;
    }

    public String getSwUrl() {
        return swUrl;
    }

    public void setSwUrl(String swUrl) {
        this.swUrl = swUrl;
    }
}
