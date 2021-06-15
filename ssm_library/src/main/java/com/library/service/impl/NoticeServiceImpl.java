package com.library.service.impl;

import com.library.dao.NoticeDao;
import com.library.model.Notice;
import com.library.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class NoticeServiceImpl implements NoticeService {
    @Autowired
    private NoticeDao noticeDao;
    @Override
    public List<Notice> getNoticeList() {
        List<Notice> notices = noticeDao.getNoticeList();
        return notices;
    }

    @Override
    public boolean insertNotice(Notice notice) {
        boolean isInsert = noticeDao.insertNotice(notice);
        return isInsert;
    }

    @Override
    public boolean DeleteOne(int nid) {
        boolean isDelete = noticeDao.DeleteOne(nid);
        return isDelete;
    }

    @Override
    public Notice getNoticeById(int nid) {
        Notice notice = noticeDao.getNoticeById(nid);
        return notice;
    }

    @Override
    public boolean updateNoticeCount(int nid) {
        boolean isUpdate = noticeDao.updateNoticeCount(nid);
        return isUpdate;
    }

    @Override
    public Notice getNewNotice() {
        Notice notice = noticeDao.getNewNotice();
        return notice;
    }
}
