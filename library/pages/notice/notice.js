// pages/notice/notice.js
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
    noticeList:[],
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    this.getNoticeList();
  },
  async getNoticeList(){
    const res = await request({
      url: "/notice/getlist/",
      header: {
        'content-type': 'application/json'
      },
    });
    if(res.extend.noticeInfo.list.length>0){
      for(var i =0; i< res.extend.noticeInfo.list.length; i++){
        var time =  res.extend.noticeInfo.list[i]["ntime"];
        res.extend.noticeInfo.list[i]["ntime"] = ss.tsFormatTime(time, 'Y-M-D h:m')
      }
    }
    console.log(res.extend.noticeInfo.list);
    this.setData({
      noticeList: res.extend.noticeInfo.list
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