// pages/feedback/myFeed/myFeed.js
const app = getApp()
import {
  request
} from "../../../request/index";
import regeneratorRuntime from '../../../lib/runtime/runtime';
Page({

  /**
   * 页面的初始数据
   */
  data: {

  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {

  },
 formSubmit: function (e) {
    let uno = app.globalData.userInfo.uno;
    let uname = app.globalData.userInfo.uname;
    var content = e.detail.value.content;
    var timestamp = Date.parse(new Date());  
    let addFeedback = {
      "uno":uno,
      "uname":uname,
      "content":content,
      "ftime":timestamp,
      "state":0
    }
    this.subFeed(addFeedback);
  },

  async subFeed(addFeedback){
    const res = await request({
      url: "/feedback/addFeedback",
      data:addFeedback,
      method:"POST",
      dataType: 'json',
      header: {
        'content-type': 'application/x-www-form-urlencoded'
      },
    });
    console.log(res);
    if (res.code == 200) {
      wx.showToast({
        title: '提交反馈失败',
        icon: 'loading',
        duration: 2000
      })
    }
    else{
      wx.showToast({
        title: '提交成功',
        icon: 'success',
        duration: 1000
      })
      wx.navigateBack();
    }
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