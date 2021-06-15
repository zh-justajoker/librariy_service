// pages/noticeDetail/noticeDetail.js
var ss= require("../../utils/util.js");
import {
  request
} from "../../request/index";
import regeneratorRuntime from '../../lib/runtime/runtime';
Page({

  /**
   * 页面的初始数据
   */
  data: {
    noticeInfo:{},
    nId: 0,
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    const {nid} = options;
    this.setData({
      nId:nid
    });
    this.getNoticeInfo(parseInt(nid));
  },

  async getNoticeInfo(nid){
    const res = await request({
      url: "/notice/getbyId/"+nid,
      header: {
        'content-type': 'application/json'
      },
    });
    var time =  res.extend.noticebyid["ntime"];
    res.extend.noticebyid["ntime"] = ss.tsFormatTime(time, 'Y-M-D h:m:s');
    console.log(res);
    this.setData({
      noticeInfo:res.extend.noticebyid
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