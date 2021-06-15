package com.library.service.impl;

import com.library.dao.FeedBackDao;
import com.library.model.FeedBack;
import com.library.service.FeedBackService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class FeedBackServiceImpl implements FeedBackService {
    @Autowired
    private FeedBackDao feedBackDao;
    @Override
    public List<FeedBack> getFeedBackList() {
        List<FeedBack> feedBackList = feedBackDao.getFeedBackList();
        return feedBackList;
    }

    @Override
    public List<FeedBack> getFeedBackByUno(String uno) {
        List<FeedBack> feedBacks =feedBackDao.getFeedBackByUno(uno);
        return feedBacks;
    }

    @Override
    public FeedBack getFeedById(int fid) {
        FeedBack feedBack = feedBackDao.getFeedById(fid);
        return feedBack;
    }

    @Override
    public boolean updateFeedBack(Long ftime, String reply, int fid) {
        boolean isUpdate = feedBackDao.updateFeedBack(ftime,reply,fid);
        return isUpdate;
    }

    @Override
    public boolean insertFeedBack(FeedBack feedBack) {
        boolean isInsert = feedBackDao.insertFeedBack(feedBack);
        return isInsert;
    }

    @Override
    public boolean DeleteOne(int fid) {
        boolean isDelete = feedBackDao.DeleteOne(fid);
        return isDelete;
    }
}
