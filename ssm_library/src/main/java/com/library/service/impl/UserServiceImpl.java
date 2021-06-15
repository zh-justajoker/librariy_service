package com.library.service.impl;

import com.library.dao.UserDao;
import com.library.model.Dept;
import com.library.model.User;
import com.library.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;

    @Override
    public User userLogin(String uno, String upwd) {
        User user = userDao.userLogin(uno,upwd);
        return user;
    }


    @Override
    public List<User> getUserList() {
        List<User> userList = userDao.getUserList();
        return userList;
    }

    @Override
    public User getUserById(String uno) {
        User user = userDao.getUserById(uno);
        return user;
    }

    @Override
    public List<Dept> getDeptList() {
        List<Dept> depts = userDao.getDeptList();
        return depts;
    }

    @Override
    public boolean updateUser(User user) {
        boolean isUpdate = userDao.updateUser(user);
        return isUpdate;
    }

    @Override
    public boolean insertUser(User user) {
        boolean isInsert = userDao.insertUser(user);
        return isInsert;
    }

    @Override
    public boolean DeleteOne(String uno) {
        boolean isDeleteOne = userDao.DeleteOne(uno);
        return isDeleteOne;
    }

    @Override
    public List<User> getUserSearchList(String content) {
        List<User> userList = userDao.getUserSearchList(content);
        return userList;
    }

    @Override
    public boolean modifyPwd(String uno, String upwd) {
        boolean isModify = userDao.modifyPwd(uno,upwd);
        return isModify;
    }
}
