package com.library.model;

public class FeedBack {
    private int fid;
    private String uno;
    private String uname;
    private String content;
    private String reply;
    private Long ftime;
    private int state;

    public FeedBack() {
    }

    public FeedBack(int fid, String uno, String uname, String content, String reply, Long ftime, int state) {
        this.fid = fid;
        this.uno = uno;
        this.uname = uname;
        this.content = content;
        this.reply = reply;
        this.ftime = ftime;
        this.state = state;
    }

    public int getFid() {
        return fid;
    }

    public void setFid(int fid) {
        this.fid = fid;
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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getReply() {
        return reply;
    }

    public void setReply(String reply) {
        this.reply = reply;
    }

    public Long getFtime() {
        return ftime;
    }

    public void setFtime(Long ftime) {
        this.ftime = ftime;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }
}
