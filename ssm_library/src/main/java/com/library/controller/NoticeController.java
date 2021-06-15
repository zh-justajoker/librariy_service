package com.library.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.library.model.*;
import com.library.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/notice")
public class NoticeController {
    @Autowired
    private NoticeService noticeService;
    //查询公告列表
    @RequestMapping(value = "/getlist",method = RequestMethod.GET)
    @ResponseBody
    public Msg getNoticeWithJson(
            @RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 8);
        // startPage后面紧跟的这个查询就是一个分页查询
        List<Notice> notices = noticeService.getNoticeList();
        PageInfo page = new PageInfo(notices, 8);
        return Msg.success().add("noticeInfo", page);
    }

    //获取最新公告
    @RequestMapping(value="/getNewNotice")
    @ResponseBody
    public Msg getNewNotice(){
        Notice notice = noticeService.getNewNotice();
        if (notice!=null){
            return Msg.success().add("newNotice", notice);
        }
        else {
            return Msg.success().add("newNotice", "暂无公告");
        }

    }

    //根据id查公告详情
    @RequestMapping(value = "/getbyId/{nid}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getNoticeById(@PathVariable("nid")int nid) {
        noticeService.updateNoticeCount(nid);
        Notice notice = noticeService.getNoticeById(nid);
        return Msg.success().add("noticebyid", notice);
    }

    //添加公告信息
    @RequestMapping(value="/addNotice",method=RequestMethod.POST)
    @ResponseBody
    public Msg addNotice(@Valid Notice notice, BindingResult result){
        if(result.hasErrors()){
            //校验失败，应该返回失败，在模态框中显示校验失败的错误信息
            Map<String, Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors) {
                System.out.println("错误的字段名："+fieldError.getField());
                System.out.println("错误信息："+fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        }else{
            Long nowTime = System.currentTimeMillis();
            notice.setNtime(nowTime);
            noticeService.insertNotice(notice);
            return Msg.success();
        }

    }
    //删除一个
    @RequestMapping(value="/deleteOne/{id}",method=RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteOne(@PathVariable("id")int id){
        System.out.println("要删除的公告编号为："+id);
        if (noticeService.DeleteOne(id)){
            return Msg.success();
        }
        return Msg.fail();
    }
}
