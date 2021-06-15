package com.library.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.library.model.Book;
import com.library.model.BookClass;
import com.library.model.Borrow;
import com.library.model.Msg;
import com.library.service.BookService;
import com.library.service.BorrowService;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.io.File;
import java.util.*;

@Controller
@RequestMapping("/borrow")
public class BorrowController {
    @Autowired
    private BorrowService borrowService;

    //查询图书列表
    @RequestMapping(value = "/getlist",method = RequestMethod.GET)
    @ResponseBody
    public Msg getBorrowWithJson(
            @RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 10);
        // startPage后面紧跟的这个查询就是一个分页查询
        List<Borrow> borrows = borrowService.getBorrowList();
        PageInfo page = new PageInfo(borrows, 10);
        return Msg.success().add("borrowInfo", page);
    }

    //根据条形码查图书
    @RequestMapping(value = "/getbyId/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getBorrowById(@PathVariable("id")int id) {
        Borrow borrow = borrowService.getBorrowById(id);
        return Msg.success().add("borrowbyid", borrow);
    }

    //用户查找我的借阅
    @RequestMapping(value = "/getMyBorrow/{uno}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getMyBorrow(@PathVariable("uno")String uno) {
        List<Borrow> borrows = borrowService.getMyBorrow(uno);
        return Msg.success().add("myBorrow", borrows);
    }

    //用户查找借阅历史
    @RequestMapping(value = "/getBorrowHis/{uno}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getBorrowHis(@PathVariable("uno")String uno) {
        List<Borrow> borrows = borrowService.getBorrowHis(uno);
        return Msg.success().add("borrowHis", borrows);
    }

    //修改图书信息
    @RequestMapping(value="/upBorrow1/{bid}",method=RequestMethod.PUT)
    @ResponseBody
    public Msg upBorrow1(@PathVariable("bid")int bid){
        Borrow borrow = borrowService.getBorrowById(bid);
        borrow.setState(1);
        Long btime = System.currentTimeMillis();
        borrow.setBtime(btime);
        borrowService.updateBorrow(borrow);
        String btxm = borrow.getBtxm();
        borrowService.updateBookState(btxm,1);
        return Msg.success();
    }
    //修改图书信息
    @RequestMapping(value="/upBorrow2/{bid}",method=RequestMethod.PUT)
    @ResponseBody
    public Msg upBorrow2(@PathVariable("bid")int bid){
        Borrow borrow = borrowService.getBorrowById(bid);
        borrow.setState(2);
        Long btime = System.currentTimeMillis();
        borrow.setBtime(btime);
        borrowService.updateBorrow(borrow);
        String btxm = borrow.getBtxm();
        borrowService.updateBookState(btxm,0);
        return Msg.success();
    }

    //添加借阅信息
    @RequestMapping(value="/addBorrow",method=RequestMethod.POST)
    @ResponseBody
    public Msg addBorrow(Borrow borrow){
        List<Borrow> borrows = borrowService.getBorrowHis(borrow.getUno());
        int count = 0;
        for (Borrow br : borrows){
            if (br.getState()==0 || br.getState()==1){
                count+=1;
            }
        }
        if (count<15){
            borrowService.insertBorrow(borrow);
            return Msg.success();
        }
        else {
            return Msg.fail();
        }

    }

    //删除一个
    @RequestMapping(value="/deleteOne/{id}",method=RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteOne(@PathVariable("id")int id){
        System.out.println("要删除的id为："+id);
        borrowService.DeleteOne(id);
        return Msg.success();
    }

    @RequestMapping("/borrowSearch")
    @ResponseBody
    public Msg searchUsers(@RequestParam("content") String content){
        System.out.println(content);
        PageHelper.startPage(1, 1000000);
        List<Borrow> borrows = borrowService.getBorrowSearchList(content);
        PageInfo pageInfo = new PageInfo(borrows,5);
        return Msg.success().add("pageInfo", pageInfo);
    }

}
