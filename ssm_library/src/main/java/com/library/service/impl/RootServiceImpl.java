package com.library.service.impl;

import com.library.dao.RootDao;
import com.library.model.Root;
import com.library.service.RootService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("rootservice")
public class RootServiceImpl implements RootService {
    @Autowired
    private RootDao rootDao;

    @Override
    public Root login(String rname, String rpwd) {
        Root root = rootDao.login(rname,rpwd);
        return root;
    }

    @Override
    public Root getPwd(String rpwd) {
        Root root = rootDao.getPwd(rpwd);
        return root;
    }

    @Override
    public boolean updatePwd(String rpwd) {
        boolean isUpdate = rootDao.updatePwd(rpwd);
        return isUpdate;
    }
}
