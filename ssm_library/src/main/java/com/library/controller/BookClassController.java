package com.library.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.library.model.Book;
import com.library.model.BookClass;
import com.library.model.Msg;
import com.library.service.BookClassService;
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
@RequestMapping("/bookClass")
public class BookClassController {
    @Autowired
    private BookClassService bookClassService;
    //查询图书分类列表
    @RequestMapping(value = "/getlist",method = RequestMethod.GET)
    @ResponseBody
    public Msg getBookWithJson(
            @RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 1000);
        // startPage后面紧跟的这个查询就是一个分页查询
        List<BookClass> bookClassList = bookClassService.getBookClassList();
        PageInfo page = new PageInfo(bookClassList, 5);
        return Msg.success().add("bookClassInfo", page);
    }
    //判断分类ID是否可用
    @ResponseBody
    @RequestMapping(value = "/checkClassId",method = RequestMethod.POST)
    public Msg checkClassId(@RequestParam("classId")int classId){
        System.out.println("要添加的分类编号为："+classId);
        //数据库重复校验
        List<Book> books = bookClassService.getBookByClassId(classId);
        if(books.size() == 0){
            return Msg.success();
        }else{
            return Msg.fail().add("va_msg", "分类ID不可用");
        }
    }
    //添加图书信息
    @RequestMapping(value="/addBookClass",method=RequestMethod.POST)
    @ResponseBody
    public Msg addBookClass(@Valid BookClass bookClass, BindingResult result){
        if(result.hasErrors()){
            //校验失败，应该返回失败，在模态框中显示校验失败的错误信息
            Map<String, Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors) {
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        }else{
            bookClassService.insertBookClass(bookClass);
            return Msg.success();
        }

    }
    //删除一个
    @RequestMapping(value="/deleteOne/{id}",method=RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteOne(@PathVariable("id")int id){
        System.out.println("要删除的分类编号为："+id);
        List<Book> books = bookClassService.getBookByClassId(id);
        if (books.size() == 0){
            bookClassService.DeleteOne(id);
            return Msg.success();
        }
        else {
            return Msg.fail();
        }

    }
}
