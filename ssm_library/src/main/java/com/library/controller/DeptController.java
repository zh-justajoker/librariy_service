package com.library.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.library.model.Book;
import com.library.model.BookClass;
import com.library.model.Dept;
import com.library.model.Msg;
import com.library.service.DeptService;
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
@RequestMapping("/dept")
public class DeptController {
    @Autowired
    private DeptService deptService;
    //查询系部列表
    @RequestMapping(value = "/getlist",method = RequestMethod.GET)
    @ResponseBody
    public Msg getDeptWithJson(
            @RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 1000);
        // startPage后面紧跟的这个查询就是一个分页查询
        List<Dept> deptList = deptService.getDeptList();
        PageInfo page = new PageInfo(deptList, 5);
        return Msg.success().add("deptInfo", page);
    }
    //判断系部ID是否可用
    @ResponseBody
    @RequestMapping(value = "/checkDeptId",method = RequestMethod.POST)
    public Msg checkDeptId(@RequestParam("id")int id){
        System.out.println("要添加的分类编号为："+id);
        //数据库重复校验
        List<Dept> depts = deptService.getDeptById(id);
        if(depts.size() == 0){
            return Msg.success();
        }else{
            return Msg.fail().add("va_msg", "院系ID不可用");
        }
    }
    //添加系部信息
    @RequestMapping(value="/addDept",method=RequestMethod.POST)
    @ResponseBody
    public Msg addDept(@Valid Dept dept, BindingResult result){
        if(result.hasErrors()){
            //校验失败，应该返回失败，在模态框中显示校验失败的错误信息
            Map<String, Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors) {
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        }else{
            deptService.insertDept(dept);
            return Msg.success();
        }

    }
    //删除一个
    @RequestMapping(value="/deleteOne/{id}",method=RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteOne(@PathVariable("id")int id){
        System.out.println("要删除的系部编号为："+id);
        List<Dept> depts = deptService.getDeptById(id);
        if (depts.size() == 0){
            deptService.DeleteOne(id);
            return Msg.success();
        }
        else {
            return Msg.fail();
        }

    }
}
