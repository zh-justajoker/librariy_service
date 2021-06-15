package com.library.service.impl;

import com.library.dao.DeptDao;
import com.library.model.Dept;
import com.library.service.DeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DeptServiceImpl implements DeptService {
    @Autowired
    private DeptDao deptDao;
    @Override
    public List<Dept> getDeptList() {
        List<Dept> depts = deptDao.getDeptList();
        return depts;
    }

    @Override
    public List<Dept> getDeptById(int id) {
        List<Dept> depts = deptDao.getDeptById(id);
        return depts;
    }

    @Override
    public boolean insertDept(Dept dept) {
        boolean isInsert = deptDao.insertDept(dept);
        return isInsert;
    }

    @Override
    public boolean DeleteOne(int id) {
        boolean isDelete = deptDao.DeleteOne(id);
        return isDelete;
    }
}
