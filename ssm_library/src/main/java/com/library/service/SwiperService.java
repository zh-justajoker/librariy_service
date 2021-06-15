package com.library.service;

import com.library.model.Swiper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SwiperService {
    public List<Swiper> getSwiperList();

    public Swiper getSwiperById(int sid);

    public boolean updateSwiper(int sid,String swUrl);
}
