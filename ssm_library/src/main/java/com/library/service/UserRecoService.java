package com.library.service;

import com.library.model.UrCount;
import com.library.model.UserRecomend;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserRecoService {

    public UserRecomend getUserRecomendByUB(String uno,String btxm);

    public List<UserRecomend> getMyRecomendList(String uno);

    public boolean insertUserRecomend(UserRecomend UserRecomend);

    public boolean DeleteUserRecomendOne(@Param("uno")String uno,@Param("btxm") String btxm);

    public UrCount getUrCountById(String btxm);

    public int getCount();

    public int getCountNum(String btxm);

    public List<UrCount> getUrCountList();

    public List<UrCount> getUrCountTwList();

    public boolean insertUrCount(String btxm);

    public boolean updateUrCount(String btxm);

    public boolean deleteUrCount(String btxm);

    public boolean deleteCountjy(String btxm);
}
