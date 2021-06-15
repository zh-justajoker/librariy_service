// pages/feedback/feedDetail/feedDetail.js
var ss= require("../../../utils/util.js");
import {
  request
} from "../../../request/index";
import regeneratorRuntime from '../../../lib/runtime/runtime';
Page({

  /**
   * 页面的初始数据
   */
  data: {
    feedInfo:{},
    fid:0,
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    const {fid} = options;
    this.setData({
      fId:fid
    });
    this.getFeedBackInfo(fid);
  },
  async getFeedBackInfo(fid){
    const res = await request({
      url: "/feedback/getbyId/"+fid,
      header: {
        'content-type': 'application/json'
      },
    });
    var time =  res.extend.feedbackbyid["ftime"];
    res.extend.feedbackbyid["ftime"] = ss.tsFormatTime(time, 'Y-M-D h:m:s');
    console.log(res);
    this.setData({
      feedInfo:res.extend.feedbackbyid
    })
  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {

  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {

  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide: function () {

  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload: function () {

  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {

  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {

  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {

  }
})