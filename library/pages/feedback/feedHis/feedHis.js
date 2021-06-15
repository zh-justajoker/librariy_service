// pages/feedback/feedHis/feedHis.js
const app = getApp()
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
    uno:'',
    feedHis0:[],
    feedHis1:[],
    tabs:[
      {
        id:0,
        value:'未回复',
        isActive:true
      },
      {
        id:1,
        value:'已回复',
        isActive:false
      },
    ],
  },
  

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    this.setData({
      uno: app.globalData.userInfo.uno,
    });
    let uno = this.data.uno;
    this.getFeedHis(uno);
  },
  async getFeedHis(uno){
    const res = await request({
      url: "/feedback/getMyFeedback/"+uno,
      header: {
        'content-type': 'application/json'
      },
    });
    console.log(res);
    var feedHis0 = [];
    var feedHis1 = [];
    if(res.extend.myFeedback.length>0){
      for(var i =0; i< res.extend.myFeedback.length; i++){
        var fime =  res.extend.myFeedback[i]["ftime"];
        var state = res.extend.myFeedback[i]["state"];
        res.extend.myFeedback[i]["ftime"] = ss.tsFormatTime(fime, 'Y-M-D h:m')
        if(state == 0){
          feedHis0.push(res.extend.myFeedback[i]);
        }
        else if(state == 1){
          feedHis1.push(res.extend.myFeedback[i]);
        }
      }
    }
    this.setData({
      feedHis0: feedHis0,
      feedHis1: feedHis1,
    })
  },

  handleTabsItemChange(e){
    const {index} = e.detail;
    let {tabs} = this.data;
    tabs.forEach((v,i)=>i===index?v.isActive=true:v.isActive=false);
    this.setData({
      tabs
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