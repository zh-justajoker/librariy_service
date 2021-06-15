package com.library.controller;

import com.library.model.Book;
import com.library.model.Msg;
import com.library.model.Root;
import com.library.service.RootService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Controller
@RequestMapping("/root")
public class RootController {
    @Autowired
    private RootService rootService;

    @RequestMapping("/login")
    public String login(@RequestParam("rname") String rname, @RequestParam("rpwd") String rpwd,
                        HttpServletRequest req, HttpServletResponse res) throws IOException {
        Root root = rootService.login(rname,rpwd);
        if (root != null && root.getRname() != null) {
           res.sendRedirect(req.getContextPath()+"/pages/mainpage.jsp");
        } else {
            res.sendRedirect(req.getContextPath()+"/pages/login.jsp?rtnCode=500");
        }
        return null;
    }
    // 退出
    @RequestMapping(value = "/loginOut", method = { RequestMethod.GET, RequestMethod.POST })
    public String loginOut() {
        return "redirect:/pages/login.jsp";
    }

    //判断旧密码是否正确
    @ResponseBody
    @RequestMapping(value = "/checkPwd",method = RequestMethod.POST)
    public Msg checkuser(@RequestParam("rpwd")String rpwd){
        //数据库条形码重复校验
        Root root = rootService.getPwd(rpwd);
        if(root != null){
            return Msg.success();
        }else{
            return Msg.fail().add("va_msg", "旧密码错误");
        }
    }

    //修改密码
    @RequestMapping(value="/uprpwd",method=RequestMethod.POST)
    @ResponseBody
    public Msg upBookState(@RequestParam("rpwd" )String rpwd){
        System.out.println("新密码："+rpwd);
        if (rootService.updatePwd(rpwd)){
            return Msg.success();
        }
        else {
            return Msg.fail();
        }

    }
}
