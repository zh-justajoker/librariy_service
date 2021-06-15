package com.library.service;

import com.library.model.Dept;

import java.util.List;

public interface DeptService {
    public List<Dept> getDeptList();

    public List<Dept> getDeptById(int id);

    public boolean insertDept(Dept dept);

    public boolean DeleteOne(int id);
}
