package com.library.service.impl;

import com.library.dao.SysRecoDao;
import com.library.model.SysRecommend;
import com.library.service.SysRecoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SysRecoServiceImpl implements SysRecoService {
    @Autowired
    private SysRecoDao sysRecoDao;

    @Override
    public boolean insertBook(String btxm) {
        boolean isInsert = sysRecoDao.insertBook(btxm);
        return isInsert;
    }

    @Override
    public List<SysRecommend> getSysRecoList() {
        List<SysRecommend> sysRecoDaos = sysRecoDao.getSysRecoList();
        return sysRecoDaos;
    }

    @Override
    public SysRecommend getSysRecommendById(String btxm) {
        SysRecommend sysRecommend = sysRecoDao.getSysRecommendById(btxm);
        return sysRecommend;
    }

    @Override
    public int getSysRecoCount() {
        int count = sysRecoDao.getSysRecoCount();
        return count;
    }

    @Override
    public boolean DeleteOne(String btxm) {
        boolean isDelete = sysRecoDao.DeleteOne(btxm);
        return isDelete;
    }
}
