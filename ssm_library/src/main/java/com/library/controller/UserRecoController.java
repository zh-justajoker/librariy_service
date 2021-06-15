package com.library.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.library.model.*;
import com.library.service.BookService;
import com.library.service.UserRecoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/userReco")
public class UserRecoController {
    @Autowired
    private UserRecoService userRecoService;
    @Autowired
    private BookService bookService;

    @RequestMapping("/isNeedReco")
    @ResponseBody
    public Msg searchUsers(@RequestParam("uno") String uno,@RequestParam("btxm") String btxm){
        UserRecomend userRecomend = userRecoService.getUserRecomendByUB(uno,btxm);
        if (userRecomend == null){
            return Msg.success().add("'isNeed'",true);
        }
        else {
            return Msg.success().add("isNeed",false);
        }
    }

    //添加推荐
    @RequestMapping(value="/addUserReco",method= RequestMethod.POST)
    @ResponseBody
    public Msg addUserReco(UserRecomend userRecomend){
        String btxm = userRecomend.getBtxm();
        boolean isInsert = userRecoService.insertUserRecomend(userRecomend);
        if (isInsert){
            UrCount urCount = userRecoService.getUrCountById(btxm);
            if (urCount!=null){
                userRecoService.updateUrCount(btxm);
            }
            else{
                userRecoService.insertUrCount(btxm);
            }
        }
        return Msg.success();
    }

    //获取用户推荐数据
    @RequestMapping(value="/getUserRecoList/{deptId}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getUserRecoList(@PathVariable("deptId")int deptId){
        int count = userRecoService.getCount();
        if (count>=30){
            List<UrCount> urCounts = userRecoService.getUrCountTwList();
            List<UrCount> urCountList = new ArrayList<UrCount>();
            for (UrCount urCount : urCounts){
                int bclass = bookService.bclass(urCount.getBtxm());
                switch (deptId){
                    case 0:
                        if (bclass ==6){
                            urCountList.add(urCount);
                        }
                        break;
                    case 1:
                        if (bclass ==7){
                            urCountList.add(urCount);
                        }
                        break;
                    case 2:
                        if (bclass ==8){
                            urCountList.add(urCount);
                        }
                        break;
                    case 3:
                        if (bclass ==0){
                            urCountList.add(urCount);
                            break;
                        }
                }
                if (bclass ==4 || bclass==9){
                    urCountList.add(urCount);
                }
            }
            return Msg.success().add("userRecos",urCountList);
        }
        else{
            List<UrCount> urCounts = userRecoService.getUrCountList();
            List<UrCount> urCountList = new ArrayList<UrCount>();
            for (UrCount urCount : urCounts){
                int bclass = bookService.bclass(urCount.getBtxm());
                switch (deptId){
                    case 0:
                        if (bclass ==6){
                            urCountList.add(urCount);
                        }
                        break;
                    case 1:
                        if (bclass ==7){
                            urCountList.add(urCount);
                        }
                        break;
                    case 2:
                        if (bclass ==8){
                            urCountList.add(urCount);
                        }
                        break;
                    case 3:
                        if (bclass ==0){
                            urCountList.add(urCount);
                        }
                        break;
                }
                if (bclass ==4 || bclass==9){
                    urCountList.add(urCount);
                }
            }
            return Msg.success().add("userRecos",urCountList);
        }

    }
    //获取我的推荐列表
    @RequestMapping(value="/getMyRecoList/{uno}")
    @ResponseBody
    public Msg getMyRecoList(@PathVariable("uno")String uno) {
        List<UserRecomend> userRecomends = userRecoService.getMyRecomendList(uno);
        return Msg.success().add("userRecomends", userRecomends);
    }

    //添加图书信息
    @RequestMapping(value="/deleteMyre",method=RequestMethod.POST)
    @ResponseBody
    public Msg deleteMyre(@RequestParam("delMyReos")String delMyReos){
        JSONArray jsonArray= JSON.parseArray(delMyReos);
        List<DelMyReo> delMyReoList = jsonArray.toJavaList(DelMyReo.class);
        for (DelMyReo delMyReo : delMyReoList){
            String btxm = delMyReo.getBtxm();
            String uno = delMyReo.getUno();
            userRecoService.DeleteUserRecomendOne(uno,btxm);
            if (userRecoService.getCountNum(btxm)==1){
                userRecoService.deleteUrCount(btxm);
            }
            else {
                userRecoService.deleteCountjy(btxm);
            }
        }
        return Msg.success();
    }
}
