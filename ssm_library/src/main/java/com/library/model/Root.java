package com.library.model;

public class Root {
    private String rname;
    private String rpwd;

    public String getRname() {
        return rname;
    }

    public void setRname(String rname) {
        this.rname = rname;
    }

    public String getRpwd() {
        return rpwd;
    }

    public void setRpwd(String rpwd) {
        this.rpwd = rpwd;
    }

    public Root() {
    }

    public Root(String rname, String rpwd) {
        this.rname = rname;
        this.rpwd = rpwd;
    }
}
