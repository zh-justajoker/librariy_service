package com.library.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.library.model.*;
import com.library.service.FeedBackService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/feedback")
public class FeedBackController {
    @Autowired
    private FeedBackService feedBackService;

    //查询反馈列表
    @RequestMapping(value = "/getlist",method = RequestMethod.GET)
    @ResponseBody
    public Msg getFeedBackWithJson(
            @RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 8);
        List<FeedBack> feedBacks = feedBackService.getFeedBackList();
        PageInfo page = new PageInfo(feedBacks, 8);
        return Msg.success().add("feedbackInfo", page);
    }
    //用户查找我的反馈
    @RequestMapping(value = "/getMyFeedback/{uno}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getMyFeedback(@PathVariable("uno")String uno) {
        List<FeedBack> feedBacks = feedBackService.getFeedBackByUno(uno);
        return Msg.success().add("myFeedback", feedBacks);
    }

    //根据id查反馈详情
    @RequestMapping(value = "/getbyId/{fid}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getNoticeById(@PathVariable("fid")int fid) {
        FeedBack feedBack = feedBackService.getFeedById(fid);
        return Msg.success().add("feedbackbyid", feedBack);
    }


    //添加反馈
    @RequestMapping(value="/addFeedback",method=RequestMethod.POST)
    @ResponseBody
    public Msg addFeedback(FeedBack feedBack){
        feedBackService.insertFeedBack(feedBack);
        return Msg.success();
    }

    @RequestMapping(value="/replyFeed/{fid}",method=RequestMethod.PUT)
    @ResponseBody
    public Msg searchUsers( @PathVariable("fid")int fid,@RequestParam("reply") String reply){
        Long ftime = System.currentTimeMillis();
        feedBackService.updateFeedBack(ftime,reply,fid);
        return Msg.success();
    }

    //删除一个
    @RequestMapping(value="/deleteOne/{fid}",method=RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteOne(@PathVariable("fid")int fid){
        System.out.println("要删除的id为："+fid);
        feedBackService.DeleteOne(fid);
        return Msg.success();
    }
}
