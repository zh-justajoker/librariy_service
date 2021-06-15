package com.library.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.library.model.Book;
import com.library.model.BookClass;
import com.library.model.Msg;
import com.library.model.SysRecommend;
import com.library.service.BookService;
import com.library.service.SysRecoService;
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
@RequestMapping("/sysReco")
public class SysRecoController {
    @Autowired
    private SysRecoService sysRecoService;
    @Autowired
    private BookService bookService;

    @RequestMapping(value="/addSysreco/{ids}",method=RequestMethod.POST)
    @ResponseBody
    public Msg addSysreco(@PathVariable("ids")String ids){
        if(ids.contains("-")){
            List<String> del_ids = new ArrayList<>();
            String[] str_ids = ids.split("-");
            //组装id的集合
            for (String string : str_ids) {
                del_ids.add(string);
            }
            for (String id : del_ids){
                System.out.println("要推荐的图书条形码为："+id);
                if (sysRecoService.getSysRecommendById(id) != null){
                    return Msg.success().add("overstep","不能重复推荐，请检查系统推荐列表");
                }
                else {
                    if (sysRecoService.getSysRecoCount()>=30){
                        return Msg.success().add("overstep","最多推荐30本书！！！");
                    }
                    else{
                        sysRecoService.insertBook(id);
                    }
                }

            }
        }else{
            System.out.println("要推荐的图书条形码为："+ids);
            if (sysRecoService.getSysRecommendById(ids) != null){
                return Msg.success().add("overstep","不能重复推荐，请检查系统推荐列表");
            }
            else {
                if (sysRecoService.getSysRecoCount()>=30){
                    return Msg.success().add("overstep","最多推荐30本书！！！");
                }
                else {
                    sysRecoService.insertBook(ids);
                }
            }
        }

        return Msg.success();

    }

    //查询图书列表
    @RequestMapping(value = "/getlist",method = RequestMethod.GET)
    @ResponseBody
    public Msg getBookWithJson(
            @RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 1000);
        // startPage后面紧跟的这个查询就是一个分页查询
        List<SysRecommend> sysRecommends = sysRecoService.getSysRecoList();
        PageInfo page = new PageInfo(sysRecommends, 5);
        return Msg.success().add("bookInfo", page);
    }
    //用户查看推荐
    @RequestMapping(value = "/getsysRecolist/{deptId}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getsysRecolist(@PathVariable("deptId")int deptId) {
        List<SysRecommend> sysRecommends = sysRecoService.getSysRecoList();
        List<SysRecommend> recommendList = new ArrayList<SysRecommend>();
        for (SysRecommend sysRecommend : sysRecommends){
            int bclass = bookService.bclass(sysRecommend.getBtxm());
            switch (deptId){
                case 0:
                    if (bclass ==6){
                        recommendList.add(sysRecommend);
                    }
                    break;
                case 1:
                    if (bclass ==7){
                        recommendList.add(sysRecommend);
                    }
                    break;
                case 2:
                    if (bclass ==8){
                        recommendList.add(sysRecommend);
                    }
                    break;
                case 3:
                    if (bclass ==0){
                        recommendList.add(sysRecommend);
                    }
                    break;
            }
            if (bclass ==4 || bclass==9){
                recommendList.add(sysRecommend);
            }
        }
        return Msg.success().add("sysreco", recommendList);
    }

    //删除一个
    @RequestMapping(value="/deleteOne/{id}",method=RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteOne(@PathVariable("id")String id){
        System.out.println("要删除的条形码为："+id);
        sysRecoService.DeleteOne(id);
        return Msg.success();
    }

}
