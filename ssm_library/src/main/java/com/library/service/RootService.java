package com.library.service;

import com.library.model.Root;
import org.apache.ibatis.annotations.Param;

public interface RootService {
    // 登录
    public Root login(String rname, String rpwd);

    public Root getPwd(String rpwd);

    public boolean updatePwd(String rpwd);
}
