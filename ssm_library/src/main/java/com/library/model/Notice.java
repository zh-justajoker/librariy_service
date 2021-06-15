package com.library.model;

public class Notice {
    private int nid;
    private String header;
    private String content;
    private Long ntime;
    private int ncount;

    public Notice() {
    }

    public Notice(int nid, String header, String content, Long ntime, int ncount) {
        this.nid = nid;
        this.header = header;
        this.content = content;
        this.ntime = ntime;
        this.ncount = ncount;
    }

    public int getNid() {
        return nid;
    }

    public void setNid(int nid) {
        this.nid = nid;
    }

    public String getHeader() {
        return header;
    }

    public void setHeader(String header) {
        this.header = header;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Long getNtime() {
        return ntime;
    }

    public void setNtime(Long ntime) {
        this.ntime = ntime;
    }

    public int getNcount() {
        return ncount;
    }

    public void setNcount(int ncount) {
        this.ncount = ncount;
    }
}
