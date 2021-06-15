package com.library.service;

import com.library.dao.SysRecoDao;
import com.library.model.SysRecommend;

import java.util.List;

public interface SysRecoService {
    public boolean insertBook(String btxm);

    public List<SysRecommend> getSysRecoList();

    public SysRecommend getSysRecommendById(String btxm);

    public int getSysRecoCount();

    public boolean DeleteOne(String btxm);
}
