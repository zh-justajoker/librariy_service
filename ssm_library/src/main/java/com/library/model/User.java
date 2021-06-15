package com.library.model;

public class User {
    private String uno;
    private String uname;
    private String upwd;
    private int sex;
    private int age;
    private int deptId;
    private String dname;

    public String getDname() {
        return dname;
    }

    public void setDname(String dname) {
        this.dname = dname;
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

    public String getUpwd() {
        return upwd;
    }

    public void setUpwd(String upwd) {
        this.upwd = upwd;
    }

    public int getSex() {
        return sex;
    }

    public void setSex(int sex) {
        this.sex = sex;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public int getDeptId() {
        return deptId;
    }

    public void setDeptId(int deptId) {
        this.deptId = deptId;
    }

    public User() {
    }

    public User(String uno, String uname, String upwd, int sex, int age, int deptId) {
        this.uno = uno;
        this.uname = uname;
        this.upwd = upwd;
        this.sex = sex;
        this.age = age;
        this.deptId = deptId;
    }
}
