package com.library.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.library.model.*;
import com.library.service.BookService;
import com.library.service.UserService;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/book")
public class BookController {
    @Autowired
    private BookService bookService;

    //查询图书列表
    @RequestMapping(value = "/getlist",method = RequestMethod.GET)
    @ResponseBody
    public Msg getBookWithJson(
            @RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 8);
        List<Book> books = bookService.getBookList();

        PageInfo page = new PageInfo(books, 8);
        return Msg.success().add("bookInfo", page);
    }
    //根据条形码查图书
    @RequestMapping(value = "/getbyId/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getBookById(@PathVariable("id")String id) {
        Book book = bookService.getBookById(id);
        return Msg.success().add("bookbyid", book);
    }

    //返回所有分类信息
    @RequestMapping("/bookClass")
    @ResponseBody
    public Msg getBookClass(){
        List<BookClass> bookClassList = bookService.getBookClassList();
        return Msg.success().add("bookClass",bookClassList);
    }

    //返回所有分类信息
    @RequestMapping("/bookClassify")
    @ResponseBody
    public Msg getBookClassify(){
        List<BookClassify> bookClassifies = new ArrayList<BookClassify>();
        for (int i=0;i<=9;i++){
            BookClassify bookClassify = bookService.getBookClassify(i);
            bookClassifies.add(bookClassify);
        }
        return Msg.success().add("bookClassify",bookClassifies);
    }
    //修改图书状态
    @RequestMapping(value="/upBookState",method=RequestMethod.POST)
    @ResponseBody
    public Msg upBookState(@RequestParam("btxm" )String btxm,@RequestParam("state")int state){
        System.out.println(state);
        bookService.updateBookState(btxm,state);
        return Msg.success();
    }

    //修改图书信息
    @RequestMapping(value="/upBook/{btxm}",method=RequestMethod.PUT)
    @ResponseBody
    public Msg upBook(Book book,HttpServletRequest request){
        System.out.println("请求体中的值："+request.getParameter("bname"));
        System.out.println("将要更新的图书图片："+book.getBookImg());
        bookService.updateBook(book);
        return Msg.success();
    }
    //判断条形码是否可用
    @ResponseBody
    @RequestMapping(value = "/checkBook",method = RequestMethod.POST)
    public Msg checkuser(@RequestParam("btxm")String btxm){
        //数据库条形码重复校验
        Book b = bookService.getBookById(btxm);
        if(b == null){
            return Msg.success();
        }else{
            return Msg.fail().add("va_msg", "条形码不可用");
        }
    }
    //添加图书信息
    @RequestMapping(value="/addBook",method=RequestMethod.POST)
    @ResponseBody
    public Msg addBook(@Valid Book book, BindingResult result){
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
            System.out.println(book.getBookImg());
            bookService.insertBook(book);
            return Msg.success();
        }

    }

    //删除一个
    @RequestMapping(value="/deleteOne/{id}",method=RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteOne(@PathVariable("id")String id){
        System.out.println("要删除的条形码为："+id);
        bookService.DeleteOne(id);
        return Msg.success();
    }

    //批量删除
    @RequestMapping(value="/deleteMore/{ids}",method=RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteMore(@PathVariable("ids")String ids){
        if(ids.contains("-")){
            List<String> del_ids = new ArrayList<>();
            String[] str_ids = ids.split("-");
            //组装id的集合
            for (String string : str_ids) {
                del_ids.add(string);
            }
            for (String id : del_ids){
                System.out.println("要删除的条形码为："+id);
                bookService.DeleteOne(id);
            }
        }else{
            System.out.println(ids);
            bookService.DeleteOne(ids);
        }

        return Msg.success();
    }


    @RequestMapping("/bookSearch")
    @ResponseBody
    public Msg searchUsers(@RequestParam("content") String content){
        System.out.println(content);
        PageHelper.startPage(1, 1000000);
        List<Book> books = bookService.getBookSearchList(content);
        PageInfo pageInfo = new PageInfo(books,5);
        return Msg.success().add("pageInfo", pageInfo);
    }

    // 上传图片
    @RequestMapping(value = "/upload",method = RequestMethod.POST)
    @ResponseBody
    public Msg upload(HttpServletRequest request) throws Exception{
        MultipartHttpServletRequest mreq = (MultipartHttpServletRequest)request;
        MultipartFile file = mreq.getFile("file");
        String file_path = "E:\\File\\uploadImg\\";
        String fileName = file.getOriginalFilename();
        String newFileName = UUID.randomUUID() + fileName.substring(fileName.lastIndexOf("."));
        File newFile = new File(file_path + newFileName);
        FileOutputStream fos = new FileOutputStream(newFile);
        fos.write(file.getBytes());
        fos.flush();
        fos.close();
        return Msg.success().add("imgPath","/upload/"+newFileName);
    }

}
