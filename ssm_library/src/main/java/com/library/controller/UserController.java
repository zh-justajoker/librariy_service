package com.library.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.library.model.Dept;
import com.library.model.Msg;
import com.library.model.Root;
import com.library.model.User;
import com.library.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;


    //小程序端用户登录
    @RequestMapping(value = "/login",method = RequestMethod.POST)
    @ResponseBody
    public Msg login(@RequestParam("uno") String uno,@RequestParam("upwd") String upwd) {
        User user = userService.userLogin(uno,upwd);
        if (user != null && user.getUno() != null) {
            System.out.println(user.getUno());
            return Msg.success().add("user",user);
        } else {
            return Msg.fail();
        }
    }

    //查询用户列表
    @RequestMapping(value = "/getlist",method = RequestMethod.GET)
    @ResponseBody
    public Msg getUserWithJson(
            @RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 5);
        // startPage后面紧跟的这个查询就是一个分页查询
        List<User> users = userService.getUserList();
        // 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了。
        // 封装了详细的分页信息,包括有我们查询出来的数据，传入连续显示的页数
        PageInfo page = new PageInfo(users, 5);

        return Msg.success().add("userInfo", page);
    }
    //根据学号查用户
    @RequestMapping(value = "/getbyId/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getUserById(@PathVariable("id")String id) {
        User user = userService.getUserById(id);
        return Msg.success().add("userbyid", user);
    }
    //返回所有院系信息
    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts(){
        List<Dept> list = userService.getDeptList();
        return Msg.success().add("depts",list);
    }

    //修改用户信息
    @RequestMapping(value="/upUser/{uno}",method=RequestMethod.PUT)
    @ResponseBody
    public Msg upUser(User user, HttpServletRequest request){
        System.out.println("请求体中的值："+request.getParameter("sex"));
        System.out.println("将要更新的用户数据："+user.getDeptId());
        userService.updateUser(user);
        return Msg.success();
    }
    //判断学号是否可用
    @ResponseBody
    @RequestMapping(value = "/checkuser",method = RequestMethod.POST)
    public Msg checkuser(@RequestParam("uno")String uno){
        //先判断学号是否是合法的表达式;
        String regx = "(^[0-9]{6,16}$)";
        if(!uno.matches(regx)){
            return Msg.fail().add("va_msg", "学号必须是6-16位数字");
        }

        //数据库学号重复校验
        User b = userService.getUserById(uno);
        if(b == null){
            return Msg.success();
        }else{
            return Msg.fail().add("va_msg", "学号不可用");
        }
    }
    //添加用户信息
    @RequestMapping(value="/addUser",method=RequestMethod.POST)
    @ResponseBody
    public Msg addUser(@Valid User user, BindingResult result){
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
            System.out.println(userService.insertUser(user));

            return Msg.success();
        }

    }

    //删除一个
    @RequestMapping(value="/deleteOne/{id}",method=RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteOne(@PathVariable("id")String id){
        System.out.println("要删除的学号为："+id);
        userService.DeleteOne(id);
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
                System.out.println("要删除的学号为："+id);
                userService.DeleteOne(id);
            }
        }else{
            System.out.println(ids);
            userService.DeleteOne(ids);
        }

        return Msg.success();
    }


    @RequestMapping("/userSearch")
    @ResponseBody
    public Msg searchUsers(@RequestParam("content") String content){
        System.out.println(content);
        PageHelper.startPage(1, 1000000);
        List<User> users = userService.getUserSearchList(content);
        PageInfo pageInfo = new PageInfo(users,5);

        return Msg.success().add("pageInfo", pageInfo);
    }

    //修改用户密码
    @RequestMapping(value = "/modifyPwd",method = RequestMethod.POST)
    @ResponseBody
    public Msg modifyPwd(@RequestParam("uno") String uno,@RequestParam("upwd") String upwd) {
        System.out.println("将要更新的新密码为："+upwd);
        if (userService.modifyPwd(uno,upwd)) {
            return Msg.success();
        } else {
            return Msg.fail();
        }
    }

}
