package com.library.service;

import com.library.model.BookClassify;
import com.library.model.Dept;
import com.library.model.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserService {
    public User userLogin(String uno,String upwd);

    public List<User> getUserList();

    public User getUserById(String uno);

    public List<Dept> getDeptList();

    public boolean updateUser(User user);

    public boolean insertUser(User user);

    public boolean DeleteOne(String uno);

    public List<User> getUserSearchList(String content);

    public boolean modifyPwd(String uno, String upwd);
}
