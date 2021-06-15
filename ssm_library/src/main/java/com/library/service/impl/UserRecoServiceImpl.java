package com.library.service.impl;

import com.library.dao.UserRecoDao;
import com.library.model.UrCount;
import com.library.model.UserRecomend;
import com.library.service.UserRecoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserRecoServiceImpl implements UserRecoService {
    @Autowired
    private UserRecoDao userRecoDao;

    @Override
    public UserRecomend getUserRecomendByUB(String uno, String btxm) {
        UserRecomend userRecomend = userRecoDao.getUserRecomendByUB(uno,btxm);
        return userRecomend;
    }

    @Override
    public List<UserRecomend> getMyRecomendList(String uno) {
        List<UserRecomend> userRecomends = userRecoDao.getMyRecomendList(uno);
        return userRecomends;
    }

    @Override
    public boolean insertUserRecomend(UserRecomend UserRecomend) {
        boolean isInsert = userRecoDao.insertUserRecomend(UserRecomend);
        return isInsert;
    }

    @Override
    public boolean DeleteUserRecomendOne(String uno, String btxm) {
        boolean isDelete = userRecoDao.DeleteUserRecomendOne(uno,btxm);
        return isDelete;
    }

    @Override
    public UrCount getUrCountById(String btxm) {
        UrCount urCount = userRecoDao.getUrCountById(btxm);
        return urCount;
    }

    @Override
    public int getCount() {
        int count = userRecoDao.getCount();
        return count;
    }

    @Override
    public int getCountNum(String btxm) {
        int count = userRecoDao.getCountNum(btxm);
        return count;
    }

    @Override
    public List<UrCount> getUrCountList() {
        List<UrCount> urCounts = userRecoDao.getUrCountList();
        return urCounts;
    }

    @Override
    public List<UrCount> getUrCountTwList() {
        List<UrCount> urCounts = userRecoDao.getUrCountTwList();
        return urCounts;
    }

    @Override
    public boolean insertUrCount(String btxm) {
        boolean isInsert = userRecoDao.insertUrCount(btxm);
        return isInsert;
    }

    @Override
    public boolean updateUrCount(String btxm) {
        boolean isUpdate = userRecoDao.updateUrCount(btxm);
        return isUpdate;
    }

    @Override
    public boolean deleteUrCount(String btxm) {
        boolean isDelete = userRecoDao.deleteUrCount(btxm);
        return isDelete;
    }

    @Override
    public boolean deleteCountjy(String btxm) {
        boolean isDelete = userRecoDao.deleteCountjy(btxm);
        return false;
    }
}
