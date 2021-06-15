package com.library.service;

import com.library.model.FeedBack;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface FeedBackService {
    public List<FeedBack> getFeedBackList();

    public List<FeedBack> getFeedBackByUno(String uno);

    public FeedBack getFeedById(int fid);

    public boolean updateFeedBack(@Param("ftime")Long ftime, @Param("reply") String reply, @Param("fid") int fid);

    public boolean insertFeedBack(FeedBack FeedBack);

    public boolean DeleteOne(int fid);
}
