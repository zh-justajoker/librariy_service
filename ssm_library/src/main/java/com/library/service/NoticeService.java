package com.library.service;

import com.library.model.Notice;

import java.util.List;

public interface NoticeService {
    public List<Notice> getNoticeList();

    public Notice getNoticeById(int nid);

    public boolean insertNotice(Notice notice);

    public boolean DeleteOne(int nid);

    public boolean updateNoticeCount(int nid);

    public Notice getNewNotice();
}
