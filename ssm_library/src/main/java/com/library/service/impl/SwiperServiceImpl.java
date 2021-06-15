package com.library.service.impl;

import com.library.dao.SwiperDao;
import com.library.model.Swiper;
import com.library.service.SwiperService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SwiperServiceImpl implements SwiperService {
    @Autowired
    private SwiperDao swiperDao;
    @Override
    public List<Swiper> getSwiperList() {
        List<Swiper> swipers = swiperDao.getSwiperList();
        return swipers;
    }

    @Override
    public Swiper getSwiperById(int sid) {
        Swiper swiper = swiperDao.getSwiperById(sid);
        return swiper;
    }

    @Override
    public boolean updateSwiper(int sid, String swUrl) {
        boolean isUpdate = swiperDao.updateSwiper(sid,swUrl);
        return false;
    }
}
