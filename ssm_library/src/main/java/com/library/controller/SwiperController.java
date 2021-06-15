package com.library.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.library.model.Msg;
import com.library.model.Notice;
import com.library.model.Swiper;
import com.library.service.SwiperService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/swiper")
public class SwiperController {
    @Autowired
    private SwiperService swiperService;
    //查询轮播图列表
    @RequestMapping(value = "/getlist",method = RequestMethod.GET)
    @ResponseBody
    public Msg getDeptWithJson(
            @RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 1000);
        List<Swiper> swiperList = swiperService.getSwiperList();
        PageInfo page = new PageInfo(swiperList, 5);
        return Msg.success().add("swiperInfo", page);
    }

    //根据条id查轮播图
    @RequestMapping(value = "/getbyId/{sid}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getNoticeById(@PathVariable("sid")int sid) {
        Swiper swiper = swiperService.getSwiperById(sid);
        return Msg.success().add("swiperbyid", swiper);
    }

    //修改轮播图
    @RequestMapping(value="/upSwiper/{sid}",method=RequestMethod.PUT)
    @ResponseBody
    public Msg upSwiper(Swiper swiper){
        System.out.println(swiper.getSwUrl());
        swiperService.updateSwiper(swiper.getSid(),swiper.getSwUrl());
        return Msg.success();
    }
}
